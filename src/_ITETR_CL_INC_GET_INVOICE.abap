class /ITETR/CL_INC_GET_INVOICE definition
  public
  final
  create public .

public section.

  data MC_LOCAL_INV_TABLE type TABNAME value '/ITETR/INV_ICINV' ##NO_TEXT.
  data MT_INV_DATA type /ITETR/INC_TT .
  data MT_ADD_FIELDS type /ITETR/INC_TT_SRCPO .
  data MT_SEARCH_TABMAP type /ITETR/INC_TT_SCMAP .
  data MT_TAX_CODE type /ITETR/INC_TT_CT02 .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to /ITETR/CL_INC_GET_INVOICE .
  methods GET_INVOICE
    exporting
      value(ET_INVOICE_DATA) type /ITETR/INC_TT .
  methods INVOICE_XML_TO_TABLE
    importing
      value(IT_INV_DATA) type /ITETR/INC_TT optional
    exporting
      value(ET_MESSAGE) type BAPIRET2_T .
protected section.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC_GET_INVOICE IMPLEMENTATION.


  METHOD get_instance.
    SELECT SINGLE clsname
         FROM seometarel
        WHERE refclsname EQ '/ITETR/CL_INC_GET_INVOICE'
         INTO @DATA(lv_clsname).
    IF sy-subrc EQ 0.
      TRY .
          CREATE OBJECT ro_instance TYPE (lv_clsname).
        CATCH cx_root INTO DATA(lx_root).
          DATA(lv_error_text) = lx_root->get_text( ).
      ENDTRY.
    ELSE.
      CREATE OBJECT ro_instance.
    ENDIF.
  ENDMETHOD.


  METHOD get_invoice.
    DATA: lr_dref     TYPE REF TO data,
          lr_grid     TYPE REF TO cl_gui_alv_grid.
    FIELD-SYMBOLS: <lt_table> TYPE ANY TABLE.

    CREATE DATA lr_dref TYPE TABLE OF (mc_local_inv_table).
    ASSIGN lr_dref->* TO <lt_table>.

    DATA(lv_where_string) = 'NOT EXISTS ( SELECT docui FROM /itetr/inc_t0001 AS t0001 WHERE t0001~docui_inv EQ inv~docui )'.
    SELECT *
      FROM (mc_local_inv_table) AS inv
      INTO CORRESPONDING FIELDS OF TABLE @<lt_table>
      WHERE (lv_where_string).

    MOVE-CORRESPONDING <lt_table> TO et_invoice_data.

    SELECT tabname,
           fieldname,
           bill_fieldname,
           character_length
           FROM /itetr/inc_srcpo
           INTO TABLE @DATA(lt_search_po_need_fields).

    SELECT bukrs,
           search_code,
           tabname,
           fieldname
           FROM /itetr/inc_scmap
           INTO TABLE @DATA(lt_search_table_map).

    SELECT *
           FROM /itetr/inc_ct02
           INTO CORRESPONDING FIELDS OF TABLE @mt_tax_code.



    MOVE-CORRESPONDING lt_search_po_need_fields[] TO mt_add_fields[].
    MOVE-CORRESPONDING lt_search_table_map        TO mt_search_tabmap[].
  ENDMETHOD.


  METHOD invoice_xml_to_table.
    DATA : lv_payable_amount   TYPE /itetr/inc_t0001-dmbtr,
           lv_goods_amount     TYPE /itetr/inc_t0001-dmbtr,
           lv_other_tax_amount TYPE /itetr/inc_t0001-dmbtr,
           lv_taxable_amount   TYPE /itetr/inc_t0001-dmbtr.

    CONSTANTS: lc_line_length  TYPE i VALUE '1024',
               lc_numeric_type TYPE dd01v-datatype VALUE 'NUMC'.
    TYPES: BEGIN OF ty_searched_table ,
             line TYPE c LENGTH 1024,
           END OF ty_searched_table .

    DATA: lv_content           TYPE xstring,
          lv_xmlstring         TYPE string,
          lt_xml_table         TYPE TABLE OF smum_xmltb,
          lt_return            TYPE TABLE OF bapiret2,
          lt_t0001             TYPE TABLE OF /itetr/inc_t0001,
          lt_t0002             TYPE TABLE OF /itetr/inc_t0002,
          lt_t0004             TYPE TABLE OF /itetr/inc_t0004,
          lt_t0006             TYPE TABLE OF /itetr/inc_t0006,
          ls_invoice           TYPE /itetr/com_message1,
          ls_doc_ref           TYPE /itetr/com_despatch_document_r,
          ls_despatch          TYPE /itetr/inc_s0004,
          ls_order             TYPE /itetr/inc_s0007,
          lx_root              TYPE REF TO cx_root,
          lv_where_string      TYPE string,
          lv_matnr             TYPE mara-matnr,
          lv_buyers_matnr      TYPE char40,
          lv_name_matnr        TYPE char40,
          lv_sellers_matnr     TYPE char40,
          lv_matnr_char        TYPE char18,
          lv_matnr_alfanumeric TYPE char40,
          lv_supp_matnr        TYPE /itetr/inc_tmalz-supp_matnr,
          lv_line              TYPE /itetr/inc_t0002-line,
          lv_order_line        TYPE /itetr/inc_t0006-line,
          lv_datatype          TYPE dd01v-datatype,
          lv_orderid           TYPE ekko-ebeln,
          lv_rate              TYPE /itetr/inc_ct02-rate.
