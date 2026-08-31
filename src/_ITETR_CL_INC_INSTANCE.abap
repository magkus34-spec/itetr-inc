class /ITETR/CL_INC_INSTANCE definition
  public
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
  methods CHECK_MATNR_QUANTITY_UPDATE
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IT_ITEMS) type /ITETR/INC_TT_T0002 optional
    exporting
      value(ET_RETURN) type BAPIRET2_T .
  methods GET_AMOUNT_DIFF
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IT_ITEMS) type /ITETR/INC_TT_T0002 optional
      value(IT_DESPT) type /ITETR/INC_TT_T0003 optional
    exporting
      !ET_RETURN like TT_BILL_ITEM_AMOUNT_DIFF .
  methods UPDATE_ORDER_TABLE
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IT_ITEMS) type /ITETR/INC_TT_T0002 optional
      value(IT_DESPT) type /ITETR/INC_TT_T0003 optional .
  methods UPDATE_DESPATCH_TABLE
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IT_ITEMS) type /ITETR/INC_TT_T0002 optional
      value(IT_DESPT) type /ITETR/INC_TT_T0003 optional .
  methods CHECK_POSTING_FI
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IS_POPUP_SCREEN) type /ITETR/INC_S_FIPOPUP_SCREENFLD optional
    exporting
      value(ET_RETURN) type BAPIRET2_T .
  methods POSTING_FI
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IV_TESTRUN) type CHAR1 optional
      value(IS_INPUT_SCREEN) type /ITETR/INC_S_FIPOPUP_SCREENFLD optional
    exporting
      value(ET_RETURN) type BAPIRET2_T
      value(ES_RETURN_DATA) type /ITETR/INC_S_FI_BAPI_RETURN .
  methods CALL_FI_POSTING_BAPI
    importing
      value(IS_HEADER) type /ITETR/INC_S0001 optional
      value(IS_DOCUMENT_HEADER) type BAPIACHE09 optional
      value(IV_TESTRUN) type BAPIUPDATE optional
      value(IT_ACCOUNTGL) type BAPIACGL09_TAB optional
      value(IT_ACCOUNTPAYABLE) type BAPIACAP09_TAB optional
      value(IT_CURRENCYAMOUNT) type BAPIACCR09_TAB optional
      value(IT_ACCOUNTTAX) type BAPIACTX09_TAB optional
      value(IT_ACCOUNTRECEIVE) type BAPIACAR09_TAB optional
      value(IT_CRITERIA) type BAPIACKEC9_TAB optional
    exporting
      value(ET_RETURN_MESSAGE) type BAPIRET2_T
      value(ES_RETURN_DATA) type /ITETR/INC_S_FI_BAPI_RETURN .
  PROTECTED SECTION.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC_INSTANCE IMPLEMENTATION.


  METHOD call_fi_posting_bapi.
    DATA: ls_documentheader    TYPE bapiache09,
          lt_accountgl         TYPE TABLE OF bapiacgl09,
          lt_accountpayable    TYPE TABLE OF bapiacap09,
          lt_currencyamount    TYPE TABLE OF bapiaccr09,
          lt_accounttax        TYPE TABLE OF bapiactx09,
          lt_accountreceivable TYPE TABLE OF bapiacar09,
          lt_criteria          TYPE TABLE OF bapiackec9,
          lt_return            TYPE  bapiret2_tab,
          lv_obj_type          TYPE  bapiache09-obj_type,
          lv_obj_key           TYPE  bapiache09-obj_key,
          lv_obj_sys           TYPE  bapiache09-obj_sys.

    CALL FUNCTION 'BAPI_ACC_DOCUMENT_CHECK'
      EXPORTING
        documentheader    = is_document_header
      TABLES
        accountgl         = it_accountgl
        accounttax        = it_accounttax
        accountreceivable = it_accountreceive
        accountpayable    = it_accountpayable
        currencyamount    = it_currencyamount
        criteria          = it_criteria
        return            = lt_return.

    LOOP AT lt_return INTO DATA(ls_return) WHERE type CA 'EAX'.
      APPEND INITIAL LINE TO et_return_message ASSIGNING FIELD-SYMBOL(<ls_return>).
      MOVE-CORRESPONDING ls_return TO <ls_return>.
    ENDLOOP.
    CHECK et_return_message IS INITIAL.
    IF iv_testrun EQ space.
      CLEAR: lv_obj_type , lv_obj_key, lv_obj_sys.
      CALL FUNCTION 'BAPI_ACC_DOCUMENT_POST'
        EXPORTING
          documentheader    = is_document_header
        IMPORTING
          obj_type          = lv_obj_type
          obj_key           = lv_obj_key
          obj_sys           = lv_obj_sys
        TABLES
          accountgl         = it_accountgl
          accounttax        = it_accounttax
          accountpayable    = it_accountpayable
          currencyamount    = it_currencyamount
          accountreceivable = it_accountreceive
          criteria          = it_criteria
          return            = lt_return.
      IF lv_obj_key IS NOT INITIAL.
        DATA(lv_belnr) = lv_obj_key(10).
        DATA(lv_bukrs) = lv_obj_key+10(4).
        DATA(lv_gjahr) = lv_obj_key+14(4).
        es_return_data = VALUE #( docui = is_header-docui bukrs = lv_bukrs belnr = lv_belnr gjahr = lv_gjahr ).
        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
          EXPORTING
            wait = 'X'.
      ELSE.
        LOOP AT lt_return INTO ls_return WHERE type CA 'EAX'.
          APPEND INITIAL LINE TO et_return_message ASSIGNING <ls_return>.
          MOVE-CORRESPONDING ls_return TO <ls_return>.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD check_amount_header.
    DATA: lv_item         TYPE netwr,
          lv_text         TYPE text100,
          lv_answer       TYPE c LENGTH 1,
          lv_netwr        TYPE netwr,
          lv_fark         TYPE netwr,
          ls_difft        TYPE /itetr/inc_difft,
          ls_message      TYPE /itetr/inc_messg,
          lt_message      TYPE TABLE OF /itetr/inc_messg,
          rv_wrbtr        TYPE wrbtr,
          lv_sappr_text   TYPE text255,
          lv_header_dmbtr TYPE netwr,
          lv_total_po_amt TYPE vfprc_element_amount.

    CHECK it_items IS NOT INITIAL.

    SELECT ekpo~ebeln,
           ekpo~ebelp,
           ekpo~wepos,
           despt~xblnr,
           prcd_elements~kbetr,
           prcd_elements~kpein,
           prcd_elements~waers,
           CASE WHEN prcd_elements~kkurs IS NOT INITIAL THEN prcd_elements~kkurs ELSE 1 END AS kkurs,
           CASE WHEN ekko~wkurs IS NOT INITIAL THEN ekko~wkurs ELSE 1 END AS wkurs ,
           CASE WHEN marm~umrez IS NOT INITIAL THEN marm~umrez ELSE 1 END AS umrez ,
           CASE WHEN marm~umren IS NOT INITIAL THEN marm~umren ELSE 1 END AS umren ,
           SUM( despt~stock_qty ) AS menge
           FROM @it_despt AS despt
           INNER JOIN ekpo ON ekpo~ebeln EQ despt~ebeln
                          AND ekpo~ebelp EQ despt~ebelp
           INNER JOIN ekko ON ekko~ebeln EQ ekpo~ebeln
           INNER JOIN prcd_elements ON prcd_elements~knumv EQ ekko~knumv
                                   AND substring( prcd_elements~kposn ,2,5 ) EQ ekpo~ebelp
                                   AND prcd_elements~kschl EQ 'PBXX'
           LEFT OUTER JOIN mara ON mara~matnr EQ ekpo~matnr
           LEFT OUTER JOIN marm ON marm~matnr EQ mara~matnr
                               AND marm~meinh EQ ekpo~meins
           GROUP BY ekpo~ebeln , ekpo~ebelp , ekpo~wepos , despt~xblnr , prcd_elements~kbetr , prcd_elements~kpein , prcd_elements~waers , prcd_elements~kkurs ,  ekko~wkurs , marm~umrez, marm~umren
           INTO TABLE @DATA(lt_t0002).

    SELECT ebeln,
           ebelp,
           wepos
      FROM ekpo
      INNER JOIN /itetr/inc_t0006 AS t6 ON t6~orderid EQ ekpo~ebeln
      WHERE wepos NE @space
        AND docui EQ @is_header-docui
      INTO TABLE @DATA(lt_wepos).

    IF sy-subrc NE 0.
      SELECT ebeln, ebelp, wepos
        FROM ekpo
        WHERE ebeln EQ @is_header-orderid
          AND wepos NE @space
        INTO TABLE @lt_wepos.
    ENDIF.

    READ TABLE lt_t0002 INTO DATA(ls_t0002) INDEX 1.

    CLEAR lv_total_po_amt.
    LOOP AT lt_t0002 INTO DATA(ls_despatch_info).
      IF NOT is_header-waers EQ ls_despatch_info-waers.
        CASE is_header-waers.
          WHEN 'TRY'.
            CASE ls_despatch_info-waers.
              WHEN 'TRY'.
                ls_despatch_info-kbetr = ls_despatch_info-kbetr.
              WHEN OTHERS.
                ls_despatch_info-kbetr = ls_despatch_info-kbetr * ls_despatch_info-kkurs.
            ENDCASE.
          WHEN OTHERS.
            CASE ls_t0002-waers.
              WHEN 'TRY'.
                ls_despatch_info-kbetr = ls_despatch_info-kbetr / ls_despatch_info-kkurs.
              WHEN OTHERS.
                ls_despatch_info-kbetr = ls_despatch_info-kbetr * ls_despatch_info-kkurs.
            ENDCASE.
        ENDCASE.
      ENDIF.
      lv_total_po_amt = lv_total_po_amt + ( ls_despatch_info-kbetr / ls_despatch_info-kpein  ) * ( ls_despatch_info-menge * ls_despatch_info-umren / ls_despatch_info-umrez ).
    ENDLOOP.
