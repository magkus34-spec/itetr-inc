class /ITETR/CL_INC_OPERATIONS definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF ty_bill_item_amount_diff,
        matnr    TYPE mara-matnr,
        amount   TYPE ekpo-netwr,
        netpr    TYPE ekpo-netwr,
        po_netpr TYPE ekpo-netwr,
      END OF ty_bill_item_amount_diff .
  types:
    BEGIN OF ty_bill_item_quantity_diff,
        matnr    TYPE mara-matnr,
        quantity TYPE ekpo-netwr,
        netpr    TYPE ekpo-netwr,
        po_netpr TYPE ekpo-netwr,
      END OF ty_bill_item_quantity_diff .
  types:
    BEGIN OF ty_searched_table ,
        line TYPE c LENGTH 1024,
      END OF ty_searched_table .

  data:
    tt_searched_table    TYPE TABLE OF ty_searched_table .
  data:
    tt_bill_item_amount_diff   TYPE TABLE OF ty_bill_item_amount_diff .
  data:
    tt_bill_item_quantity_diff TYPE TABLE OF ty_bill_item_quantity_diff .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to /ITETR/CL_INC_INSTANCE .
  methods CHECK_AMOUNT_HEADER
    importing
      !IS_HEADER type /ITETR/INC_S0001
      !IT_ITEMS type /ITETR/INC_TT_T0002
      !IT_DESPT type /ITETR/INC_TT_T0003
      !IV_TEST_RUN type XFELD
    exporting
      !ET_RETURN type BAPIRET2_T .
  methods CHECK_AMOUNT_ITEM
    importing
      !IS_HEADER type /ITETR/INC_S0001
      !IT_ITEMS type /ITETR/INC_TT_T0002
      !IT_DESPT type /ITETR/INC_TT_T0003
      !IV_TEST_RUN type XFELD
    exporting
      !ET_RETURN type BAPIRET2_T .
  methods CHECK_QUANTITY_ITEM
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IT_ITEMS) type /ITETR/INC_TT_T0002 optional
      value(IT_DESPT) type /ITETR/INC_TT_T0003 optional
      value(IV_TEST_RUN) type XFELD optional
    exporting
      value(ET_RETURN) type BAPIRET2_T .
  methods FIND_VALUE
    importing
      !IV_BUKRS type BUKRS
      !IT_TABLE like TT_SEARCHED_TABLE
    exporting
      !ET_RESPONSE type /ITETR/INC_TT_SEARCHCODE_VALUE .
  methods GET_AMOUNT_BILL_ITEM_DIFF
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IT_ITEMS) type /ITETR/INC_TT_T0002 optional
      value(IT_DESPT) type /ITETR/INC_TT_T0003 optional
    exporting
      value(ET_RETURN) like TT_BILL_ITEM_AMOUNT_DIFF .
  methods GET_QUANTITY_BILL_ITEM_DIFF
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IT_ITEMS) type /ITETR/INC_TT_T0002 optional
      value(IT_DESPT) type /ITETR/INC_TT_T0003 optional
    exporting
      value(ET_RETURN) like TT_BILL_ITEM_QUANTITY_DIFF .
  methods CHECK_UPDATE_ITEM_MATERIAL
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional .
  methods CHECK_UPDATE_VENDOR
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional .
  methods CHECK_PARTIAL_RECEIPT
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IT_ITEMS) type /ITETR/INC_TT_T0002 optional
      value(IT_DESPT) type /ITETR/INC_TT_T0003 optional
    exporting
      !EV_PARTIAL_RECEIPT type BAPIUPDATE .
  methods CHECK_AND_UPDATE_OTHERS
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional .
  PROTECTED SECTION.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC_OPERATIONS IMPLEMENTATION.


  METHOD check_amount_header.
    DATA(lo_instance) = get_instance( ).

    lo_instance->check_amount_header( EXPORTING is_header   = is_header
                                                it_items    = it_items
                                                it_despt    = it_despt
                                                iv_test_run = iv_test_run
                                      IMPORTING et_return   = et_return ).

  ENDMETHOD.


  METHOD check_amount_item.
    DATA(lo_instance) = get_instance( ).

    lo_instance->check_amount_item( EXPORTING is_header   = is_header
                                              it_items    = it_items
                                              it_despt    = it_despt
                                              iv_test_run = iv_test_run
                                    IMPORTING et_return   = et_return ).

  ENDMETHOD.


  method CHECK_AND_UPDATE_OTHERS.
  endmethod.


  METHOD check_partial_receipt.
    DATA lv_partial_receipt_count TYPE i.
    CHECK it_despt IS NOT INITIAL.

    SELECT docui,
           matnr,
           item_identification,
           meins,
           SUM( menge ) AS menge,
           SUM( netwr ) AS netwr
           FROM /itetr/inc_t0002 AS t0002
           INTO TABLE @DATA(lt_invoice_item)
           WHERE docui EQ @is_header-docui
           GROUP BY docui , matnr, item_identification , meins
           ORDER BY docui , matnr.

    IF lines( it_despt ) > lines( lt_invoice_item ) .
      ev_partial_receipt = abap_true.
      EXIT.
    ENDIF.