*          lv_material_content  TYPE char50.

    DATA: lt_searched_table TYPE TABLE OF ty_searched_table,
          lt_searched_resp  TYPE /itetr/inc_tt_searchcode_value,
          lv_offset         TYPE i.

    DATA: lr_material      TYPE RANGE OF matnr,
          lr_supp_material TYPE RANGE OF matnr.

    FIELD-SYMBOLS : <lfs_t001> TYPE /itetr/inc_t0001,
                    <lfs_t002> TYPE /itetr/inc_t0002.

    MOVE-CORRESPONDING it_inv_data TO mt_inv_data.
    LOOP AT mt_inv_data INTO DATA(ls_data).

      CLEAR: lv_content.
      CALL FUNCTION '/ITETR/INC_DOWNLOAD'
        EXPORTING
          iv_document_uid = ls_data-docui
          iv_content_type = 'UBL'
          iv_bukrs        = ls_data-bukrs
          iv_duich        = ls_data-invui
        IMPORTING
          ev_document     = lv_content.

      CHECK lv_content IS NOT INITIAL.
      cl_proxy_xml_transform=>xml_xstring_to_abap(
        EXPORTING
          ddic_type               = '/ITETR/COM_MESSAGE1'
          xml                     = lv_content
          ext_xml                 = abap_true
        IMPORTING
          abap_data               = ls_invoice ).

      CLEAR lv_xmlstring.
      CALL FUNCTION 'CRM_IC_XML_XSTRING2STRING'
        EXPORTING
          inxstring = lv_content
        IMPORTING
          outstring = lv_xmlstring.


      DATA(lo_operations) = NEW /itetr/cl_inc_operations( ).

      DATA(lv_string_length) = strlen( lv_xmlstring ).

      WHILE lv_offset < lv_string_length.
        APPEND INITIAL LINE TO lt_searched_table ASSIGNING FIELD-SYMBOL(<ls_searched_table>).
        IF lv_offset + lc_line_length < lv_string_length.
          <ls_searched_table>-line = lv_xmlstring+lv_offset(lc_line_length).
        ELSE.
          DATA(lv_diff) = lv_string_length - lv_offset.
          <ls_searched_table>-line = lv_xmlstring+lv_offset(lv_diff).
        ENDIF.
        lv_offset = lv_offset + lc_line_length.
      ENDWHILE.

      CLEAR: lt_searched_resp.
      lo_operations->find_value( EXPORTING iv_bukrs    = ls_data-bukrs                  " Şirket kodu
                                           it_table    = lt_searched_table
                                 IMPORTING et_response = lt_searched_resp ).

      CLEAR: lv_offset , lv_string_length , lt_searched_table.

      APPEND INITIAL LINE TO lt_t0001 ASSIGNING <lfs_t001>.

      <lfs_t001>-docui     = ls_data-docui.
      <lfs_t001>-docui_inv = ls_data-docui.
      <lfs_t001>-bukrs     = ls_data-bukrs.
      <lfs_t001>-invui     = ls_invoice-part1-uuid-base-base-content.
      <lfs_t001>-invno     = ls_invoice-part1-id-base-base-content.
      <lfs_t001>-invqi     = ls_invoice-part1-uuid-base-base-content.
      REPLACE ALL OCCURRENCES OF '-' IN ls_invoice-part1-issue_date-base-content WITH ``.
      <lfs_t001>-gjahr     = ls_invoice-part1-issue_date-base-content(4).
      <lfs_t001>-bldat     = ls_invoice-part1-issue_date-base-content(8).
      <lfs_t001>-recdt     = ls_invoice-part1-issue_date-base-content(8).
      <lfs_t001>-waers     = ls_invoice-part1-document_currency_code-base-base-content.
      <lfs_t001>-invty     = ls_invoice-part1-invoice_type_code-base-base-content.
      <lfs_t001>-prfid     = ls_invoice-part1-profile_id-base-base-content.
      LOOP AT ls_invoice-part1-accounting_supplier_party-party-party_identification INTO DATA(ls_party_identification)
                                                                                    WHERE id-base-base-scheme_id EQ 'VKN'
                                                                                       OR id-base-base-scheme_id EQ 'TCKN'.
        <lfs_t001>-taxid     = ls_party_identification-id-base-base-content.
      ENDLOOP.