*    DATA(lv_total_po_amt) = REDUCE vfprc_element_amount( INIT sum_po_amount TYPE vfprc_element_amount FOR <ls_items_amount> IN lt_t0002
*                                                         NEXT sum_po_amount = sum_po_amount + ( ( <ls_items_amount>-kbetr / <ls_items_amount>-kpein  ) * ( <ls_items_amount>-menge * <ls_items_amount>-umren / <ls_items_amount>-umrez ) )  ).

    IF is_header-waers EQ ls_t0002-waers.
      lv_header_dmbtr = is_header-dmbtr.
    ELSE.
      IF is_header-kursf IS NOT INITIAL.
        lv_header_dmbtr = is_header-dmbtr * is_header-kursf.
      ELSE.
        CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
          EXPORTING
            date             = is_header-bldat
            foreign_amount   = is_header-dmbtr
            foreign_currency = is_header-waers
            local_currency   = ls_t0002-waers
          IMPORTING
            local_amount     = rv_wrbtr
          EXCEPTIONS
            no_rate_found    = 1
            overflow         = 2
            no_factors_found = 3
            no_spread_found  = 4
            derived_2_times  = 5
            OTHERS           = 6.
        IF sy-subrc EQ 0.
          lv_header_dmbtr = rv_wrbtr.
        ENDIF.
      ENDIF.
*      IF NOT ls_t0002-waers EQ 'TRY' .
*        lv_total_po_amt = lv_total_po_amt * ls_t0002-wkurs.
*      ENDIF.
    ENDIF.

    SELECT SINGLE wf_status
      FROM /itetr/inc_t0001
      INTO @DATA(lv_wf_status)
      WHERE invno = @is_header-invno.

    IF is_header-sappr EQ space OR
       is_header-sappr EQ '1'   OR
       is_header-sappr EQ '2'   OR
       is_header-sappr EQ '3'.
      IF ( lv_wf_status EQ /itetr/cl_inc_wf_operations=>mc_wf_status-approved AND lv_total_po_amt NE lv_header_dmbtr ) OR lv_wf_status EQ /itetr/cl_inc_wf_operations=>mc_wf_status-rejected AND iv_test_run IS INITIAL.

        IF is_header-invoice_type NE 'Sonradan Borclandırma'.
          IF iv_test_run IS INITIAL.

            APPEND INITIAL LINE TO et_return ASSIGNING FIELD-SYMBOL(<ls_return>).
            <ls_return>-id = '/ITETR/INC'.
            <ls_return>-type = 'E'.
            <ls_return>-number = '015'.

            SET PARAMETER ID 'RBN' FIELD is_header-orderid.
            SET PARAMETER ID 'GJR' FIELD is_header-gjahr.
*          CALL TRANSACTION 'MIRO' AND SKIP FIRST SCREEN.
            CALL FUNCTION 'ABAP4_CALL_TRANSACTION' STARTING NEW TASK 'T_MIRO'
              EXPORTING
                tcode = 'MIRO'.

            EXIT.
          ENDIF.
        ENDIF.

      ELSE.
        IF lv_total_po_amt NE lv_header_dmbtr.
          IF is_header-invoice_type NE 'Sonradan Borclandırma'.
            IF is_header-sappr EQ '5'.
              APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
              <ls_return>-id = '/ITETR/INC'.
              <ls_return>-type = 'E'.
              <ls_return>-number = '015'.

              IF iv_test_run IS INITIAL.
                SET PARAMETER ID 'RBN' FIELD is_header-orderid.
                SET PARAMETER ID 'GJR' FIELD is_header-gjahr.
*              CALL TRANSACTION 'MIRO' AND SKIP FIRST SCREEN.
                CALL FUNCTION 'ABAP4_CALL_TRANSACTION' STARTING NEW TASK 'T_MIRO'
                  EXPORTING
                    tcode = 'MIRO'.
                EXIT.
              ENDIF.
            ELSE.
*              IF iv_test_run EQ space AND lv_wf_status NE /itetr/cl_inc_wf_operations=>mc_wf_status-ready.
*                lv_text = 'Fatura dip tutarları uyuşmamaktadır. Onaya göndermek ister misiniz?'.
*                lv_answer = /itetr/cl_regulative_common=>popup_to_confirm_simple( iv_question = lv_text ).
*              ENDIF.
            ENDIF.
          ENDIF.
*          IF lv_answer EQ '1' OR iv_test_run EQ 'X'.
            SELECT SINGLE *
                     FROM /itetr/inc_eicp
                     INTO @DATA(ls_eicv)
                     WHERE bukrs = @is_header-bukrs
                       AND cuspa = 'TOLERANS'.
            IF sy-subrc EQ 0.
              lv_netwr = lv_header_dmbtr * ls_eicv-value / 100.
              IF lv_total_po_amt GT lv_header_dmbtr.
                lv_fark = lv_total_po_amt - lv_header_dmbtr.
              ELSEIF lv_header_dmbtr GT lv_total_po_amt.
                lv_fark = lv_header_dmbtr - lv_total_po_amt.
              ENDIF.
            ENDIF.

            IF lv_fark LT lv_netwr.

              IF is_header-invoice_type EQ 'Sonradan Borclandırma'.
                UPDATE /itetr/inc_t0001
                   SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                       sappr = '3'
                       staic = icon_red_light
                       invoice_err = 'Tutar farkını dağıtım yönetimi ile dağıtınız'
                 WHERE invno = is_header-invno.
                COMMIT WORK AND WAIT.

                ls_difft-docui = is_header-docui.
                ls_difft-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-amount.
                INSERT /itetr/inc_difft FROM ls_difft.

                ls_message-docui = is_header-docui.
                ls_message-message = 'Tutar Farkı'.
                APPEND ls_message TO lt_message.

              ELSE.
*                UPDATE /itetr/inc_t0001
*                   SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
*                       sappr = '3'
*                       staic = icon_red_light
*                       invoice_err = 'Dip tutar farkı, tolerans farkından azdır. Farkı dağıtım yönetimi butonuyla dağıtınız.'
*                 WHERE invno = is_header-invno.
*                COMMIT WORK AND WAIT.
*
*                ls_difft-docui = is_header-docui.
*                ls_difft-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-amount.
*                INSERT /itetr/inc_difft FROM ls_difft.
*
*                ls_message-docui = is_header-docui.
*                ls_message-message = 'Tutar Farkı'.
*                APPEND ls_message TO lt_message.

              ENDIF.

*              APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
*              <ls_return>-id = '/ITETR/INC'.
*              <ls_return>-type = 'E'.
*              <ls_return>-number = '024'.
            ELSE.

              IF is_header-invoice_type EQ 'Sonradan Borclandırma'.
                UPDATE /itetr/inc_t0001
                   SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                       sappr = '3'
                       staic = icon_red_light
                       invoice_err = 'Tutar farkını dağıtım yönetimi ile dağıtınız'
                 WHERE invno = is_header-invno.
                COMMIT WORK AND WAIT.

                ls_difft-docui = is_header-docui.
                ls_difft-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-amount.
                INSERT /itetr/inc_difft FROM ls_difft.

                ls_message-docui = is_header-docui.
                ls_message-message = 'Tutar Farkı'.
                APPEND ls_message TO lt_message.

              ELSE.

                UPDATE /itetr/inc_t0001
                   SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                       sappr = '3'
                       staic = icon_red_light
                       invoice_err = 'Fatura dip tutarları uyuşmamaktadır. Onaya gönderiniz'
                 WHERE invno = is_header-invno.
                COMMIT WORK AND WAIT.

                ls_difft-docui = is_header-docui.
                ls_difft-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-amount.
                INSERT /itetr/inc_difft FROM ls_difft.

                ls_message-docui = is_header-docui.
                ls_message-message = 'Tutar Farkı'.
                APPEND ls_message TO lt_message.
              ENDIF.

              APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
              <ls_return>-id = '/ITETR/INC'.
              <ls_return>-type = 'E'.
              <ls_return>-number = '013'.
            ENDIF.
*          ENDIF.
        ENDIF.

        SELECT SUM( menge ) AS menge
          FROM /itetr/inc_t0002
          INTO @DATA(lv_sum)
          WHERE docui EQ @is_header-docui.

        READ TABLE lt_wepos INTO DATA(ls_wepos) INDEX 1.
        DATA lv_toplam_quan TYPE nsdm_stock_qty.
        IF sy-subrc EQ 0.
          IF ls_wepos-wepos EQ abap_true AND it_despt IS NOT INITIAL.
            CLEAR lv_toplam_quan.
            LOOP AT it_despt INTO DATA(ls_despatch).
              CLEAR ls_t0002.
              READ TABLE lt_t0002 INTO ls_t0002 WITH KEY ebeln = ls_despatch-ebeln
                                                         ebelp = ls_despatch-ebelp.
              lv_toplam_quan = lv_toplam_quan + ( ls_despatch-stock_qty / ls_t0002-umren / ls_t0002-umrez ).
            ENDLOOP.
          ELSE.
            LOOP AT it_items INTO DATA(ls_item).
              CLEAR ls_t0002.
              READ TABLE lt_t0002 INTO ls_t0002 WITH KEY ebeln = ls_despatch-ebeln
                                                         ebelp = ls_despatch-ebelp.
              lv_toplam_quan = lv_toplam_quan + ( ls_item-menge / ls_t0002-umren / ls_t0002-umrez ).
            ENDLOOP.
          ENDIF.
        ENDIF.

        CHECK is_header-sappr NE '4'.

        IF lv_sum NE lv_toplam_quan.
          IF iv_test_run NE 'X'.
            IF is_header-invoice_type NE 'Sonradan Borclandırma'.
              SET PARAMETER ID 'RBN' FIELD is_header-orderid.
              SET PARAMETER ID 'GJR' FIELD is_header-gjahr.
              CALL FUNCTION 'ABAP4_CALL_TRANSACTION' STARTING NEW TASK 'T_MIRO'
                EXPORTING
                  tcode = 'MIRO'.