*    LOOP AT lt_invoice_item INTO DATA(ls_invoice_item).
*      CLEAR lv_partial_receipt_count.
*      READ TABLE it_items INTO DATA(ls_po_item) WITH KEY matnr = ls_invoice_item-matnr.
*      LOOP AT it_despt INTO DATA(ls_despt) WHERE ebeln EQ ls_po_item-ebeln
*                                             AND ebelp EQ ls_po_item-ebelp.
*        lv_partial_receipt_count += 1.
*      ENDLOOP.
*      IF lv_partial_receipt_count > 1.
*        ev_partial_receipt = abap_true.
*        EXIT.
*      ENDIF.
*    ENDLOOP.
  ENDMETHOD.


  METHOD check_quantity_item.
    DATA(lo_instance) = get_instance( ).

    lo_instance->check_quantity_item( EXPORTING is_header   = is_header
                                                it_items    = it_items
                                                it_despt    = it_despt
                                                iv_test_run = iv_test_run
                                      IMPORTING et_return   = et_return ).
  ENDMETHOD.


  METHOD check_update_item_material.
    DATA lr_material TYPE RANGE OF mara-matnr.

    SELECT SINGLE docui,
                  lifnr
                  FROM /itetr/inc_t0001 AS t0001
                  INTO @DATA(ls_invoice_header)
                  WHERE docui EQ @is_header-docui.

    SELECT *
           FROM /itetr/inc_t0002 AS t0002
           INTO TABLE @DATA(lt_invoice_item)
           WHERE docui EQ @is_header-docui
             AND matnr EQ @space.

    IF sy-subrc EQ 0.
      LOOP AT lt_invoice_item ASSIGNING FIELD-SYMBOL(<ls_invoice_item>).

        CLEAR lr_material.
        lr_material = VALUE #( sign = 'I' option = 'EQ' ( low = <ls_invoice_item>-sellers_item_identify )
                                                        ( low = <ls_invoice_item>-buyers_item_identify  )
                                                        ( low = <ls_invoice_item>-name_item_identify    )
                                                        ( low = <ls_invoice_item>-item_identification   ) ).
        DELETE lr_material WHERE low EQ space.
        IF lr_material IS NOT INITIAL.

          SELECT SINGLE matnr
                        FROM mara
                        INTO @DATA(lv_material)
                        WHERE matnr IN @lr_material.
          IF sy-subrc NE 0.
            SELECT SINGLE matnr
                     FROM /itetr/inc_tmalz
                     INTO @lv_material
                    WHERE supp_matnr IN @lr_material
                      AND lifnr      EQ @ls_invoice_header-lifnr.
            IF sy-subrc NE 0.
              SELECT SINGLE matnr
                       FROM eina
                       INTO @lv_material
                      WHERE idnlf IN @lr_material.
            ENDIF.
          ENDIF.
          IF lv_material IS NOT INITIAL.
            <ls_invoice_item>-matnr = lv_material.
          ENDIF.
          CLEAR lv_material.

        ENDIF.
      ENDLOOP.
      IF lt_invoice_item IS NOT INITIAL.
        MODIFY /itetr/inc_t0002 FROM TABLE lt_invoice_item.
      ENDIF.
      COMMIT WORK.
    ENDIF.
    CLEAR: lt_invoice_item.
  ENDMETHOD.


  METHOD check_update_vendor.
    CHECK is_header-lifnr IS INITIAL AND is_header-taxid IS NOT INITIAL.

    SELECT SINGLE lifnr,
                  name1
             FROM lfa1
             INTO @DATA(ls_lfa1)
             WHERE ( stcd2 EQ @is_header-taxid OR stcd3 EQ @is_header-taxid ).
    IF sy-subrc EQ 0.
      UPDATE /itetr/inc_t0001 SET   lifnr = ls_lfa1-lifnr
                                    name1 = ls_lfa1-name1
                              WHERE docui EQ is_header-docui.

      COMMIT WORK AND WAIT.
    ENDIF.