*      <lfs_t001>-taxid     = ls_invoice-part1-accounting_supplier_party-party-party_identification[ 1 ]-id-base-base-content.
*      <lfs_t001>-dmbtr     = COND #( WHEN ls_invoice-part1-legal_monetary_total-line_extension_amount-base-content > ls_invoice-part1-legal_monetary_total-payable_amount-base-content
*                                     THEN ls_invoice-part1-legal_monetary_total-tax_exclusive_amount-base-content
*                                     ELSE ls_invoice-part1-legal_monetary_total-line_extension_amount-base-content ).
      <lfs_t001>-dmbtr     = ls_invoice-part1-legal_monetary_total-tax_exclusive_amount-base-content.
      <lfs_t001>-wrbtr     = ls_invoice-part1-legal_monetary_total-payable_amount-base-content.
      <lfs_t001>-fwste     = ls_invoice-part1-legal_monetary_total-tax_inclusive_amount-base-content -
                             ls_invoice-part1-legal_monetary_total-tax_exclusive_amount-base-content.
      TRY.
          <lfs_t001>-kursf = ls_invoice-part1-pricing_exchange_rate-calculation_rate-base-base-content."Kur bilgisi eklemesi
        CATCH cx_root INTO lx_root.
          CLEAR <lfs_t001>-kursf.
      ENDTRY.

      READ TABLE ls_invoice-part1-despatch_document_reference INTO ls_doc_ref INDEX 1.
      IF sy-subrc EQ 0.
        <lfs_t001>-despid = ls_doc_ref-id-base-base-content.
        REPLACE ALL OCCURRENCES OF '-' IN ls_doc_ref-issue_date-base-content WITH space.
        <lfs_t001>-delivery_date = ls_doc_ref-issue_date-base-content.
      ENDIF.

      IF ls_invoice-part1-order_reference-id-base-base-content IS NOT INITIAL.
        <lfs_t001>-orderid = ls_invoice-part1-order_reference-id-base-base-content.
      ENDIF.

      LOOP AT ls_invoice-part1-accounting_customer_party-party-party_identification INTO DATA(ls_party).
        IF ls_party-id-base-base-content CA 'YFT'.
          <lfs_t001>-cusdn = ls_party-id-base-base-content.
        ENDIF.
      ENDLOOP.

      IF <lfs_t001>-taxid IS NOT INITIAL.
        SELECT SINGLE lifnr,
                      name1
                 FROM lfa1
                 INTO @DATA(ls_lfa1)
                 WHERE stcd2 EQ @<lfs_t001>-taxid.
        IF sy-subrc EQ 0.
          <lfs_t001>-lifnr = ls_lfa1-lifnr.
          <lfs_t001>-name1 = ls_lfa1-name1.
        ELSE.
          SELECT SINGLE lifnr,
                        name1
                   FROM lfa1
                   INTO @ls_lfa1
                   WHERE stcd3 EQ @<lfs_t001>-taxid.
          IF sy-subrc EQ 0.
            <lfs_t001>-lifnr = ls_lfa1-lifnr.
            <lfs_t001>-name1 = ls_lfa1-name1.
          ENDIF.
        ENDIF.
      ENDIF.
      CLEAR ls_lfa1.

      LOOP AT mt_search_tabmap INTO DATA(ls_search_tabmap) WHERE bukrs   EQ ls_data-bukrs
                                                             AND tabname EQ '/ITETR/INC_T0001'.

        READ TABLE lt_searched_resp INTO DATA(ls_search_resp) WITH KEY search_code = ls_search_tabmap-search_code.
        IF sy-subrc EQ 0.
          ASSIGN COMPONENT ls_search_tabmap-fieldname OF STRUCTURE <lfs_t001> TO FIELD-SYMBOL(<lv_value>).
          IF <lv_value> IS ASSIGNED.
            IF <lv_value> IS INITIAL.
              <lv_value> = ls_search_resp-svalue.
            ENDIF.
          ENDIF.
        ENDIF.

      ENDLOOP.