*            CALL TRANSACTION 'MIRO' AND SKIP FIRST SCREEN.
              lv_text = 'Fatura ile irsaliye adetleri uyuşmamaktadır. Onaya göndermek ister misiniz?'.
              lv_answer = /itetr/cl_regulative_common=>popup_to_confirm_simple( iv_question = lv_text ).
            ENDIF.
          ENDIF.
          IF lv_answer EQ '1' OR iv_test_run EQ 'X'.

            IF is_header-invoice_type EQ 'Sonradan Borclandırma'.
              UPDATE /itetr/inc_t0001
                 SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                     sappr = '3'
                     staic = icon_red_light
                     invoice_err = 'Tutar farkını dağıtım yönetimi ile dağıtınız'
               WHERE invno = is_header-invno.
              COMMIT WORK AND WAIT.

              ls_difft-docui = is_header-docui.
              ls_difft-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-quantity.
              INSERT /itetr/inc_difft FROM ls_difft.

              ls_message-docui = is_header-docui.
              ls_message-message = 'Tutar Farkı'.
              APPEND ls_message TO lt_message.

            ELSE.

              UPDATE /itetr/inc_t0001
                 SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                     sappr = '3'
                     staic = icon_red_light
                     invoice_err = 'Fatura ile irsaliye adetleri uyuşmamaktadır'
               WHERE docui = is_header-docui.
              COMMIT WORK AND WAIT.

              ls_difft-docui = is_header-docui.
              ls_difft-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-quantity.
              INSERT /itetr/inc_difft FROM ls_difft.

              ls_message-docui = is_header-docui.
              ls_message-message = 'Adet Farkı'.
              APPEND ls_message TO lt_message.

            ENDIF.

            APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
            <ls_return>-id = '/ITETR/INC'.
            <ls_return>-type = 'E'.
            <ls_return>-number = '014'.

          ELSE.
            IF is_header-invoice_type NE 'Sonradan Borclandırma'.
              APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
              <ls_return>-id = '/ITETR/REGULATIVE'.
              <ls_return>-type = 'E'.
              <ls_return>-number = '026'.
              <ls_return>-message_v1 = /itetr/cl_regulative_common=>get_data_element_text( iv_data_element = 'BUDAT' ).
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.

      IF is_header-invoice_type NE 'Sonradan Borclandırma'.
        IF lv_total_po_amt NE lv_header_dmbtr AND lv_sum NE lv_toplam_quan.
          UPDATE /itetr/inc_t0001
             SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                 sappr = '3'
                 staic = icon_red_light
                 invoice_err = 'Fatura ile irsaliye adetleri ve dip tutarları uyuşmamaktadır'
           WHERE docui = is_header-docui.
          COMMIT WORK AND WAIT.

          ls_difft-docui = is_header-docui.
          ls_difft-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-amount.
          INSERT /itetr/inc_difft FROM ls_difft.

          ls_message-docui = is_header-docui.
          ls_message-message = 'Adet Farkı'.
          APPEND ls_message TO lt_message.

          ls_message-docui = is_header-docui.
          ls_message-message = 'Tutar Farkı'.
          APPEND ls_message TO lt_message.

        ENDIF.
      ENDIF.

    ELSE.
      IF is_header-sappr EQ '4'.
        APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
        <ls_return>-id = '/ITETR/INC'.
        <ls_return>-type = 'E'.
        <ls_return>-number = '026'.
      ENDIF.
    ENDIF.

    IF lt_message[] IS NOT INITIAL.
      MODIFY /itetr/inc_messg FROM TABLE lt_message.
      COMMIT WORK AND WAIT.
    ENDIF.
  ENDMETHOD.


  METHOD check_amount_item.
    TYPES : BEGIN OF ty_t0002,
              matnr TYPE ekpo-matnr,
              wepos TYPE ekpo-wepos,
              xblnr TYPE ekbe-xblnr,
              waers TYPE ekbe-waers,
              shkzg TYPE ekbe-shkzg,
              dmbtr TYPE ekbe-dmbtr,
              netwr TYPE ekpo-netwr,
              menge TYPE ekpo-menge,
            END OF ty_t0002.

    DATA: lv_item            TYPE netwr,
          lv_text            TYPE text100,
          lv_answer          TYPE c LENGTH 1,
          lv_netwr           TYPE netwr,
          lv_fark            TYPE netwr,
          ls_difft           TYPE /itetr/inc_difft,
          ls_difit           TYPE /itetr/inc_difit,
          ls_message         TYPE /itetr/inc_messg,
          lt_message         TYPE TABLE OF /itetr/inc_messg,
          lv_wrbtr           TYPE wrbtr,
          lv_sappr_text      TYPE text255,
          lv_bill_unit_price TYPE netwr,
          lv_item_unit_price TYPE netwr,
          lr_despid          TYPE RANGE OF ekbe-xblnr,
          lt_t0002           TYPE TABLE OF ty_t0002.

    lr_despid = VALUE #( FOR ls_despatch IN it_despt
                       ( sign = 'I' option = 'EQ' low = ls_despatch-xblnr ) ).

    CHECK it_items IS NOT INITIAL.

    SELECT ekpo~matnr,
           ekpo~wepos,
           ekbe~waers,
           SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~dmbtr
                                WHEN 'H' THEN ekbe~dmbtr * -1 END ) AS dmbtr,
           SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~wrbtr
                                WHEN 'H' THEN ekbe~wrbtr * -1 END ) AS netwr,
           SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~menge
                                WHEN 'H' THEN ekbe~menge * -1 END ) AS menge
           FROM @it_items AS mt_t0002
           INNER JOIN ekpo ON ekpo~ebeln EQ mt_t0002~ebeln
                          AND ekpo~ebelp EQ mt_t0002~ebelp
           LEFT OUTER JOIN ekbe ON ekpo~ebeln EQ ekbe~ebeln
                               AND ekpo~ebelp EQ ekbe~ebelp
                               AND ekbe~xblnr NE @space
           WHERE ekbe~vgabe EQ '1'
             AND ekbe~xblnr IN @lr_despid
           GROUP BY ekpo~matnr, ekpo~wepos , ekbe~waers
           INTO CORRESPONDING FIELDS OF TABLE @lt_t0002.

    SELECT ekpo~matnr,
           ekko~waers,
           SUM( ekpo~brtwr ) AS dmbtr,
           SUM( ekpo~netwr ) AS netwr
           FROM @it_items AS mt_t0002
           INNER JOIN ekpo ON ekpo~ebeln EQ mt_t0002~ebeln
                          AND ekpo~ebelp EQ mt_t0002~ebelp
           INNER JOIN ekko ON ekko~ebeln EQ ekpo~ebeln
           WHERE ekpo~weunb EQ @abap_true
           GROUP BY ekpo~matnr,ekko~waers
           INTO TABLE @DATA(lt_po_amount).

    SELECT t0002~docui,
           t0002~line,
           t0002~matnr,
           t0002~meins,
           SUM( t0002~menge ) AS menge,
           SUM( t0002~netwr ) AS netwr,
           SUM( t0002~brtwr ) AS brtwr
           FROM /itetr/inc_t0002 AS t0002
           WHERE t0002~docui EQ @is_header-docui
           GROUP BY t0002~docui,t0002~line,t0002~matnr,meins
           INTO TABLE @DATA(lt_bill_item).

    IF line_exists( lt_bill_item[ matnr = space ] ).
      "Quantity'de t134M'ye atılan bir sorgu var. Oradaki miktar alanı dolu ise malzeme kontrolü yapacak.
      "Bu kontrol matnr ve knttp dolu için yapılacak.
      "Miktar.
      check_matnr_quantity_update( EXPORTING is_header = is_header
                                             it_items  = it_items
                                   IMPORTING et_return = et_return ).

    ENDIF.
    SELECT ebeln, ebelp, wepos
      FROM ekpo
      INNER JOIN /itetr/inc_t0006 AS t6 ON t6~orderid EQ ekpo~ebeln
*                                       AND ( t6~orderitem IS INITIAL OR t6~orderitem EQ ekpo~ebelp )
      WHERE wepos NE @space
        AND docui EQ @is_header-docui
      INTO TABLE @DATA(lt_wepos).

    IF sy-subrc NE 0.
      SELECT ebeln, ebelp, wepos
        FROM ekpo
        WHERE ebeln EQ @is_header-orderid
          AND wepos NE @space
        INTO TABLE @lt_wepos.
    ENDIF.

    LOOP AT lt_t0002 INTO DATA(ls_t0002).

      CLEAR : lv_bill_unit_price , lv_item_unit_price.
      READ TABLE lt_bill_item INTO DATA(ls_bill_item) WITH KEY matnr = ls_t0002-matnr.
      IF sy-subrc EQ 0.

        CASE is_header-waers.
          WHEN 'TRY'.