ENDMETHOD.


  METHOD find_value.
    DATA(lo_instance) = get_instance( ).

    lo_instance->find_value( EXPORTING iv_bukrs    = iv_bukrs
                                       it_table    = it_table
                             IMPORTING et_response = et_response ).


*
*    TYPES : BEGIN OF ty_lookfor,
*              value(255),
*            END OF ty_lookfor.
*
*    CONSTANTS lc_special_characters TYPE char30 VALUE '!@#$%^&*()_-+[]{}|;:",.<>?/`~\'.
*    DATA : lv_num_check.
*    DATA : lv_number_value(100).
*    DATA : lv_number(100).
*    DATA : lv_number_s(100).
*
*    DATA : lt_result_tab TYPE match_result_tab,
*           ls_result_tab LIKE LINE OF lt_result_tab.
*
*    DATA : lr_lookfor TYPE RANGE OF /itetr/inc_prefx-lookfor,
*           lr_pattern TYPE RANGE OF /itetr/inc_pfcnd-pattern,
*           rs_lookfor LIKE LINE OF lr_lookfor,
*           rs_pattern LIKE LINE OF lr_pattern.
*
*    DATA : lt_table LIKE tt_searched_table.
*    DATA : lt_lookfor TYPE TABLE OF ty_lookfor,
*           ls_lookfor TYPE ty_lookfor.
*
*    DATA: lv_index    TYPE i,
*          lv_index2   TYPE i,
*          lv_index3   TYPE i,
*          lv_length   TYPE i,
*          lv_length1  TYPE i,
*          lv_length2  TYPE i,
*          lv_lengthva TYPE i,
*          lv_char     TYPE c,
*          lv_char2    TYPE string,
*          lv_char3    TYPE string,
*          lv_num      TYPE i.
*
*    DATA : lv_text(500).
*    DATA : lv_tabix TYPE sy-tabix.
*    DATA : lv_tax_id TYPE char32.
*    DATA : lv_char_control TYPE char1 VALUE '#'.
*
*
*    SELECT *
*           INTO TABLE @DATA(lt_prefix)
*           FROM /itetr/inc_prefx
*           WHERE bukrs = @iv_bukrs.
*    IF sy-subrc IS NOT INITIAL OR iv_bukrs IS INITIAL.
*      SELECT *
*             INTO TABLE lt_prefix
*             FROM /itetr/inc_prefx.
*    ENDIF.
*
*    SELECT search_code
*           FROM /itetr/inc_prefx
*           INTO TABLE @DATA(lt_search)
*           WHERE bukrs = @iv_bukrs.
*
*    IF sy-subrc IS NOT INITIAL OR iv_bukrs IS INITIAL.
*      SELECT search_code
*             FROM /itetr/inc_prefx
*             INTO TABLE lt_search .
*    ENDIF.
*
*    SORT lt_search ASCENDING BY search_code.
*
*    DELETE ADJACENT DUPLICATES FROM lt_search COMPARING ALL FIELDS.
*
*    SELECT *
*           FROM /itetr/inc_pfcnd
*           INTO TABLE @DATA(lt_prefix_condition)
*           WHERE bukrs = @iv_bukrs.
*
*    IF sy-subrc IS NOT INITIAL OR iv_bukrs IS INITIAL.
*      SELECT * FROM /itetr/inc_pfcnd
*               INTO TABLE lt_prefix_condition .
*    ENDIF.
*
*    lt_table[] = it_table[].
*    LOOP AT lt_table INTO DATA(ls_table).
*
*      TRANSLATE ls_table-line TO UPPER CASE.
*      CLEAR sy-subrc.
*      DO.
*        REPLACE space WITH '#' INTO ls_table-line.
*        IF sy-subrc NE 0.
*          EXIT.
*        ENDIF.
*      ENDDO.
*      MODIFY lt_table FROM ls_table.
*    ENDLOOP.
*
*    LOOP AT lt_search INTO DATA(ls_search).
*      CLEAR lv_num_check.
*
*      CLEAR: lr_lookfor, lr_lookfor[] , lt_lookfor[].
*
*      LOOP AT lt_prefix INTO DATA(ls_prefix) WHERE search_code = ls_search-search_code.
*        rs_lookfor-sign = 'I'.
*        rs_lookfor-option = 'CP'.
*        rs_lookfor-low = ls_prefix-lookfor.
*        APPEND rs_lookfor TO lr_lookfor.
*        ls_lookfor-value = ls_prefix-lookfor.
*        REPLACE ALL OCCURRENCES OF '*' IN ls_lookfor-value WITH ''.
*        CONDENSE ls_lookfor-value NO-GAPS.
*        APPEND ls_lookfor TO lt_lookfor.
*      ENDLOOP.
*
*      DATA lv_i TYPE i.
*      CLEAR lv_i.
*
*      DO 2 TIMES.
*
*        lv_i = lv_i + 1.
*
*        IF lv_i = 1.
*          lv_num_check = 'X'.
*        ELSE.
*          CLEAR lv_num_check .
*        ENDIF.
*
*        READ TABLE lt_prefix_condition INTO DATA(ls_prefix_condition) WITH KEY search_code = ls_search-search_code
*                                                                               num_check = lv_num_check.
*        IF sy-subrc IS NOT INITIAL.
*          CHECK 1 = 2.
*        ENDIF.
*
*
*        LOOP AT lt_table INTO ls_table WHERE line IN lr_lookfor.
*
*          CLEAR : lt_result_tab[],lv_length, lv_index,lv_number, lv_char, lv_number_value.
*
*          IF lv_num_check IS NOT INITIAL.
*
*            LOOP AT lt_lookfor INTO ls_lookfor.
*              CLEAR : lt_result_tab[],lv_length, lv_index,lv_number, lv_char, lv_text.
*              CLEAR lt_result_tab[].
*              FIND ALL OCCURRENCES OF ls_lookfor-value IN ls_table-line RESULTS lt_result_tab.
*              CHECK lt_result_tab[] IS NOT INITIAL.
*
**              READ TABLE lt_result_tab INTO ls_result_tab INDEX 1.
*              LOOP AT lt_result_tab INTO ls_result_tab.
*                CLEAR: lv_index , lv_length , lv_lengthva , lv_index2 , lv_char2 , lv_number , lv_char.
*                IF sy-subrc IS INITIAL.
*
*                  lv_index = ls_result_tab-offset.
*                  lv_length = strlen( ls_table-line ).
*                  lv_lengthva = strlen( ls_lookfor-value ).
*                  IF ls_lookfor-value(lv_lengthva) CO '0123456789'.
*                    IF lv_index GE 2.
*                      lv_index2 = lv_index - 2.
*                      lv_char2 = ls_table-line+lv_index2(2).
*                      IF lv_char2 CO '0123456789'.
*                        lv_index = lv_index2.
*                      ENDIF.
*                    ENDIF.
*                  ENDIF.
*                  CLEAR lv_lengthva.
*                  DO lv_length TIMES.
*                    IF lv_length = lv_index.
*                      EXIT.
*                    ENDIF.
*                    lv_char = ls_table-line+lv_index(1).
*                    TRY .
*                        lv_num = lv_char."was a number
*                        CONCATENATE lv_number lv_char INTO lv_number.
*                        CONDENSE lv_number NO-GAPS.
*                      CATCH cx_sy_conversion_no_number.
*
*                        IF lv_number IS NOT INITIAL.
*                          IF lv_char CO sy-abcde.
*                            CLEAR lv_number..
*                          ENDIF.
*                          EXIT.
*                        ENDIF.
*                    ENDTRY.
*                    ADD 1 TO lv_index.
*                  ENDDO.
*                ENDIF.
*                CLEAR lv_number_s.
*                lv_number_s = lv_number.
*                LOOP AT lt_prefix_condition INTO ls_prefix_condition WHERE search_code = ls_search-search_code
*                                                                       AND num_check = lv_num_check.
*
*                  IF ls_prefix_condition-num_check IS NOT INITIAL.
*                    SHIFT lv_number LEFT DELETING LEADING '0'.
*                    IF lv_number IS NOT INITIAL.
*                      lv_length1 = strlen( lv_number_s ).
*
*                      IF lv_length1 BETWEEN ls_prefix_condition-min_length AND ls_prefix_condition-max_length.
*                        CLEAR: lr_pattern[], lr_pattern.
*                        rs_pattern-sign = 'I'.
*                        rs_pattern-option = 'CP'.
*                        rs_pattern-low = ls_prefix_condition-pattern.
*
*                        APPEND rs_pattern TO lr_pattern.
*
*                        IF lv_number IN lr_pattern.
*                          lv_number_value = lv_number_s.
*
*                          IF lv_number_value IS NOT INITIAL.
*                            APPEND INITIAL LINE TO et_response ASSIGNING FIELD-SYMBOL(<ls_response>).
*                            <ls_response>-search_code = ls_search-search_code.
*                            <ls_response>-svalue      = lv_number_value.
*                          ENDIF.
*
*                        ENDIF.
*
*                      ENDIF.
*                    ENDIF.
*
*                  ELSE.
*                    lv_number_value = lv_number_s.
*
*                    IF lv_number_value IS NOT INITIAL.
*                      APPEND INITIAL LINE TO et_response ASSIGNING <ls_response>.
*                      <ls_response>-search_code = ls_search-search_code.
*                      <ls_response>-svalue      = lv_number_value.
*                    ENDIF.
*
*                  ENDIF.
*
*                ENDLOOP.
*
*              ENDLOOP.
*
*            ENDLOOP.
*
*          ELSE.
*
*            LOOP AT lt_lookfor INTO ls_lookfor.
*
*              CLEAR : lt_result_tab[],lv_length, lv_index,lv_number, lv_char, lv_text.
*              CLEAR lt_result_tab[].
*              FIND ALL OCCURRENCES OF ls_lookfor-value IN ls_table-line RESULTS lt_result_tab.
*
*              CHECK lt_result_tab[] IS NOT INITIAL.
*
**              READ TABLE lt_result_tab INTO ls_result_tab INDEX 1.
*              LOOP AT lt_result_tab INTO ls_result_tab.
**                READ TABLE lt_prefix_condition INTO ls_prefix_condition WITH KEY search_code    = ls_search-search_code
**                                                                                 num_check = lv_num_check.
**                LOOP AT lt_prefix_condition INTO ls_prefix_condition WHERE search_code = ls_search-search_code
**                                                                       AND num_check   = lv_num_check.
*                LOOP AT lt_prefix_condition INTO ls_prefix_condition WHERE search_code    = ls_search-search_code
*                                                                       AND num_check = lv_num_check.
*
*                  CLEAR: lv_index , lv_length , lv_lengthva.
*                  lv_index = ls_result_tab-offset.
*                  lv_length = strlen( ls_table-line ).
*                  lv_lengthva = strlen( ls_lookfor-value ).
*
*                  CLEAR lv_index3.
*                  CLEAR lv_lengthva.
*                  DO ls_prefix_condition-max_length TIMES.
*                    ADD 1 TO lv_index3.
*                    IF lv_length = lv_index.
*                      EXIT.
*                    ENDIF.
*                    CLEAR lv_char.
*                    lv_char = ls_table-line+lv_index(1).
*                    IF lv_char EQ cl_abap_char_utilities=>cr_lf+1.
*                      EXIT.
*                    ENDIF.
*                    IF lv_char CA lc_special_characters.
*                      IF lv_char NA ls_prefix_condition-special_characters.
*                        EXIT.
*                      ENDIF.
*                    ENDIF.
*                    CONCATENATE lv_number lv_char INTO lv_number.
*                    CONDENSE lv_number NO-GAPS.
*                    ADD 1 TO lv_index.
*                    IF ls_prefix_condition-max_length = lv_index3.
*                      EXIT.
*                    ENDIF.
*                  ENDDO.
*
*                  CLEAR lv_number_s.
*
*                  lv_number_s = lv_number.
*                  CLEAR lv_number.
*
**                LOOP AT lt_prefix_condition INTO ls_prefix_condition WHERE search_code    = ls_search-search_code
**                                                                       AND num_check = lv_num_check.
*
**                  IF lv_number IS NOT INITIAL.
*                  IF lv_number_s IS NOT INITIAL.
*
*                    lv_length1 = strlen( lv_number_s ).
*
*                    IF lv_length1 BETWEEN ls_prefix_condition-min_length AND ls_prefix_condition-max_length.
*
*                      CLEAR: lr_pattern[], lr_pattern.
*
*                      rs_pattern-sign = 'I'.
*                      rs_pattern-option = 'CP'.
*                      rs_pattern-low = ls_prefix_condition-pattern.
*
*                      APPEND rs_pattern TO lr_pattern.
*
*                      IF lv_number_s IN lr_pattern.
*                        lv_number_value = lv_number_s.
*
*                        IF lv_number_value IS NOT INITIAL.
*
*                          IF ls_prefix_condition-svalue IS NOT INITIAL.
*                            lv_number_value = ls_prefix_condition-svalue.
*                          ENDIF.
*                          DO.
*                            REPLACE '#' WITH space  INTO lv_number_value.
*                            IF sy-subrc NE 0.
*                              EXIT.
*                            ENDIF.
*                          ENDDO.
*                          APPEND INITIAL LINE TO et_response ASSIGNING <ls_response>.
*                          <ls_response>-search_code = ls_search-search_code.
*                          <ls_response>-svalue      = lv_number_value.
*                        ENDIF.
*
*                      ENDIF.
*
*                    ENDIF.
*                  ENDIF.
*                ENDLOOP.
*
*              ENDLOOP.
*
*            ENDLOOP.
*          ENDIF.
*
*        ENDLOOP.
*        IF et_response[] IS NOT INITIAL.
*          EXIT.
*        ENDIF.
*      ENDDO.
*
*    ENDLOOP.
*
*    DELETE ADJACENT DUPLICATES FROM et_response COMPARING ALL FIELDS.
*    CLEAR: lt_prefix , lt_prefix_condition.
  ENDMETHOD.


  METHOD get_amount_bill_item_diff.
    DATA(lo_instance) = get_instance( ).

    lo_instance->get_amount_bill_item_diff(  EXPORTING is_header = is_header
                                                       it_items  = it_items
                                                       it_despt  = it_despt
                                             IMPORTING et_return = et_return ).