*      CHECK <lfs_t001>-lifnr IS NOT INITIAL.

      LOOP AT ls_invoice-part1-invoice_line INTO DATA(ls_line).

        APPEND INITIAL LINE TO lt_t0002 ASSIGNING <lfs_t002>.

        CLEAR: lv_buyers_matnr , lv_name_matnr, lv_sellers_matnr , lv_line , lv_datatype.
        lv_line           = ls_line-id-base-base-content.
        <lfs_t002>-line   = lv_line.
        <lfs_t002>-docui  = ls_data-docui.
        CALL FUNCTION 'NUMERIC_CHECK'
          EXPORTING
            string_in = ls_line-item-buyers_item_identification-id-base-base-content
          IMPORTING
            htype     = lv_datatype.

        IF lv_datatype EQ lc_numeric_type.
          lv_matnr_char    = |{ ls_line-item-buyers_item_identification-id-base-base-content ALPHA = IN }|.
          lv_buyers_matnr  = lv_matnr_char.
        ELSE.
          lv_matnr_alfanumeric  = ls_line-item-buyers_item_identification-id-base-base-content.
          lv_buyers_matnr       = lv_matnr_alfanumeric.
        ENDIF.
        <lfs_t002>-buyers_item_identify = lv_buyers_matnr.

        CLEAR: lv_matnr_alfanumeric , lv_matnr_char , lv_datatype.
        CALL FUNCTION 'NUMERIC_CHECK'
          EXPORTING
            string_in = ls_line-item-name-base-base-content
          IMPORTING
            htype     = lv_datatype.

        IF lv_datatype EQ lc_numeric_type.
          lv_matnr_char  = |{ ls_line-item-name-base-base-content ALPHA = IN }|.
          lv_name_matnr    = lv_matnr_char.
        ELSE.
          lv_matnr_alfanumeric = ls_line-item-name-base-base-content.
          lv_name_matnr        = lv_matnr_alfanumeric.
        ENDIF.
        <lfs_t002>-name_item_identify = lv_name_matnr.

        CLEAR: lv_matnr_alfanumeric , lv_matnr_char , lv_datatype.
        CALL FUNCTION 'NUMERIC_CHECK'
          EXPORTING
            string_in = ls_line-item-sellers_item_identification-id-base-base-content
          IMPORTING
            htype     = lv_datatype.

        IF lv_datatype EQ lc_numeric_type.
          lv_matnr_char    = |{ ls_line-item-sellers_item_identification-id-base-base-content ALPHA = IN }|.
          lv_sellers_matnr = lv_matnr_char.
        ELSE.
          lv_matnr_alfanumeric   = ls_line-item-sellers_item_identification-id-base-base-content.
          lv_sellers_matnr       = lv_matnr_alfanumeric.
        ENDIF.
        <lfs_t002>-sellers_item_identify = lv_sellers_matnr.

        CLEAR lr_material.
        lr_material = VALUE #( sign = 'I' option = 'EQ' ( low = lv_buyers_matnr )
                                                        ( low = lv_name_matnr )
                                                        ( low = lv_sellers_matnr ) ).
        DELETE lr_material WHERE low EQ space.
        IF lr_material IS NOT INITIAL.

          SELECT SINGLE matnr
                        FROM mara
                        INTO @DATA(lv_material)
                        WHERE matnr IN @lr_material.

          IF lv_material IS INITIAL.
            SELECT SINGLE matnr
                       FROM mara
                       INTO @lv_material
                       WHERE bismt IN @lr_material.

            IF lv_material IS INITIAL.
              SELECT SINGLE matnr
                       FROM /itetr/inc_tmalz
                       INTO @lv_material
                      WHERE supp_matnr IN @lr_material
                        AND lifnr      EQ @<lfs_t001>-lifnr.

              IF lv_material IS INITIAL.
                SELECT SINGLE matnr
                              FROM eina
                              INTO @lv_material
                              WHERE lifnr EQ @<lfs_t001>-lifnr
                                AND idnlf IN @lr_material.
              ENDIF.
            ENDIF.
          ENDIF.

        ENDIF.
        <lfs_t002>-matnr  = lv_material.
        <lfs_t002>-txz01  = ls_line-item-name-base-base-content.
        <lfs_t002>-menge = ls_line-invoiced_quantity-base-base-content.
        DATA(lv_meins)   = ls_line-invoiced_quantity-base-base-unit_code.
        IF lv_meins EQ 'C62'.
          <lfs_t002>-meins = 'ST'.
        ENDIF.

        LOOP AT ls_line-tax_total-tax_subtotal INTO DATA(ls_tax).
          CASE ls_tax-tax_category-tax_scheme-tax_type_code-base-base-content.
            WHEN '0015'."KDV
              CONDENSE ls_tax-percent-base-base-content.
              DATA(lv_percent) = ls_tax-percent-base-base-content.
              SELECT SINGLE mwskz
                     FROM /itetr/inc_ct02
                     INTO @DATA(lv_mwskz)
                     WHERE rate EQ @lv_percent.
              <lfs_t002>-mwskz = lv_mwskz.
              <lfs_t002>-rate  = lv_percent.
            WHEN '0074'.
              DATA(lv_other_tax) = ls_tax-tax_amount-base-content.
            WHEN OTHERS.
          ENDCASE.
          lv_taxable_amount = ls_tax-taxable_amount-base-content.

        ENDLOOP.
        IF lv_other_tax IS NOT INITIAL.
          lv_other_tax_amount = lv_other_tax.
          <lfs_t001>-dmbtr = <lfs_t001>-dmbtr + lv_other_tax_amount.
          <lfs_t001>-fwste = <lfs_t001>-fwste - lv_other_tax_amount.
        ENDIF.