*          lv_bill_unit_price = ls_bill_item-netwr .
            lv_bill_unit_price = ls_bill_item-netwr / ls_bill_item-menge.
          WHEN OTHERS.
            lv_bill_unit_price = ls_bill_item-netwr / ls_bill_item-menge * is_header-kursf.
        ENDCASE.

        IF ls_t0002-netwr > 0.

          CASE ls_t0002-waers.
            WHEN 'TRY'.
              lv_item_unit_price = ls_t0002-netwr / ls_t0002-menge.
            WHEN OTHERS.
              lv_item_unit_price = ls_t0002-netwr / ls_t0002-menge * is_header-kursf.
          ENDCASE.
        ELSE.
          READ TABLE lt_po_amount INTO DATA(ls_po_amount) WITH KEY matnr = ls_t0002-matnr.
          IF sy-subrc EQ 0.
            CASE ls_po_amount-waers.
              WHEN 'TRY'.
                lv_item_unit_price = ls_po_amount-netwr.
              WHEN OTHERS.
                lv_item_unit_price = ls_po_amount-netwr * is_header-kursf.
            ENDCASE.
          ENDIF.
        ENDIF.
        SELECT SINGLE wf_status
          FROM /itetr/inc_t0001
          INTO @DATA(lv_wf_status)
          WHERE invno = @is_header-invno.

        IF is_header-sappr EQ space OR
           is_header-sappr EQ '1'   OR
           is_header-sappr EQ '2'   OR
           is_header-sappr EQ '3'.
          IF ( lv_wf_status EQ /itetr/cl_inc_wf_operations=>mc_wf_status-approved AND lv_item_unit_price NE lv_bill_unit_price ) OR lv_wf_status EQ /itetr/cl_inc_wf_operations=>mc_wf_status-rejected AND iv_test_run IS INITIAL.

            IF is_header-invoice_type NE 'Sonradan Borclandırma'.
              IF iv_test_run IS INITIAL.

                APPEND INITIAL LINE TO et_return ASSIGNING FIELD-SYMBOL(<ls_return>).
                <ls_return>-id     = '/ITETR/INC'.
                <ls_return>-type   = 'E'.
                <ls_return>-number = '015'.

                SET PARAMETER ID 'RBN' FIELD is_header-orderid.
                SET PARAMETER ID 'GJR' FIELD is_header-gjahr.

                CALL FUNCTION 'ABAP4_CALL_TRANSACTION' STARTING NEW TASK 'T_MIRO'
                  EXPORTING
                    tcode = 'MIRO'.

                EXIT.
              ENDIF.
            ENDIF.

          ELSE.
            IF lv_item_unit_price NE lv_bill_unit_price.
              IF is_header-invoice_type NE 'Sonradan Borclandırma'.
                IF is_header-sappr EQ '5'.
                  APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
                  <ls_return>-id     = '/ITETR/INC'.
                  <ls_return>-type   = 'E'.
                  <ls_return>-number = '015'.

                  IF iv_test_run IS INITIAL.
                    SET PARAMETER ID 'RBN' FIELD is_header-orderid.
                    SET PARAMETER ID 'GJR' FIELD is_header-gjahr.

                    CALL FUNCTION 'ABAP4_CALL_TRANSACTION' STARTING NEW TASK 'T_MIRO'
                      EXPORTING
                        tcode = 'MIRO'.
                    EXIT.
                  ENDIF.
                ELSE.
                  IF iv_test_run EQ space AND lv_wf_status NE /itetr/cl_inc_wf_operations=>mc_wf_status-ready.
                    lv_text = 'Fatura dip tutarları uyuşmamaktadır. Onaya göndermek ister misiniz?'.
                    lv_answer = /itetr/cl_regulative_common=>popup_to_confirm_simple( iv_question = lv_text ).
                    IF lv_answer NE '1'.
                      APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
                      <ls_return>-id     = '/ITETR/INC'.
                      <ls_return>-type   = 'E'.
                      <ls_return>-number = '054'.
                      EXIT.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDIF.
              IF lv_answer EQ '1' OR iv_test_run EQ 'X'.
                SELECT SINGLE *
                       FROM /itetr/inc_eicp
                       INTO @DATA(ls_eicv)
                       WHERE bukrs = @is_header-bukrs
                         AND cuspa = 'TOLERANS'.

                IF sy-subrc EQ 0.
                  lv_netwr = lv_bill_unit_price * ls_eicv-value / 100.
                  IF lv_item_unit_price GT lv_bill_unit_price.
                    lv_fark = lv_item_unit_price - lv_bill_unit_price.
                  ELSEIF lv_bill_unit_price GT lv_item_unit_price.
                    lv_fark = lv_bill_unit_price - lv_item_unit_price.
                  ENDIF.
                ENDIF.

                IF lv_fark LT lv_netwr.

                  IF is_header-invoice_type EQ 'Sonradan Borclandırma'.
                    UPDATE /itetr/inc_t0001
                       SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                           sappr       = '3'
                           staic       = icon_red_light
                           invoice_err = 'Tutar farkını dağıtım yönetimi ile dağıtınız'
                     WHERE invno = is_header-invno.
                    COMMIT WORK AND WAIT.
                  ELSE.
                    UPDATE /itetr/inc_t0001
                       SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                           sappr       = '3'
                           staic       = icon_red_light
                           invoice_err = 'Dip tutar farkı, tolerans farkından azdır. Farkı dağıtım yönetimi butonuyla dağıtınız.'
                     WHERE invno = is_header-invno.
                    COMMIT WORK AND WAIT.
                  ENDIF.

                  APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
                  <ls_return>-id     = '/ITETR/INC'.
                  <ls_return>-type   = 'E'.
                  <ls_return>-number = '024'.
                ELSE.

                  IF is_header-invoice_type EQ 'Sonradan Borclandırma'.
                    UPDATE /itetr/inc_t0001
                       SET wf_status   = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                           sappr       = '3'
                           staic       = icon_red_light
                           invoice_err = 'Tutar farkını dağıtım yönetimi ile dağıtınız'
                     WHERE invno = is_header-invno.
                    COMMIT WORK AND WAIT.

                    ls_difft-docui           = is_header-docui.
                    ls_difft-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-amount.
                    INSERT /itetr/inc_difft FROM ls_difft.

                    ls_difit-docui           = is_header-docui.
                    ls_difit-line            = ls_bill_item-line.
                    ls_difit-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-amount.
                    INSERT /itetr/inc_difit FROM ls_difit.

                    ls_message-docui   = is_header-docui.
                    ls_message-message = 'Tutar Farkı'.
                    APPEND ls_message TO lt_message.

                  ELSE.

                    UPDATE /itetr/inc_t0001
                       SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                           sappr = '3'
                           staic = icon_red_light
                           invoice_err = 'Fatura dip tutarları uyuşmamaktadır. Onaya gönderiniz'
                     WHERE invno = is_header-invno.
                    COMMIT WORK AND WAIT.

                    ls_difft-docui           = is_header-docui.
                    ls_difft-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-amount.
                    INSERT /itetr/inc_difft FROM ls_difft.

                    ls_difit-docui           = is_header-docui.
                    ls_difit-line            = ls_bill_item-line.
                    ls_difit-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-amount.
                    INSERT /itetr/inc_difit FROM ls_difit.

                    ls_message-docui   = is_header-docui.
                    ls_message-message = 'Tutar Farkı'.
                    APPEND ls_message TO lt_message.
                  ENDIF.

                  APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
                  <ls_return>-id     = '/ITETR/INC'.
                  <ls_return>-type   = 'E'.
                  <ls_return>-number = '013'.
                  <ls_return>-message_v1 = ls_bill_item-line.
                  CONDENSE <ls_return>-message_v1.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.
        ELSE.
          IF is_header-sappr EQ '4'.
            APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
            <ls_return>-id     = '/ITETR/INC'.
            <ls_return>-type   = 'E'.
            <ls_return>-number = '026'.
          ENDIF.
        ENDIF.