*    TYPES : BEGIN OF ty_t0002,
*              matnr TYPE ekpo-matnr,
*              wepos TYPE ekpo-wepos,
*              xblnr TYPE ekbe-xblnr,
*              waers TYPE ekbe-waers,
*              shkzg TYPE ekbe-shkzg,
*              dmbtr TYPE ekbe-dmbtr,
*              netwr TYPE ekpo-netwr,
*              menge TYPE ekpo-menge,
*            END OF ty_t0002.
*
*    DATA: lt_t0002 TYPE TABLE OF ty_t0002.
*    DATA: lv_wrbtr TYPE wrbtr.
*    DATA: lv_difference TYPE wrbtr.
*
*    CHECK it_items IS NOT INITIAL.
*
*    SELECT ekpo~matnr,
*           ekpo~wepos,
**           ekbe~xblnr,
*           ekbe~waers,
*           SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~dmbtr
*                                WHEN 'H' THEN ekbe~dmbtr * -1 END ) AS dmbtr,
**             SUM( ekpo~netwr ) AS netwr,
*           SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~menge
*                                WHEN 'H' THEN ekbe~menge * -1 END ) AS menge
*
*           FROM @it_items AS mt_t0002
*           INNER JOIN ekpo ON ekpo~ebeln EQ mt_t0002~ebeln
*                          AND ekpo~ebelp EQ mt_t0002~ebelp
*           LEFT OUTER JOIN ekbe ON ekpo~ebeln EQ ekbe~ebeln
*                               AND ekpo~ebelp EQ ekbe~ebelp
*                               AND ekbe~xblnr NE @space
*           WHERE ekbe~bewtp EQ 'E'
*           GROUP BY ekpo~matnr, ekpo~wepos , ekbe~waers
*           INTO CORRESPONDING FIELDS OF TABLE @lt_t0002.
*
*    SELECT t0002~docui,
*           t0002~line,
*           t0002~matnr,
*           t0002~meins,
*           SUM( t0002~menge ) AS menge,
*           SUM( t0002~netwr ) AS netwr,
*           SUM( t0002~brtwr ) AS brtwr
*           FROM /itetr/inc_t0002 AS t0002
*           WHERE t0002~docui EQ @is_header-docui
*             AND t0002~matnr IS NOT INITIAL
*           GROUP BY t0002~docui,t0002~line,t0002~matnr,meins
*           INTO TABLE @DATA(lt_bill_item).
*
*
*    LOOP AT lt_t0002 INTO DATA(ls_t0002).
*      READ TABLE lt_bill_item INTO DATA(ls_item) WITH KEY matnr = ls_t0002-matnr.
*      IF ls_t0002-wepos EQ 'X'.
*        DATA(lv_item_amount) = ls_t0002-dmbtr.
*      ELSE.
*        lv_item_amount = ls_t0002-netwr.
*      ENDIF.
*      IF is_header-waers EQ ls_t0002-waers.
*        DATA(lv_bill_item_dmbtr) = ls_item-netwr.
*      ELSE.
*        IF is_header-kursf IS NOT INITIAL.
*          IF sy-subrc EQ 0.
*            lv_bill_item_dmbtr = ls_item-netwr * is_header-kursf.
*          ENDIF.
*        ELSE.
*          CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
*            EXPORTING
*              date             = is_header-bldat
*              foreign_amount   = is_header-dmbtr
*              foreign_currency = is_header-waers
*              local_currency   = ls_t0002-waers
*            IMPORTING
*              local_amount     = lv_wrbtr
*            EXCEPTIONS
*              no_rate_found    = 1
*              overflow         = 2
*              no_factors_found = 3
*              no_spread_found  = 4
*              derived_2_times  = 5
*              OTHERS           = 6.
*          IF sy-subrc EQ 0.
*            CLEAR lv_bill_item_dmbtr.
*            lv_bill_item_dmbtr = lv_wrbtr.
*          ENDIF.
*        ENDIF.
*      ENDIF.
*
*      lv_difference = lv_bill_item_dmbtr - lv_item_amount.
*
*      IF lv_difference > 0.
*
*        APPEND INITIAL LINE TO et_return ASSIGNING FIELD-SYMBOL(<ls_return>).
*        <ls_return>-matnr      = ls_item-matnr.
*        <ls_return>-amount     = lv_difference.
*        <ls_return>-po_netpr   = lv_item_amount / ls_t0002-menge.
*        <ls_return>-netpr      = lv_bill_item_dmbtr / ls_item-menge.
*
*        CLEAR lv_difference.
*      ENDIF.
*    ENDLOOP.
  ENDMETHOD.


  method GET_INSTANCE.
        SELECT SINGLE clsname
             FROM seometarel
            WHERE refclsname EQ '/ITETR/CL_INC_INSTANCE'
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
  endmethod.


  METHOD get_quantity_bill_item_diff.
    DATA(lo_instance) = get_instance( ).

    lo_instance->get_quantity_bill_item_diff( EXPORTING is_header = is_header               " Gelen E-Fatura - Başlık Verisi
                                                        it_items  = it_items                 " /ITETR/INC_S0002 TT
                                                        it_despt  = it_despt                 " /ITETR/INC_S0003 TT
                                              IMPORTING et_return = et_return ).