*        <lfs_t002>-netwr = ls_line-line_extension_amount-base-content + lv_other_tax_amount.
        <lfs_t002>-netwr = COND #( WHEN lv_taxable_amount > 0 THEN lv_taxable_amount + lv_other_tax_amount
                                   ELSE ls_line-line_extension_amount-base-content + lv_other_tax_amount ).
*        <lfs_t002>-brtwr = ls_line-line_extension_amount-base-content + ls_line-tax_total-tax_amount-base-content + lv_other_tax_amount.
        <lfs_t002>-brtwr = COND #( WHEN lv_taxable_amount > 0 THEN lv_taxable_amount + ls_line-tax_total-tax_amount-base-content + lv_other_tax_amount
                                   ELSE ls_line-line_extension_amount-base-content + ls_line-tax_total-tax_amount-base-content + lv_other_tax_amount ).
        CLEAR : lv_taxable_amount , lv_other_tax , lv_other_tax_amount.

        <lfs_t002>-item_identification = ls_line-item-sellers_item_identification-id-base-base-content.

        LOOP AT mt_search_tabmap INTO ls_search_tabmap WHERE bukrs   EQ ls_data-bukrs
                                                         AND tabname EQ '/ITETR/INC_T0002'.
          CLEAR ls_search_resp.
          READ TABLE lt_searched_resp INTO ls_search_resp WITH KEY search_code = ls_search_tabmap-search_code.
          IF sy-subrc EQ 0.
            ASSIGN COMPONENT ls_search_tabmap-fieldname OF STRUCTURE <lfs_t002> TO <lv_value>.
            IF <lv_value> IS ASSIGNED.
              IF <lv_value> IS INITIAL.
                <lv_value> = ls_search_resp-svalue.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDLOOP.

        CLEAR: lv_matnr , lv_material.
      ENDLOOP.


      LOOP AT ls_invoice-part1-despatch_document_reference INTO DATA(ls_despatch_ubl).

        APPEND INITIAL LINE TO lt_t0004 ASSIGNING FIELD-SYMBOL(<ls_t0004>).
        ADD 1 TO ls_despatch-line.
        <ls_t0004>-line   = ls_despatch-line.
        <ls_t0004>-despid = ls_despatch_ubl-id-base-base-content.
        <ls_t0004>-docui  = ls_data-docui.
        <ls_t0004>-uname  = sy-uname.
        <ls_t0004>-create_date  = sy-datum.
        <ls_t0004>-create_time  = sy-uzeit.
      ENDLOOP.

      IF <lfs_t001>-orderid IS NOT INITIAL.
        lv_orderid = COND #( WHEN strlen( <lfs_t001>-orderid ) <= 10 THEN <lfs_t001>-orderid ) .
        SELECT SINGLE ebeln
                      FROM ekko
                      INTO @DATA(ls_order_check)
                      WHERE ebeln EQ @lv_orderid.
        IF sy-subrc EQ 0.
          APPEND INITIAL LINE TO lt_t0006 ASSIGNING FIELD-SYMBOL(<ls_t0006>).
          ADD 1 TO ls_order-line.
          <ls_t0006>-line         = ls_order-line.
          <ls_t0006>-docui        = ls_data-docui.
          <ls_t0006>-orderid      = <lfs_t001>-orderid.
          <ls_t0006>-uname        = sy-uname.
          <ls_t0006>-create_date  = sy-datum.
          <ls_t0006>-create_time  = sy-uzeit.
        ELSE.
          CLEAR <lfs_t001>-orderid.
        ENDIF.
      ENDIF.