*      ELSE.
*        APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
*        <ls_return>-id     = '/ITETR/INC'.
*        <ls_return>-type   = 'E'.
*        <ls_return>-number = '047'.
*        EXIT.
      ENDIF.
    ENDLOOP.

    IF lt_message[] IS NOT INITIAL.
      MODIFY /itetr/inc_messg FROM TABLE lt_message.
      COMMIT WORK AND WAIT.
    ENDIF.
  ENDMETHOD.


  METHOD check_matnr_quantity_update.
    SELECT bsart,
           import_process
           FROM /itetr/inc_t0005 AS t0005
           INTO TABLE @DATA(lt_t0005)
           WHERE import_process EQ @abap_true.

    IF line_exists( lt_t0005[ bsart = is_header-bsart ] ) OR is_header-bsart IS INITIAL .
      EXIT.
    ENDIF.
    IF it_items IS NOT INITIAL.
      SELECT SINGLE bukrs,
                    cuspa,
                    value
                    FROM /itetr/inc_eicp
                    INTO @DATA(ls_quantity_control_type)
                    WHERE cuspa EQ 'MIKTAR_KNT'.
      CHECK ls_quantity_control_type-value EQ /itetr/if_inc_types=>mc_item.
      DATA(ls_item) = VALUE #( it_items[ 1 ] OPTIONAL ).
      IF ls_item-knttp IS NOT INITIAL.
        SELECT t0001~docui,
               mara~matnr,
               mara~mtart,
               t134m~mengu,
               t134m~wertu
               FROM /itetr/inc_t0001 AS t0001
               INNER JOIN /itetr/inc_t0002   AS t0002 ON t0002~docui EQ t0002~docui
               INNER JOIN mara  ON mara~matnr EQ t0002~matnr
               INNER JOIN ekpo  ON ekpo~ebeln EQ @is_header-orderid
                               AND ekpo~matnr EQ mara~matnr
               INNER JOIN t134m ON t134m~bwkey EQ ekpo~werks
                               AND t134m~mtart EQ mara~mtart
               INTO TABLE @DATA(lt_inv_quantity_check)
               WHERE t0001~docui EQ @is_header-docui
                 AND t134m~mengu EQ @abap_true
                 AND t134m~wertu EQ @space.
        IF sy-subrc EQ 0.
          APPEND INITIAL LINE TO et_return ASSIGNING FIELD-SYMBOL(<ls_return>).
          <ls_return>-id     = '/ITETR/INC'.
          <ls_return>-type   = 'E'.
          <ls_return>-number = '047'.
          EXIT.
        ENDIF.
      ELSE.
        APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
        <ls_return>-id     = '/ITETR/INC'.
        <ls_return>-type   = 'E'.
        <ls_return>-number = '047'.
        EXIT.
      ENDIF.

    ENDIF.
  ENDMETHOD.


  METHOD check_posting_fi.
    SELECT bkpf~belnr,
           bkpf~bukrs,
           bkpf~xblnr
           FROM bkpf
           INNER JOIN bseg ON bseg~belnr EQ bkpf~belnr
                          AND bseg~bukrs EQ bkpf~bukrs
                          AND bseg~gjahr EQ bkpf~gjahr
           INTO TABLE @DATA(lt_posting_check)
           WHERE bkpf~xblnr EQ @is_header-invno
             AND bkpf~bukrs EQ @is_header-bukrs
             AND bkpf~stblg EQ @space
             AND bkpf~gjahr EQ @is_header-gjahr
             AND ( bseg~lifnr EQ @is_header-lifnr OR bseg~kunnr EQ @is_header-lifnr ) .
    IF lt_posting_check IS NOT INITIAL.
      APPEND INITIAL LINE TO et_return ASSIGNING FIELD-SYMBOL(<ls_return>).
      <ls_return>-id = '/ITETR/INC'.
      <ls_return>-type = 'E'.
      <ls_return>-number = '068'.
    ENDIF.

    CLEAR lt_posting_check.
  ENDMETHOD.


  METHOD check_quantity_item.
    DATA lr_despid TYPE RANGE OF ekbe-xblnr.
    CASE is_header-sappr.
      WHEN space OR '1' OR '2' OR '3'.
        lr_despid = VALUE #( FOR ls_despatch IN it_despt
                           ( sign = 'I' option = 'EQ' low = ls_despatch-xblnr ) ).
*        SELECT ekpo~matnr,
*               ekpo~wepos,
*               ekbe~waers,
*               SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~menge
*                                    WHEN 'H' THEN ekbe~menge * -1 END ) AS menge
*               FROM @it_items AS mt_t0002
*               INNER JOIN ekpo ON ekpo~ebeln EQ mt_t0002~ebeln
*                              AND ekpo~ebelp EQ mt_t0002~ebelp
*               LEFT OUTER JOIN ekbe ON ekpo~ebeln EQ ekbe~ebeln
*                                   AND ekpo~ebelp EQ ekbe~ebelp
*                                   AND ekbe~xblnr NE @space
*               WHERE ekbe~vgabe EQ '1'
*                 AND ekbe~xblnr IN @lr_despid
*               GROUP BY ekpo~matnr, ekpo~wepos , ekbe~waers
*               INTO TABLE @DATA(lt_t0002).
        SELECT ekpo~matnr,
               SUM( stock_qty ) AS menge,
               SUM( exc_kdv   ) AS dmbtr
               FROM @it_despt AS despt
               INNER JOIN ekpo ON ekpo~ebeln EQ despt~ebeln
                              AND ekpo~ebelp EQ despt~ebelp
               GROUP BY ekpo~matnr
               INTO TABLE @DATA(lt_t0002).


        SELECT t0002~docui,
               t0002~line,
               t0002~matnr,
               t0002~meins,
               SUM( t0002~menge ) AS menge
               FROM /itetr/inc_t0002 AS t0002
               WHERE t0002~docui EQ @is_header-docui
               GROUP BY t0002~docui,t0002~line,t0002~matnr,meins
               INTO TABLE @DATA(lt_bill_item).

        IF line_exists( lt_bill_item[ matnr = space ] ).
          "Quantity'de t134M'ye atılan bir sorgu var. Oradaki miktar alanı dolu ise malzeme kontrolü yapacak.
          "Bu kontrol matnr ve knttp dolu için yapılacak.
          "Miktar.
          check_matnr_quantity_update( EXPORTING is_header = is_header
                                                 it_items  = it_items
                                       IMPORTING et_return = et_return ).

        ENDIF.

        LOOP AT lt_t0002 INTO DATA(ls_t0002).
          READ TABLE lt_bill_item INTO DATA(ls_bill_item) WITH KEY matnr = ls_t0002-matnr.
          IF sy-subrc EQ 0.
            IF ls_bill_item-menge > ls_t0002-menge.
              DATA(lv_item_diff) = ls_bill_item-menge - ls_t0002-menge.

              UPDATE /itetr/inc_t0001
                 SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-ready
                     sappr = '3'
                     staic = icon_red_light
                     invoice_err = 'Faturada miktar farkı vardır. Onaya gönderiniz'
               WHERE docui = is_header-docui.

              COMMIT WORK AND WAIT.

              DATA(ls_difft) = VALUE /itetr/inc_difft( ).
              ls_difft-docui           = is_header-docui.
              ls_difft-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-quantity.
              INSERT /itetr/inc_difft FROM ls_difft.

              DATA(ls_difit) = VALUE /itetr/inc_difit( ).
              ls_difit-docui           = is_header-docui.
              ls_difit-line            = ls_bill_item-line.
              ls_difit-difference_type = /itetr/cl_inc_wf_operations=>mc_difference_type-quantity.
              INSERT /itetr/inc_difit FROM ls_difit.

              APPEND INITIAL LINE TO et_return ASSIGNING FIELD-SYMBOL(<ls_return>).
              <ls_return>-id = '/ITETR/INC'.
              <ls_return>-type = 'E'.
              <ls_return>-number = '014'.
              <ls_return>-message_v1 = ls_bill_item-line.
              CONDENSE <ls_return>-message_v1.
            ENDIF.
*          ELSE.
*            APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
*            <ls_return>-id     = '/ITETR/INC'.
*            <ls_return>-type   = 'E'.
*            <ls_return>-number = '047'.
*            EXIT.
          ENDIF.
        ENDLOOP.
      WHEN OTHERS.
        IF is_header-sappr EQ '4'.
          APPEND INITIAL LINE TO et_return ASSIGNING <ls_return>.
          <ls_return>-id = '/ITETR/INC'.
          <ls_return>-type = 'E'.
          <ls_return>-number = '026'.
        ENDIF.
    ENDCASE.
  ENDMETHOD.


  METHOD FIND_VALUE.
    TYPES : BEGIN OF ty_lookfor,
              value(255),
            END OF ty_lookfor.

    CONSTANTS lc_special_characters TYPE char30 VALUE '!@#$%^&*()_-+[]{}|;:",.<>?/`~\'.
    DATA : lv_num_check.
    DATA : lv_number_value(100).
    DATA : lv_number(100).
    DATA : lv_number_s(100).

    DATA : lt_result_tab TYPE match_result_tab,
           ls_result_tab LIKE LINE OF lt_result_tab.

    DATA : lr_lookfor TYPE RANGE OF /itetr/inc_prefx-lookfor,
           lr_pattern TYPE RANGE OF /itetr/inc_pfcnd-pattern,
           rs_lookfor LIKE LINE OF lr_lookfor,
           rs_pattern LIKE LINE OF lr_pattern.

    DATA : lt_table LIKE tt_searched_table.
    DATA : lt_lookfor TYPE TABLE OF ty_lookfor,
           ls_lookfor TYPE ty_lookfor.

    DATA: lv_index    TYPE i,
          lv_index2   TYPE i,
          lv_index3   TYPE i,
          lv_length   TYPE i,
          lv_length1  TYPE i,
          lv_length2  TYPE i,
          lv_lengthva TYPE i,
          lv_char     TYPE c,
          lv_char2    TYPE string,
          lv_char3    TYPE string,
          lv_num      TYPE i.

    DATA : lv_text(500).
    DATA : lv_tabix TYPE sy-tabix.
    DATA : lv_tax_id TYPE char32.
    DATA : lv_char_control TYPE char1 VALUE '#'.


    SELECT *
           INTO TABLE @DATA(lt_prefix)
           FROM /itetr/inc_prefx
           WHERE bukrs = @iv_bukrs.
    IF sy-subrc IS NOT INITIAL OR iv_bukrs IS INITIAL.
      SELECT *
             INTO TABLE lt_prefix
             FROM /itetr/inc_prefx.
    ENDIF.

    SELECT search_code
           FROM /itetr/inc_prefx
           INTO TABLE @DATA(lt_search)
           WHERE bukrs = @iv_bukrs.

    IF sy-subrc IS NOT INITIAL OR iv_bukrs IS INITIAL.
      SELECT search_code
             FROM /itetr/inc_prefx
             INTO TABLE lt_search .
    ENDIF.

    SORT lt_search ASCENDING BY search_code.

    DELETE ADJACENT DUPLICATES FROM lt_search COMPARING ALL FIELDS.

    SELECT *
           FROM /itetr/inc_pfcnd
           INTO TABLE @DATA(lt_prefix_condition)
           WHERE bukrs = @iv_bukrs.

    IF sy-subrc IS NOT INITIAL OR iv_bukrs IS INITIAL.
      SELECT * FROM /itetr/inc_pfcnd
               INTO TABLE lt_prefix_condition .
    ENDIF.

    lt_table[] = it_table[].
    LOOP AT lt_table INTO DATA(ls_table).

      TRANSLATE ls_table-line TO UPPER CASE.
      CLEAR sy-subrc.
      DO.
        REPLACE space WITH '#' INTO ls_table-line.
        IF sy-subrc NE 0.
          EXIT.
        ENDIF.
      ENDDO.
      MODIFY lt_table FROM ls_table.
    ENDLOOP.

    LOOP AT lt_search INTO DATA(ls_search).
      CLEAR lv_num_check.

      CLEAR: lr_lookfor, lr_lookfor[] , lt_lookfor[].

      LOOP AT lt_prefix INTO DATA(ls_prefix) WHERE search_code = ls_search-search_code.
        rs_lookfor-sign = 'I'.
        rs_lookfor-option = 'CP'.
        rs_lookfor-low = ls_prefix-lookfor.
        APPEND rs_lookfor TO lr_lookfor.
        ls_lookfor-value = ls_prefix-lookfor.
        REPLACE ALL OCCURRENCES OF '*' IN ls_lookfor-value WITH ''.
        CONDENSE ls_lookfor-value NO-GAPS.
        APPEND ls_lookfor TO lt_lookfor.
      ENDLOOP.

      DATA lv_i TYPE i.
      CLEAR lv_i.

      DO 2 TIMES.

        lv_i = lv_i + 1.

        IF lv_i = 1.
          lv_num_check = 'X'.
        ELSE.
          CLEAR lv_num_check .
        ENDIF.

        READ TABLE lt_prefix_condition INTO DATA(ls_prefix_condition) WITH KEY search_code = ls_search-search_code
                                                                               num_check = lv_num_check.
        IF sy-subrc IS NOT INITIAL.
          CHECK 1 = 2.
        ENDIF.


        LOOP AT lt_table INTO ls_table WHERE line IN lr_lookfor.

          CLEAR : lt_result_tab[],lv_length, lv_index,lv_number, lv_char, lv_number_value.

          IF lv_num_check IS NOT INITIAL.

            LOOP AT lt_lookfor INTO ls_lookfor.
              CLEAR : lt_result_tab[],lv_length, lv_index,lv_number, lv_char, lv_text.
              CLEAR lt_result_tab[].
              FIND ALL OCCURRENCES OF ls_lookfor-value IN ls_table-line RESULTS lt_result_tab.
              CHECK lt_result_tab[] IS NOT INITIAL.