*    DATA: lv_difference TYPE wrbtr.
*    SELECT ekpo~matnr,
*           SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~menge
*                                WHEN 'H' THEN ekbe~menge * -1 END ) AS menge,
*           SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~dmbtr
*                                WHEN 'H' THEN ekbe~dmbtr * -1 END ) AS dmbtr
*           FROM @it_items AS mt_t0002
*           INNER JOIN ekpo ON ekpo~ebeln EQ mt_t0002~ebeln
*                          AND ekpo~ebelp EQ mt_t0002~ebelp
*           LEFT OUTER JOIN ekbe ON ekpo~ebeln EQ ekbe~ebeln
*                               AND ekpo~ebelp EQ ekbe~ebelp
*                               AND ekbe~xblnr NE @space
*           WHERE ekbe~bewtp EQ 'E'
*           GROUP BY ekpo~matnr
*           INTO TABLE @DATA(lt_t0002).
*
*    SELECT t0002~docui,
*           t0002~matnr,
*           t0002~meins,
*           SUM( t0002~menge ) AS menge,
*           SUM( t0002~netwr ) AS netwr
*           FROM /itetr/inc_t0002 AS t0002
*           WHERE t0002~docui EQ @is_header-docui
*             AND t0002~matnr IS NOT INITIAL
*           GROUP BY t0002~docui,t0002~line,t0002~matnr,meins
*           INTO TABLE @DATA(lt_bill_item).
*
*
*    LOOP AT lt_t0002 INTO DATA(ls_t0002).
*      READ TABLE lt_bill_item INTO DATA(ls_bill_item) WITH KEY matnr = ls_t0002-matnr.
*      lv_difference = ls_bill_item-menge - ls_t0002-menge.
*      IF lv_difference > 0 .
*
*        APPEND INITIAL LINE TO et_return ASSIGNING FIELD-SYMBOL(<ls_return>).
*        <ls_return>-matnr     = ls_bill_item-matnr.
*        <ls_return>-quantity  = lv_difference.
*        <ls_return>-netpr     = ls_bill_item-netwr / ls_bill_item-menge.
*        <ls_return>-po_netpr  = ls_t0002-dmbtr     / ls_t0002-menge.
*        CLEAR: ls_bill_item , lv_difference.
*
*      ENDIF.
*    ENDLOOP.
  ENDMETHOD.
ENDCLASS.