*ELSE.
      IF <lfs_t001>-lifnr IS NOT INITIAL.
        SELECT ekpo~ebeln,
               ekpo~ebelp,
               ekpo~menge
          INTO TABLE @DATA(lt_ekpo)
          FROM ekko
          INNER JOIN ekpo ON ekko~ebeln = ekpo~ebeln
          LEFT JOIN  lfa1 ON lfa1~lifnr = ekko~lifnr
          WHERE ekko~lifnr = @<lfs_t001>-lifnr
            AND ekko~loekz = ''
            AND ekpo~loekz = ''.

        IF <lfs_t001>-orderid IS NOT INITIAL.
          DELETE lt_ekpo WHERE ebeln EQ <lfs_t001>-orderid.
        ENDIF.
        CLEAR lv_order_line.
        IF sy-subrc = 0.
          SORT lt_ekpo BY ebeln.
          DELETE ADJACENT DUPLICATES FROM lt_ekpo COMPARING ebeln.
          lv_order_line = lines( lt_t0006 ).
          LOOP AT lt_ekpo INTO DATA(ls_ekpo).
            FIND ls_ekpo-ebeln IN lv_xmlstring.
            CHECK sy-subrc EQ 0.
            lv_order_line += 1.
            APPEND INITIAL LINE TO lt_t0006 ASSIGNING <ls_t0006>.
            <ls_t0006>-docui       = ls_data-docui.
            <ls_t0006>-line        = lv_order_line.
            <ls_t0006>-orderid     = ls_ekpo-ebeln.
            <ls_t0006>-uname       = sy-uname.
            <ls_t0006>-create_date = sy-datum.
            <ls_t0006>-create_time = sy-uzeit.
            <lfs_t001>-orderid     = ls_ekpo-ebeln.
          ENDLOOP.
        ENDIF.
      ENDIF.
