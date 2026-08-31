class /ITETR/CL_INC_LOGS definition
  public
  final
  create public .

public section.

  constants:
    BEGIN OF mc_log_codes.
    CONSTANTS received TYPE /itetr/com_e_logcd VALUE 'RECEIVED' ##NO_TEXT.
    CONSTANTS waiting TYPE /itetr/com_e_logcd VALUE 'WAITING' ##NO_TEXT.
    CONSTANTS approved TYPE /itetr/com_e_logcd VALUE 'APPROVED' ##NO_TEXT.
    CONSTANTS response TYPE /itetr/com_e_logcd VALUE 'RESPONSE' ##NO_TEXT.
    CONSTANTS accepted TYPE /itetr/com_e_logcd VALUE 'ACCEPTED' ##NO_TEXT.
    CONSTANTS rejected TYPE /itetr/com_e_logcd VALUE 'REJECTED' ##NO_TEXT.
    CONSTANTS set_as_rejected TYPE /itetr/com_e_logcd VALUE 'REJSET' ##NO_TEXT.
    CONSTANTS rejected_via_kep TYPE /itetr/com_e_logcd VALUE 'REJKEP' ##NO_TEXT.
    CONSTANTS rejected_via_gib TYPE /itetr/com_e_logcd VALUE 'REJGIB' ##NO_TEXT.
    CONSTANTS ready TYPE /itetr/com_e_logcd VALUE 'READY' ##NO_TEXT.
    CONSTANTS processed TYPE /itetr/com_e_logcd VALUE 'PROCESSED' ##NO_TEXT.
    CONSTANTS nonprocessed TYPE /itetr/com_e_logcd VALUE 'NONPROCESS' ##NO_TEXT.
    CONSTANTS archived TYPE /itetr/com_e_logcd VALUE 'ARCHIVED' ##NO_TEXT.
    CONSTANTS printed TYPE /itetr/com_e_logcd VALUE 'PRINTED' ##NO_TEXT.
    CONSTANTS mail TYPE /itetr/com_e_logcd VALUE 'MAIL' ##NO_TEXT.
    CONSTANTS reversed TYPE /itetr/com_e_logcd VALUE 'REVERSED' ##NO_TEXT.
    CONSTANTS status TYPE /itetr/com_e_logcd VALUE 'STATUS' ##NO_TEXT.
    CONSTANTS download TYPE /itetr/com_e_logcd VALUE 'DOWNLOAD' ##NO_TEXT.
    CONSTANTS nonprinted TYPE /itetr/com_e_logcd VALUE 'NONPRINTED' ##NO_TEXT.
    CONSTANTS sent TYPE /itetr/com_e_logcd VALUE 'SENT' ##NO_TEXT.
    CONSTANTS created TYPE /itetr/com_e_logcd VALUE 'CREATED' ##NO_TEXT.
    CONSTANTS deleted TYPE /itetr/com_e_logcd VALUE 'DELETED' ##NO_TEXT.
    CONSTANTS note_added TYPE /itetr/com_e_logcd VALUE 'NOTE' ##NO_TEXT.
    CONSTANTS sms TYPE /itetr/com_e_logcd VALUE 'SMS' ##NO_TEXT.
    CONSTANTS saved TYPE /itetr/com_e_logcd VALUE 'SAVED' ##NO_TEXT.
    CONSTANTS taxpayers_updated TYPE /itetr/com_e_logcd VALUE 'TAXPAYERS' ##NO_TEXT.
    CONSTANTS sappr TYPE /itetr/com_e_logcd VALUE 'SAPPR' ##NO_TEXT.
    CONSTANTS ekgrp TYPE /itetr/com_e_logcd VALUE 'EKGRP' ##NO_TEXT.
    CONSTANTS END OF mc_log_codes .

  class-methods DISPLAY
    importing
      !IV_DOCUI type /ITETR/INC_E_DOCUI .
  class-methods CREATE_SINGLE_LOG
    importing
      !IV_LOG_CODE type /ITETR/COM_E_LOGCD
      !IV_LOG_TEXT type /ITETR/COM_E_LNOTE optional
      !IV_DOCUMENT_ID type /ITETR/INC_E_DOCUI optional
      !IV_COMMIT type XFELD default ABAP_TRUE
      !IS_HEADER type /ITETR/INC_S0001 optional
      !IV_LOG_PROGRAM type SY-REPID optional
      !IV_LOG_TECH_OBJECT type /ITETR/INC_DE_LOG_TECH_OBJECT optional .
  class-methods CREATE
    importing
      !IT_LOGS type /ITETR/INC_TT_LOGS
      !IV_COMMIT type XFELD default ABAP_TRUE .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ITETR/CL_INC_LOGS IMPLEMENTATION.


  METHOD create.

    DATA: lt_log_db TYPE TABLE OF /itetr/inc_logs,
          ls_log_db TYPE /itetr/inc_logs,
          lt_logs   TYPE /itetr/inc_tt_logs,
          ls_logs   TYPE /itetr/inc_s_logs.
    lt_logs = it_logs.
    LOOP AT lt_logs INTO ls_logs.
      MOVE-CORRESPONDING ls_logs TO ls_log_db.
      CALL FUNCTION 'GUID_CREATE'
        IMPORTING
          ev_guid_16 = ls_log_db-logid.
      APPEND ls_log_db TO lt_log_db.
      CLEAR ls_log_db.
    ENDLOOP.
    CHECK lt_log_db IS NOT INITIAL.
    INSERT /itetr/inc_logs FROM TABLE lt_log_db.
    CHECK iv_commit IS NOT INITIAL.
    COMMIT WORK AND WAIT.

  ENDMETHOD.


  METHOD create_single_log.
    DATA: lt_log_db TYPE TABLE OF /itetr/inc_logs,
          ls_log_db TYPE /itetr/inc_logs.

      CALL FUNCTION 'GUID_CREATE'
        IMPORTING
          ev_guid_16 = ls_log_db-logid.
      ls_log_db-docui = iv_document_id.
      ls_log_db-uname = sy-uname.
      ls_log_db-datum = sy-datum.
      ls_log_db-uzeit = sy-uzeit.
      ls_log_db-logcd = iv_log_code.
      ls_log_db-logtx = iv_log_text.
      ls_log_db-lifnr = is_header-lifnr.
      ls_log_db-sappr = is_header-sappr.
      ls_log_db-ekgrp = is_header-ekgrp.
      INSERT /itetr/inc_logs FROM ls_log_db.
      CHECK iv_commit IS NOT INITIAL.
      COMMIT WORK AND WAIT.

  ENDMETHOD.


  METHOD display.
    TYPES: BEGIN OF ty_log_data,
             logid  TYPE /itetr/com_e_logid,
             docui  TYPE /itetr/inc_e_docui,
             uname  TYPE xubname,
             datum  TYPE datum,
             uzeit  TYPE uzeit,
             logcd  TYPE /itetr/com_e_logcd,
             ddtext TYPE dd07t-ddtext,
             logtx  TYPE /itetr/com_e_lnote,
             sappr  TYPE /itetr/inc_logs-sappr,
           END OF ty_log_data.

    DATA: lt_logs          TYPE STANDARD TABLE OF ty_log_data,
          lo_salv_table    TYPE REF TO cl_salv_table,
          lo_columns       TYPE REF TO cl_salv_columns_table,
          lo_column        TYPE REF TO cl_salv_column,
          lx_root          TYPE REF TO cx_root,
          lv_error_message TYPE string,
          lv_winx1         TYPE i,
          lv_winx2         TYPE i,
          lv_winy1         TYPE i,
          lv_winy2         TYPE i.
    FIELD-SYMBOLS <ls_logs> TYPE ty_log_data.

    SELECT logs~logid
           logs~docui
           logs~uname
           logs~datum
           logs~uzeit
           logs~logcd
           logs~logtx
           logs~sappr
      INTO CORRESPONDING FIELDS OF TABLE lt_logs
      FROM /itetr/inc_logs AS logs
      WHERE docui = iv_docui.

    CHECK sy-subrc IS INITIAL.
    SORT lt_logs BY datum DESCENDING uzeit DESCENDING.
    LOOP AT lt_logs ASSIGNING <ls_logs>.
      <ls_logs>-ddtext = /itetr/cl_regulative_common=>get_domain_value_text( iv_domname = '/ITETR/COM_D_LOGCD'
                                                                             iv_domvalue_l = <ls_logs>-logcd ).
    ENDLOOP.

    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = lo_salv_table
          CHANGING
            t_table      = lt_logs ).
        lo_columns = lo_salv_table->get_columns( ).
        lo_columns->set_optimize( abap_true ).
        lo_column = lo_columns->get_column( columnname = 'DOCUI' ).
        lo_column->set_visible( abap_false ).
        lo_column = lo_columns->get_column( columnname = 'LOGID' ).
        lo_column->set_visible( abap_false ).

        CALL FUNCTION 'CY_CENTER_WINDOW'
          EXPORTING
            dynpro_height = 10
            dynpro_width  = 100
            screen_height = sy-srows
            screen_width  = sy-scols
          IMPORTING
            winx1         = lv_winx1
            winx2         = lv_winx2
            winy1         = lv_winy1
            winy2         = lv_winy2.
        lo_salv_table->set_screen_popup(
          start_column = lv_winx1
          end_column   = lv_winx2
          start_line   = lv_winy1
          end_line     = lv_winy2 ).

        lo_salv_table->display( ).
      CATCH cx_root INTO lx_root.
        lv_error_message = lx_root->get_text( ).
        MESSAGE lv_error_message
          TYPE 'I'
          DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.