*              READ TABLE lt_result_tab INTO ls_result_tab INDEX 1.
              LOOP AT lt_result_tab INTO ls_result_tab.
                CLEAR: lv_index , lv_length , lv_lengthva , lv_index2 , lv_char2 , lv_number , lv_char.
                IF sy-subrc IS INITIAL.

                  lv_index = ls_result_tab-offset.
                  lv_length = strlen( ls_table-line ).
                  lv_lengthva = strlen( ls_lookfor-value ).
                  IF ls_lookfor-value(lv_lengthva) CO '0123456789'.
                    IF lv_index GE 2.
                      lv_index2 = lv_index - 2.
                      lv_char2 = ls_table-line+lv_index2(2).
                      IF lv_char2 CO '0123456789'.
                        lv_index = lv_index2.
                      ENDIF.
                    ENDIF.
                  ENDIF.
                  CLEAR lv_lengthva.
                  DO lv_length TIMES.
                    IF lv_length = lv_index.
                      EXIT.
                    ENDIF.
                    lv_char = ls_table-line+lv_index(1).
                    TRY .
                        lv_num = lv_char."was a number
                        CONCATENATE lv_number lv_char INTO lv_number.
                        CONDENSE lv_number NO-GAPS.
                      CATCH cx_sy_conversion_no_number.

                        IF lv_number IS NOT INITIAL.
                          IF lv_char CO sy-abcde.
                            CLEAR lv_number..
                          ENDIF.
                          EXIT.
                        ENDIF.
                    ENDTRY.
                    ADD 1 TO lv_index.
                  ENDDO.
                ENDIF.
                CLEAR lv_number_s.
                lv_number_s = lv_number.
                LOOP AT lt_prefix_condition INTO ls_prefix_condition WHERE search_code = ls_search-search_code
                                                                       AND num_check = lv_num_check.

                  IF ls_prefix_condition-num_check IS NOT INITIAL.
                    SHIFT lv_number LEFT DELETING LEADING '0'.
                    IF lv_number IS NOT INITIAL.
                      lv_length1 = strlen( lv_number_s ).

                      IF lv_length1 BETWEEN ls_prefix_condition-min_length AND ls_prefix_condition-max_length.
                        CLEAR: lr_pattern[], lr_pattern.
                        rs_pattern-sign = 'I'.
                        rs_pattern-option = 'CP'.
                        rs_pattern-low = ls_prefix_condition-pattern.

                        APPEND rs_pattern TO lr_pattern.

                        IF lv_number IN lr_pattern.
                          lv_number_value = lv_number_s.

                          IF lv_number_value IS NOT INITIAL.
                            APPEND INITIAL LINE TO et_response ASSIGNING FIELD-SYMBOL(<ls_response>).
                            <ls_response>-search_code = ls_search-search_code.
                            <ls_response>-svalue      = lv_number_value.
                          ENDIF.

                        ENDIF.

                      ENDIF.
                    ENDIF.

                  ELSE.
                    lv_number_value = lv_number_s.

                    IF lv_number_value IS NOT INITIAL.
                      APPEND INITIAL LINE TO et_response ASSIGNING <ls_response>.
                      <ls_response>-search_code = ls_search-search_code.
                      <ls_response>-svalue      = lv_number_value.
                    ENDIF.

                  ENDIF.

                ENDLOOP.

              ENDLOOP.

            ENDLOOP.

          ELSE.

            LOOP AT lt_lookfor INTO ls_lookfor.

              CLEAR : lt_result_tab[],lv_length, lv_index,lv_number, lv_char, lv_text.
              CLEAR lt_result_tab[].
              FIND ALL OCCURRENCES OF ls_lookfor-value IN ls_table-line RESULTS lt_result_tab.

              CHECK lt_result_tab[] IS NOT INITIAL.

*              READ TABLE lt_result_tab INTO ls_result_tab INDEX 1.
              LOOP AT lt_result_tab INTO ls_result_tab.
*                READ TABLE lt_prefix_condition INTO ls_prefix_condition WITH KEY search_code    = ls_search-search_code
*                                                                                 num_check = lv_num_check.
*                LOOP AT lt_prefix_condition INTO ls_prefix_condition WHERE search_code = ls_search-search_code
*                                                                       AND num_check   = lv_num_check.
                LOOP AT lt_prefix_condition INTO ls_prefix_condition WHERE search_code    = ls_search-search_code
                                                                       AND num_check = lv_num_check.

                  CLEAR: lv_index , lv_length , lv_lengthva.
                  lv_index = ls_result_tab-offset.
                  lv_length = strlen( ls_table-line ).
                  lv_lengthva = strlen( ls_lookfor-value ).

                  CLEAR lv_index3.
                  CLEAR lv_lengthva.
                  DO ls_prefix_condition-max_length TIMES.
                    ADD 1 TO lv_index3.
                    IF lv_length = lv_index.
                      EXIT.
                    ENDIF.
                    CLEAR lv_char.
                    lv_char = ls_table-line+lv_index(1).
                    IF lv_char EQ cl_abap_char_utilities=>cr_lf+1.
                      EXIT.
                    ENDIF.
                    IF lv_char CA lc_special_characters.
                      IF lv_char NA ls_prefix_condition-special_characters.
                        EXIT.
                      ENDIF.
                    ENDIF.
                    CONCATENATE lv_number lv_char INTO lv_number.
                    CONDENSE lv_number NO-GAPS.
                    ADD 1 TO lv_index.
                    IF ls_prefix_condition-max_length = lv_index3.
                      EXIT.
                    ENDIF.
                  ENDDO.

                  CLEAR lv_number_s.

                  lv_number_s = lv_number.
                  CLEAR lv_number.

*                LOOP AT lt_prefix_condition INTO ls_prefix_condition WHERE search_code    = ls_search-search_code
*                                                                       AND num_check = lv_num_check.