*      ENDIF.

      CLEAR lv_where_string.
      IF <lfs_t001>-orderid IS INITIAL.
        LOOP AT mt_add_fields INTO DATA(ls_field).
          ASSIGN COMPONENT ls_field-bill_fieldname OF STRUCTURE <lfs_t001> TO FIELD-SYMBOL(<lv_field_value>).
          IF lv_where_string IS INITIAL.
            IF <lv_field_value> IS ASSIGNED AND <lv_field_value> IS NOT INITIAL.
              IF ls_field-character_length IS NOT INITIAL.
                DATA(lv_value_length) = strlen( <lv_field_value> ).
                IF ls_field-character_length > lv_value_length.
                  DO ls_field-character_length - lv_value_length TIMES.
                    <lv_field_value> = '0' && <lv_field_value>.
                  ENDDO.
                ENDIF.
              ENDIF.
              lv_where_string = |{ ls_field-tabname }~{ ls_field-fieldname } EQ '{ <lv_field_value> }'|.
            ENDIF.
          ELSE.
            IF <lv_field_value> IS ASSIGNED AND <lv_field_value> IS NOT INITIAL.
              IF ls_field-character_length IS NOT INITIAL.
                lv_value_length = strlen( <lv_field_value> ).
                IF ls_field-character_length > lv_value_length.
                  DO ls_field-character_length - lv_value_length TIMES.
                    <lv_field_value> = '0' && <lv_field_value>.
                  ENDDO.
                ENDIF.
              ENDIF.
              lv_where_string = |{ lv_where_string } AND { ls_field-tabname }~{ ls_field-fieldname } EQ '{ <lv_field_value> }'|.
            ENDIF.
          ENDIF.
        ENDLOOP.

        IF lv_where_string IS NOT INITIAL.
          SELECT SINGLE vgbel
                 FROM likp
                 INNER JOIN lips ON lips~vbeln EQ likp~vbeln
                 INTO @DATA(lv_po_number)
                 WHERE (lv_where_string).
          IF sy-subrc EQ 0.
            <lfs_t001>-orderid = lv_po_number.
          ENDIF.
        ENDIF.

        IF <lfs_t001>-orderid IS NOT INITIAL.
          CLEAR ls_order.
          ADD 1 TO ls_order-line.
          APPEND INITIAL LINE TO lt_t0006 ASSIGNING <ls_t0006>.
          <ls_t0006>-line     = ls_order-line.
          <ls_t0006>-docui    = ls_data-docui.
          <ls_t0006>-orderid  = <lfs_t001>-orderid.
          <ls_t0006>-uname       = sy-uname.
          <ls_t0006>-create_date = sy-datum.
          <ls_t0006>-create_time = sy-uzeit.
        ENDIF.
      ENDIF.
      IF line_exists( lt_t0002[ docui = <lfs_t001>-docui
                                mwskz = space ] ).
        DATA(ls_tax_total_header)    = VALUE #( ls_invoice-part1-tax_total[ 1 ]       OPTIONAL ).
        DATA(ls_tax_subtotal_header) = VALUE #( ls_tax_total_header-tax_subtotal[ 1 ] OPTIONAL ).
        DATA(lv_percent_header)      = ls_tax_subtotal_header-percent-base-base-content.
        IF lv_percent_header IS NOT INITIAL.
          CONDENSE lv_percent_header.
          MOVE lv_percent_header TO lv_rate.
          READ TABLE mt_tax_code INTO DATA(ls_header_tax_code) WITH KEY rate = lv_rate.
          IF sy-subrc EQ 0.
            LOOP AT lt_t0002 ASSIGNING <lfs_t002> WHERE docui EQ <lfs_t001>-docui.
              <lfs_t002>-mwskz = ls_header_tax_code-mwskz.
              <lfs_t002>-rate  = ls_header_tax_code-rate.
            ENDLOOP.
          ENDIF.
        ENDIF.
      ENDIF.

      /itetr/cl_inc_logs=>create_single_log(
        EXPORTING
          iv_log_code    = /itetr/cl_inc_logs=>mc_log_codes-received
          iv_document_id = ls_data-docui
          iv_commit      = abap_true
      ).

      CLEAR : ls_despatch, ls_order.
    ENDLOOP.

    IF lt_t0001 IS NOT INITIAL.
      MODIFY /itetr/inc_t0001 FROM TABLE lt_t0001.
      MODIFY /itetr/inc_t0002 FROM TABLE lt_t0002.
      MODIFY /itetr/inc_t0004 FROM TABLE lt_t0004.
      MODIFY /itetr/inc_t0006 FROM TABLE lt_t0006.
      COMMIT WORK AND WAIT.
    ENDIF.
  ENDMETHOD.
ENDCLASS.