*                  IF lv_number IS NOT INITIAL.
                  IF lv_number_s IS NOT INITIAL.

                    lv_length1 = strlen( lv_number_s ).

                    IF lv_length1 BETWEEN ls_prefix_condition-min_length AND ls_prefix_condition-max_length.

                      CLEAR: lr_pattern[], lr_pattern.

                      rs_pattern-sign = 'I'.
                      rs_pattern-option = 'CP'.
                      rs_pattern-low = ls_prefix_condition-pattern.

                      APPEND rs_pattern TO lr_pattern.

                      IF lv_number_s IN lr_pattern.
                        lv_number_value = lv_number_s.

                        IF lv_number_value IS NOT INITIAL.

                          IF ls_prefix_condition-svalue IS NOT INITIAL.
                            lv_number_value = ls_prefix_condition-svalue.
                          ENDIF.
                          DO.
                            REPLACE '#' WITH space  INTO lv_number_value.
                            IF sy-subrc NE 0.
                              EXIT.
                            ENDIF.
                          ENDDO.
                          APPEND INITIAL LINE TO et_response ASSIGNING <ls_response>.
                          <ls_response>-search_code = ls_search-search_code.
                          <ls_response>-svalue      = lv_number_value.
                        ENDIF.

                      ENDIF.

                    ENDIF.
                  ENDIF.
                ENDLOOP.

              ENDLOOP.

            ENDLOOP.
          ENDIF.

        ENDLOOP.
        IF et_response[] IS NOT INITIAL.
          EXIT.
        ENDIF.
      ENDDO.

    ENDLOOP.

    DELETE ADJACENT DUPLICATES FROM et_response COMPARING ALL FIELDS.
    CLEAR: lt_prefix , lt_prefix_condition.
  ENDMETHOD.


  METHOD get_amount_bill_item_diff.
    TYPES : BEGIN OF ty_t0002,
              matnr TYPE ekpo-matnr,
              wepos TYPE ekpo-wepos,
              xblnr TYPE ekbe-xblnr,
              waers TYPE ekbe-waers,
              shkzg TYPE ekbe-shkzg,
              dmbtr TYPE ekbe-dmbtr,
              netwr TYPE ekpo-netwr,
              wrbtr TYPE ekbe-wrbtr,
              menge TYPE ekpo-menge,
            END OF ty_t0002.

    DATA: lt_po_item TYPE TABLE OF ty_t0002.
    DATA: lv_wrbtr TYPE wrbtr.
    DATA: lv_difference TYPE wrbtr.
    DATA: lr_despid TYPE RANGE OF ekbe-xblnr.

    DATA: lv_po_item_amount  TYPE ekbe-wrbtr,
          lv_inv_item_amount TYPE /itetr/inc_t0002-netwr,
          lv_tolerance_amt   TYPE /itetr/inc_t0002-netwr.

    CHECK it_items IS NOT INITIAL.

    lr_despid = VALUE #( FOR ls_despatch IN it_despt
                       ( sign = 'I' option = 'EQ' low = ls_despatch-xblnr ) ).

    SELECT ekpo~matnr,
           ekpo~wepos,
           ekbe~waers,
           SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~dmbtr
                                WHEN 'H' THEN ekbe~dmbtr * -1 END ) AS dmbtr,
           SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~wrbtr
                                WHEN 'H' THEN ekbe~wrbtr * -1 END ) AS wrbtr,
           SUM( CASE ekbe~shkzg WHEN 'S' THEN ekbe~menge
                                WHEN 'H' THEN ekbe~menge * -1 END ) AS menge

           FROM @it_items AS mt_t0002
           INNER JOIN ekpo ON ekpo~ebeln EQ mt_t0002~ebeln
                          AND ekpo~ebelp EQ mt_t0002~ebelp
           LEFT OUTER JOIN ekbe ON ekpo~ebeln EQ ekbe~ebeln
                               AND ekpo~ebelp EQ ekbe~ebelp
                               AND ekbe~xblnr NE @space
           WHERE ekbe~bewtp EQ 'E'
             AND ekbe~xblnr IN @lr_despid
           GROUP BY ekpo~matnr, ekpo~wepos , ekbe~waers
           INTO CORRESPONDING FIELDS OF TABLE @lt_po_item.

    SELECT t0002~docui,
*           t0002~line,
           t0002~matnr,
           t0002~meins,
           SUM( t0002~menge ) AS menge,
           SUM( t0002~netwr ) AS netwr,
           SUM( t0002~brtwr ) AS brtwr
           FROM /itetr/inc_t0002 AS t0002
           WHERE t0002~docui EQ @is_header-docui
             AND t0002~matnr IS NOT INITIAL
           GROUP BY t0002~docui,t0002~matnr,meins
           INTO TABLE @DATA(lt_invoice_item).


    LOOP AT lt_po_item INTO DATA(ls_po_item).
      CLEAR: lv_po_item_amount , lv_inv_item_amount.

      CHECK ls_po_item-menge > 0.

      IF ls_po_item-wepos EQ 'X'.
        lv_po_item_amount = ls_po_item-wrbtr / ls_po_item-menge.
      ELSE.
        READ TABLE it_items INTO DATA(ls_items) WITH KEY matnr = ls_po_item-matnr.
        IF sy-subrc EQ 0 AND ls_items-menge > 0.
          lv_po_item_amount = ls_items-netwr / ls_items-menge.
        ENDIF.
      ENDIF.

      READ TABLE lt_invoice_item INTO DATA(ls_invoice_item) WITH KEY matnr = ls_po_item-matnr.

      CHECK ls_invoice_item-menge > 0.

      IF is_header-waers EQ ls_po_item-waers.
        lv_inv_item_amount = ls_invoice_item-netwr / ls_invoice_item-menge.
      ELSE.
        lv_po_item_amount  = ls_po_item-dmbtr      / ls_po_item-menge.
        lv_inv_item_amount = ls_invoice_item-netwr / ls_invoice_item-menge.
        IF is_header-kursf IS NOT INITIAL.
          lv_inv_item_amount = lv_inv_item_amount * is_header-kursf.
        ELSE.
          CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
            EXPORTING
              date             = is_header-bldat
              foreign_amount   = lv_inv_item_amount
              foreign_currency = is_header-waers
              local_currency   = ls_po_item-waers
            IMPORTING
              local_amount     = lv_wrbtr
            EXCEPTIONS
              no_rate_found    = 1
              overflow         = 2
              no_factors_found = 3
              no_spread_found  = 4
              derived_2_times  = 5
              OTHERS           = 6.
          IF sy-subrc EQ 0.
            CLEAR lv_inv_item_amount.
            lv_inv_item_amount = lv_wrbtr.
          ENDIF.
        ENDIF.
      ENDIF.

      SELECT SINGLE *
             FROM /itetr/inc_eicp
             INTO @DATA(ls_eicv)
             WHERE bukrs = @is_header-bukrs
               AND cuspa = 'TOLERANS'.

        lv_tolerance_amt = lv_inv_item_amount * ls_eicv-value / 100.

        lv_difference = lv_inv_item_amount - lv_po_item_amount.

        IF lv_difference > 0 AND lv_difference > lv_tolerance_amt.
          APPEND INITIAL LINE TO et_return ASSIGNING FIELD-SYMBOL(<ls_return>).
          <ls_return>-matnr      = ls_invoice_item-matnr.
          <ls_return>-amount     = lv_difference.
          <ls_return>-po_netpr   = lv_po_item_amount.
          <ls_return>-netpr      = lv_inv_item_amount.
          CLEAR lv_difference.
        ENDIF.
      ENDLOOP.
    ENDMETHOD.


  METHOD get_amount_diff.
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
*           ekbe~waers,
*           SUM( ekpo~netwr ) AS netwr
*           FROM @it_items AS mt_t0002
*           INNER JOIN ekpo ON ekpo~ebeln EQ mt_t0002~ebeln
*                          AND ekpo~ebelp EQ mt_t0002~ebelp
*           GROUP BY ekpo~matnr
*           INTO CORRESPONDING FIELDS OF TABLE @lt_t0002.
*
**    SELECT t0002~docui,
**           t0002~meins,
**           SUM( t0002~menge ) AS menge,
**           SUM( t0002~netwr ) AS netwr,
**           SUM( t0002~brtwr ) AS brtwr
**           FROM /itetr/inc_t0002 AS t0002
**           WHERE t0002~docui EQ @is_header-docui
**             AND t0002~matnr IS NOT INITIAL
**           GROUP BY t0002~docui,t0002~line,t0002~matnr,meins
**           INTO TABLE @DATA(lt_bill_item).
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


  METHOD get_quantity_bill_item_diff.
    DATA: lv_difference TYPE wrbtr.
    DATA: lr_despid TYPE RANGE OF ekbe-xblnr.
    lr_despid = VALUE #( FOR ls_despatch IN it_despt
                       ( sign = 'I' option = 'EQ' low = ls_despatch-xblnr ) ).
    SELECT ekpo~matnr,
           SUM( stock_qty ) AS menge,
           SUM( exc_kdv   ) AS dmbtr
           FROM @it_despt AS despt
           INNER JOIN ekpo ON ekpo~ebeln EQ despt~ebeln
                          AND ekpo~ebelp EQ despt~ebelp
           GROUP BY ekpo~matnr
           INTO TABLE @DATA(lt_t0002).

    SELECT t0002~docui,
           t0002~matnr,
           t0002~meins,
           SUM( t0002~menge ) AS menge,
           SUM( t0002~netwr ) AS netwr
           FROM /itetr/inc_t0002 AS t0002
           WHERE t0002~docui EQ @is_header-docui
             AND t0002~matnr IS NOT INITIAL
           GROUP BY t0002~docui,t0002~matnr,meins
           INTO TABLE @DATA(lt_bill_item).


    LOOP AT lt_t0002 INTO DATA(ls_t0002).
      READ TABLE lt_bill_item INTO DATA(ls_bill_item) WITH KEY matnr = ls_t0002-matnr.
      lv_difference = ls_bill_item-menge - ls_t0002-menge.
      IF lv_difference > 0 .

        APPEND INITIAL LINE TO et_return ASSIGNING FIELD-SYMBOL(<ls_return>).
        <ls_return>-matnr     = ls_bill_item-matnr.
        <ls_return>-quantity  = lv_difference.
        <ls_return>-netpr     = ls_bill_item-netwr / ls_bill_item-menge.
        <ls_return>-po_netpr  = ls_t0002-dmbtr     / ls_t0002-menge.
        CLEAR: ls_bill_item , lv_difference.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD posting_fi.
    TYPES: BEGIN OF ty_tax_detail,
             mwskz      TYPE mwskz,
             rwcur      TYPE acdoca-rwcur,
             hkont      TYPE bseg-hkont,
             kschl      TYPE kschl,
             ktosl      TYPE ktosl,
             amount     TYPE bset-fwste,
             tax_amount TYPE bset-fwste,
           END OF ty_tax_detail.

    DATA : ls_total_tax TYPE ty_tax_detail,
           lt_total_tax TYPE TABLE OF ty_tax_detail.

    DATA: ls_documentheader TYPE bapiache09,
          lt_accountgl      TYPE TABLE OF bapiacgl09,
          lt_accountpayable TYPE TABLE OF bapiacap09,
          lt_currencyamount TYPE TABLE OF bapiaccr09,
          lt_accounttax     TYPE TABLE OF bapiactx09,
          lt_accountreceive TYPE TABLE OF bapiacar09,
          lt_return         TYPE bapiret2_tab.

    DATA: lv_itemno_gl     TYPE bapiacgl09-itemno_acc,
          lv_itemno_curr   TYPE bapiacgl09-itemno_acc,
          lv_wrbtr         TYPE bseg-wrbtr,
          lt_mwdat         TYPE TABLE OF rtax1u15,
          lv_total_gross   TYPE bset-fwste,
          lv_total_net     TYPE bset-fwste,
          lv_tax           TYPE bset-fwste,
          lv_item_gross    TYPE bapiaccr09-amt_doccur,
          lv_costdoc_cntrl TYPE char1,
          lv_mwskz         TYPE bapiacar09-tax_code.

    SELECT *
           FROM /itetr/inc_eicp
           INTO TABLE @DATA(lt_automation_paramaters)
           WHERE bukrs EQ @is_header-bukrs.


    SELECT t0001~*,
           t0002~*
           FROM /itetr/inc_t0001 AS t0001
           INNER JOIN /itetr/inc_t0002 AS t0002 ON t0002~docui EQ t0001~docui
           INTO TABLE @DATA(lt_invoice)
           WHERE t0001~docui EQ @is_header-docui.


    DATA(ls_parameters) = VALUE #( lt_automation_paramaters[ cuspa = 'FI_DOCTYPE' ] OPTIONAL ).
    ls_documentheader = VALUE #( username   = sy-uname
                                 header_txt = 'Gelen Fatura Kaydı'
                                 comp_code  = is_header-bukrs
                                 doc_date   = is_header-bldat
                                 pstng_date = is_header-recdt
                                 doc_type   = ls_parameters-value
                                 ref_doc_no = is_header-invno
                                 obj_type   = 'BKPFF' ).

    LOOP AT lt_invoice INTO DATA(ls_invoice).

      lv_itemno_gl   += 1.
      lv_itemno_curr += 1.

      APPEND INITIAL LINE TO lt_accountgl ASSIGNING FIELD-SYMBOL(<ls_accountgl>).
      <ls_accountgl>-itemno_acc   = lv_itemno_gl.
      <ls_accountgl>-gl_account   = is_input_screen-hkont.
      <ls_accountgl>-comp_code    = is_header-bukrs.
      <ls_accountgl>-costcenter   = is_input_screen-kostl.
      <ls_accountgl>-tax_code     = ls_invoice-t0002-mwskz.
      <ls_accountgl>-pstng_date   = is_header-recdt.
      <ls_accountgl>-orderid      = is_input_screen-orderid.


      APPEND INITIAL LINE TO lt_currencyamount ASSIGNING FIELD-SYMBOL(<ls_currency_amount>).
      <ls_currency_amount>-itemno_acc  = lv_itemno_curr.
      <ls_currency_amount>-currency    = is_header-waers.
      <ls_currency_amount>-amt_doccur  = ls_invoice-t0002-netwr.
      <ls_currency_amount>-exch_rate   = is_header-kursf.

      CLEAR : lv_tax , lv_wrbtr.

      lv_wrbtr = <ls_currency_amount>-amt_doccur.
      CALL FUNCTION 'CALCULATE_TAX_FROM_NET_AMOUNT'
        EXPORTING
          i_bukrs                   = is_header-bukrs
          i_mwskz                   = ls_invoice-t0002-mwskz
          i_waers                   = is_header-waers
          i_wrbtr                   = lv_wrbtr
        IMPORTING
          e_fwste                   = lv_tax
        TABLES
          t_mwdat                   = lt_mwdat
        EXCEPTIONS
          bukrs_not_found           = 1
          country_not_found         = 2
          mwskz_not_defined         = 3
          mwskz_not_valid           = 4
          account_not_found         = 5
          different_discount_base   = 6
          different_tax_base        = 7
          txjcd_not_valid           = 8
          not_found                 = 9
          ktosl_not_found           = 10
          kalsm_not_found           = 11
          parameter_error           = 12
          knumh_not_found           = 13
          kschl_not_found           = 14
          unknown_error             = 15
          amounts_too_large_for_tax = 16
          tdt_error                 = 17
          txa_error                 = 18
          OTHERS                    = 19.

      lv_total_gross = lv_total_gross + <ls_currency_amount>-amt_doccur + lv_tax.

*      LOOP AT lt_mwdat INTO DATA(ls_mwdat) WHERE msatz NE 0 .
      LOOP AT lt_mwdat INTO DATA(ls_mwdat).
        ls_total_tax-mwskz      = ls_invoice-t0002-mwskz.
        ls_total_tax-hkont      = ls_mwdat-hkont.
        ls_total_tax-kschl      = ls_mwdat-kschl.
        ls_total_tax-ktosl      = ls_mwdat-ktosl.
        ls_total_tax-tax_amount = ls_mwdat-wmwst.
        ls_total_tax-amount     = <ls_currency_amount>-amt_doccur.
        COLLECT ls_total_tax INTO lt_total_tax.
      ENDLOOP.

    ENDLOOP.

    CHECK lv_costdoc_cntrl EQ space.

    lv_itemno_curr += 1.
    APPEND INITIAL LINE TO lt_currencyamount ASSIGNING <ls_currency_amount>.
    <ls_currency_amount>-itemno_acc  = lv_itemno_curr.
    <ls_currency_amount>-currency    = is_header-waers.
    <ls_currency_amount>-amt_doccur  = lv_total_gross * -1.
    <ls_currency_amount>-exch_rate   = is_header-kursf.

    LOOP AT lt_total_tax INTO ls_total_tax.
      lv_itemno_curr += 1.
      APPEND INITIAL LINE TO lt_currencyamount ASSIGNING <ls_currency_amount>.
      <ls_currency_amount>-itemno_acc = lv_itemno_curr.
      <ls_currency_amount>-currency   = is_header-waers.
      <ls_currency_amount>-amt_doccur = ls_total_tax-tax_amount.
      <ls_currency_amount>-amt_base   = ls_total_tax-amount.
      <ls_currency_amount>-exch_rate  = is_header-kursf.

      APPEND INITIAL LINE TO lt_accounttax   ASSIGNING FIELD-SYMBOL(<ls_account_tax>).
      <ls_account_tax>-itemno_acc     = <ls_currency_amount>-itemno_acc.
      <ls_account_tax>-gl_account     = ls_total_tax-hkont.
      <ls_account_tax>-acct_key       = ls_total_tax-ktosl.
      <ls_account_tax>-cond_key       = ls_total_tax-kschl.
      <ls_account_tax>-tax_code       = ls_total_tax-mwskz.
    ENDLOOP.

*    IF NOT ( line_exists( lt_accountreceive[ tax_code = ls_total_tax-mwskz ] ) OR line_exists( lt_accountpayable[ tax_code = ls_total_tax-mwskz ] ) ).
    IF lines( lt_total_tax ) > 1.
      lv_mwskz = space.
    ELSEIF lines( lt_total_tax ) <= 1.
      lv_mwskz = VALUE #( lt_total_tax[ 1 ]-mwskz OPTIONAL ).
    ENDIF.
    SELECT SINGLE *
                 FROM lfb1
                 INTO @DATA(ls_lfb1)
                 WHERE lifnr EQ @is_header-lifnr
                   AND bukrs EQ @is_header-bukrs.
    IF sy-subrc EQ 0.
      lv_itemno_gl += 1.
      APPEND INITIAL LINE TO lt_accountpayable ASSIGNING FIELD-SYMBOL(<ls_account_payable>).
      <ls_account_payable>-itemno_acc = lv_itemno_gl.
      <ls_account_payable>-vendor_no  = is_header-lifnr.
      <ls_account_payable>-comp_code  = is_header-bukrs.
      <ls_account_payable>-bline_date = is_header-bldat.
      <ls_account_payable>-item_text  = is_header-name1.
*      <ls_account_payable>-tax_code   = ls_total_tax-mwskz.
      <ls_account_payable>-tax_code   = lv_mwskz.
    ELSE.
      lv_itemno_gl += 1.
      APPEND INITIAL LINE TO lt_accountreceive ASSIGNING FIELD-SYMBOL(<ls_account_receive>).
      <ls_account_receive>-itemno_acc = lv_itemno_gl.
      <ls_account_receive>-customer   = is_header-lifnr.
      <ls_account_receive>-comp_code  = is_header-bukrs.
      <ls_account_receive>-bline_date = is_header-bldat.
      <ls_account_receive>-item_text  = is_header-name1.
*      <ls_account_receive>-tax_code   = ls_total_tax-mwskz.
      <ls_account_receive>-tax_code   = lv_mwskz.
    ENDIF.
    call_fi_posting_bapi( EXPORTING is_header          = is_header
                                    iv_testrun         = iv_testrun
                                    is_document_header = ls_documentheader
                                    it_accountgl       = lt_accountgl
                                    it_accountpayable  = lt_accountpayable
                                    it_currencyamount  = lt_currencyamount
                                    it_accounttax      = lt_accounttax
                                    it_accountreceive  = lt_accountreceive
                          IMPORTING et_return_message  = DATA(lt_return_message)
                                    es_return_data     = DATA(ls_return_data) ).

    APPEND LINES OF lt_return_message TO et_return.
    IF ls_return_data IS NOT INITIAL.
      es_return_data = ls_return_data.
      MESSAGE s006(zitetr_inc) WITH es_return_data-belnr.
    ENDIF.
  ENDMETHOD.


  method UPDATE_DESPATCH_TABLE.
  endmethod.


  METHOD update_order_table.

  ENDMETHOD.
ENDCLASS.