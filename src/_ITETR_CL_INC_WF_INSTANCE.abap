CLASS /itetr/cl_inc_wf_instance DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS mc_msgid TYPE t100-arbgb VALUE '/ITETR/INC' ##NO_TEXT.
    CONSTANTS:
      BEGIN OF mc_workflow ,
        top_task   TYPE sww_top_task VALUE 'WS00392301',
        class_name TYPE seoclsname VALUE '/ITETR/CL_INC_WF_OPERATIONS',
        event_name TYPE hr_s_event VALUE 'START_WORKFLOW',
      END OF mc_workflow .
    CONSTANTS:
      BEGIN OF mc_wf_status ,
        ready     TYPE /itetr/inc_t0001-wf_status VALUE 'READY',
        triggered TYPE /itetr/inc_t0001-wf_status VALUE 'TRIGGERED',
        started   TYPE /itetr/inc_t0001-wf_status VALUE 'STARTED',
        pending   TYPE /itetr/inc_t0001-wf_status VALUE 'PENDING',
        approved  TYPE /itetr/inc_t0001-wf_status VALUE 'APPROVED',
        rejected  TYPE /itetr/inc_t0001-wf_status VALUE 'REJECTED',
        cancelled TYPE /itetr/inc_t0001-wf_status VALUE 'CANCELLED',
        not_found TYPE /itetr/inc_t0001-wf_status VALUE 'NOT_FOUND',
        save_as   TYPE /itetr/inc_t0001-wf_status VALUE 'SAVE_AS',
      END OF mc_wf_status .
    CONSTANTS:
      BEGIN OF mc_difference_type ,
        amount   TYPE /itetr/inc_difft-difference_type VALUE 'AMOUNT',
        quantity TYPE /itetr/inc_difft-difference_type VALUE 'QUANTITY',
      END OF mc_difference_type .

    METHODS event_raised
      IMPORTING
        !im_event_name       TYPE sww_evttyp
        !im_workitem_context TYPE REF TO if_wapi_workitem_context
      RAISING
        cx_swf_ifs_workitem_exit_error .
    METHODS call_workflow
      IMPORTING
        !it_document     TYPE /itetr/inc_tt_document_id_char OPTIONAL
      RETURNING
        VALUE(rt_return) TYPE bapiret2_tab .
    METHODS create_log
      CHANGING
        !cs_parameters TYPE /itetr/inc_s_wf_parameters .
    METHODS get_approver
      IMPORTING
        !iv_wf_status  TYPE /itetr/inc_de_wf_status
      CHANGING
        !cs_parameters TYPE /itetr/inc_s_wf_parameters .
    METHODS execute_update_operations
      IMPORTING
        !iv_wi_id            TYPE sww_wiid
        !iv_wf_status        TYPE /itetr/inc_de_wf_status
        !iv_wf_actual_user   TYPE uname
        !iv_wf_decision_desc TYPE /itetr/inc_de_wf_decision_desc
      EXPORTING
        !et_return           TYPE bapiret2_tab
      CHANGING
        !cs_parameters       TYPE /itetr/inc_s_wf_parameters .
    METHODS create_task_description
      IMPORTING
        !is_parameters           TYPE /itetr/inc_s_wf_parameters
      RETURNING
        VALUE(rt_html_task_desc) TYPE htmltable .
  PROTECTED SECTION.
private section.

  methods UPDATE_TASK_DESCRIPTION
    importing
      !IO_WORKITEM_CONTEXT type ref to IF_WAPI_WORKITEM_CONTEXT .
ENDCLASS.



CLASS /ITETR/CL_INC_WF_INSTANCE IMPLEMENTATION.


  METHOD call_workflow.

    DATA lt_bukrs TYPE RANGE OF t001-bukrs.
    DATA ls_bukrs LIKE LINE OF lt_bukrs.
    DATA lt_docui TYPE RANGE OF /itetr/inc_t0001-docui.
    DATA lt_wf_scenario_code TYPE RANGE OF /itetr/inc_wfscn-wf_scenario_code.

    DATA lt_t0002 TYPE SORTED TABLE OF /itetr/inc_t0002 WITH UNIQUE KEY primary_key COMPONENTS docui line.
    DATA lt_approver_list TYPE /itetr/inc_tt_wf_approver_list.

    IF it_document IS INITIAL.
      APPEND VALUE #( id = mc_msgid type = 'E' number = '007' ) TO rt_return.
      RETURN.
    ENDIF.

    CLEAR lt_docui.

    LOOP AT it_document INTO DATA(ls_document).
      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_document-docui ) TO lt_docui.
    ENDLOOP.

    CLEAR lt_t0002.

    DATA(lt_detail) = VALUE /itetr/inc_tt_wf_detail( ).

    SELECT *
           FROM /itetr/inc_t0001
           WHERE docui IN @lt_docui
           ORDER BY docui
           INTO TABLE @DATA(lt_t0001).

    IF lt_t0001 IS INITIAL.
      APPEND VALUE #( id = mc_msgid type = 'E' number = '008' ) TO rt_return.
      RETURN.
    ENDIF.

    CLEAR lt_docui.

    LOOP AT lt_t0001 INTO DATA(ls_t0001).
      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_t0001-docui ) TO lt_docui.
    ENDLOOP.

    SELECT *
           INTO TABLE lt_t0002
           FROM /itetr/inc_t0002
           WHERE docui IN lt_docui.

    SELECT dd03l~fieldname ,
           dd03l~position ,
           dd03l~tabname ,
           dd03l~reftable
           FROM dd03l
           WHERE dd03l~tabname EQ '/ITETR/INC_S_WF_SCENARIO_KEYS'
             AND dd03l~comptype EQ 'E'  "Data element
             AND dd03l~adminfield EQ '0'  "Nesting depth for includes
           ORDER BY dd03l~position
           INTO TABLE @DATA(lt_wf_condition).

    SELECT deep_structure~fieldname ,
           deep_structure~position ,
           deep_structure~tabname ,
           deep_structure~reftable
           FROM dd03l
           INNER JOIN dd03l AS deep_structure ON deep_structure~tabname EQ dd03l~precfield
                                             AND deep_structure~comptype EQ 'E'  "Data element
           WHERE dd03l~tabname EQ '/ITETR/INC_S_WF_SCENARIO_KEYS'
             AND dd03l~adminfield EQ '0'  "Nesting depth for includes
           ORDER BY dd03l~position , deep_structure~position
           APPENDING TABLE @lt_wf_condition.

    DATA(lt_dynamic) = VALUE string_table( ).
    APPEND '/ITETR/INC_T0001~DOCUI' TO lt_dynamic.
    APPEND 'EKKO~AEDAT' TO lt_dynamic.
    APPEND 'EKKO~EBELN' TO lt_dynamic.

    LOOP AT lt_wf_condition ASSIGNING FIELD-SYMBOL(<ls_wf_condition>).
      <ls_wf_condition>-position = sy-tabix.

      CASE <ls_wf_condition>-tabname.
        WHEN '/ITETR/INC_S_WF_SCENARIO_KEYS'.
          CASE <ls_wf_condition>-fieldname.
            WHEN 'DIFFERENCE_TYPE'.
              <ls_wf_condition>-reftable = '/ITETR/INC_DIFFT'.
          ENDCASE.
        WHEN '/ITETR/INC_S_WF_KEY_T0001'.
          <ls_wf_condition>-reftable = '/ITETR/INC_T0001'.
        WHEN 'CI_ITETR_INC_WF_KEY_T0002'.
          <ls_wf_condition>-reftable = '/ITETR/INC_T0002'.
        WHEN '/ITETR/INC_S_WF_KEY_EKKO'.
          <ls_wf_condition>-reftable = 'EKKO'.
        WHEN 'CI_ITETR_INC_WF_KEY_EKPO'.
          <ls_wf_condition>-reftable = 'EKPO'.
        WHEN 'CI_ITETR_INC_WF_KEY_LFA1'.
          <ls_wf_condition>-reftable = 'LFA1'.
        WHEN 'CI_ITETR_INC_WF_KEY_BUT000'.
          <ls_wf_condition>-reftable = 'BUT000'.
        WHEN OTHERS.
          CONTINUE.
      ENDCASE.

      DATA(lv_dynamic) = VALUE string( ).

      CONCATENATE <ls_wf_condition>-reftable
                  <ls_wf_condition>-fieldname
             INTO lv_dynamic
             SEPARATED BY '~'.

      APPEND lv_dynamic TO lt_dynamic.
    ENDLOOP.

    TRY.
        SELECT DISTINCT
               (lt_dynamic)
               INTO TABLE lt_detail
               FROM /itetr/inc_t0001
               INNER JOIN /itetr/inc_difft ON /itetr/inc_difft~docui EQ /itetr/inc_t0001~docui
               INNER JOIN /itetr/inc_t0004 ON /itetr/inc_t0004~docui EQ /itetr/inc_t0001~docui
                                          AND /itetr/inc_t0004~despid NE space
               INNER JOIN mkpf ON mkpf~xblnr EQ /itetr/inc_t0004~despid
               INNER JOIN mseg ON mseg~mjahr EQ mkpf~mjahr
                              AND mseg~mblnr EQ mkpf~mblnr
                              AND mseg~xauto EQ space
               INNER JOIN ekko ON ekko~ebeln EQ mseg~ebeln
               INNER JOIN lfa1 ON lfa1~lifnr EQ ekko~lifnr
               LEFT OUTER JOIN but000 ON but000~partner EQ ekko~lifnr
               WHERE /itetr/inc_t0001~docui IN lt_docui.

        SELECT DISTINCT
               (lt_dynamic)
               APPENDING TABLE lt_detail
               FROM /itetr/inc_t0001
               INNER JOIN /itetr/inc_difft ON /itetr/inc_difft~docui EQ /itetr/inc_t0001~docui
               INNER JOIN /itetr/inc_t0006 ON /itetr/inc_t0006~docui EQ /itetr/inc_t0001~docui
                                          AND /itetr/inc_t0006~orderid NE space
               INNER JOIN ekko ON ekko~ebeln EQ /itetr/inc_t0006~orderid
               INNER JOIN lfa1 ON lfa1~lifnr EQ ekko~lifnr
               LEFT OUTER JOIN but000 ON but000~partner EQ ekko~lifnr
               WHERE /itetr/inc_t0001~docui IN lt_docui.

      IF lt_detail[] is INITIAL.
        APPEND VALUE #( id = mc_msgid type = 'E' number = '012' ) TO rt_return.
      ENDIF.

      CATCH cx_root INTO DATA(lx_root).
        DATA(lv_error_text) = lx_root->get_text( ).

        APPEND VALUE #( id = mc_msgid type = 'E' number = '012' ) TO rt_return.
        RETURN.
    ENDTRY.

    CHECK lt_detail IS NOT INITIAL.

    DELETE ADJACENT DUPLICATES FROM lt_detail USING KEY wf_condition_keys COMPARING ALL FIELDS.

    DATA(lt_possibility) = VALUE /itetr/inc_tt_wf_possibility( ).

    LOOP AT lt_detail INTO DATA(ls_detail) USING KEY wf_condition_keys.
      ls_bukrs = VALUE #( sign = 'I' option = 'EQ' low = ls_detail-bukrs ).
      COLLECT ls_bukrs INTO lt_bukrs.

      DATA(ls_possibility) = CORRESPONDING /itetr/inc_s_wf_possibility( ls_detail ).
      ls_possibility-document_key = ls_detail.
      APPEND ls_possibility TO lt_possibility.
    ENDLOOP.

    SORT lt_possibility BY document_key.

    SORT lt_wf_condition BY position DESCENDING.

    "Senaryo bakımında * İçermeyen alanları sil
    DELETE lt_wf_condition WHERE fieldname EQ 'BUKRS'
                              OR fieldname EQ 'DIFFERENCE_TYPE'.

    LOOP AT lt_possibility INTO ls_possibility.
      LOOP AT lt_wf_condition INTO DATA(ls_wf_condition).
        DATA(ls_possibility_new) = ls_possibility.
        ASSIGN COMPONENT ls_wf_condition-fieldname OF STRUCTURE ls_possibility_new TO FIELD-SYMBOL(<lv_value>).
        CHECK sy-subrc EQ 0.

        CHECK <lv_value> NE '*'.

        <lv_value> = '*'.
        COLLECT ls_possibility_new INTO lt_possibility.
      ENDLOOP.
    ENDLOOP.

    LOOP AT lt_possibility ASSIGNING FIELD-SYMBOL(<ls_possibility>).
      DATA(lv_priority) = VALUE /itetr/inc_de_priority( ).

      LOOP AT lt_wf_condition INTO ls_wf_condition.
        lv_priority = 5 ** sy-tabix.

        ASSIGN COMPONENT ls_wf_condition-fieldname OF STRUCTURE <ls_possibility> TO <lv_value>.
        CHECK sy-subrc EQ 0.

        IF <lv_value> EQ '*'.
          <ls_possibility>-star_count = <ls_possibility>-star_count + 1.
          <ls_possibility>-priority = <ls_possibility>-priority + lv_priority.
        ENDIF.
      ENDLOOP.

      DATA(ls_scenario_keys) = CORRESPONDING /itetr/inc_s_wf_scenario_keys( <ls_possibility> ).
      <ls_possibility>-scenario_key = ls_scenario_keys.
    ENDLOOP.

    SORT lt_possibility BY document_key star_count priority.

    IF lt_bukrs IS NOT INITIAL.
      SELECT *
             FROM /itetr/inc_wfcnd
             WHERE bukrs IN @lt_bukrs
             INTO TABLE @DATA(lt_wfcnd).
    ENDIF.

    DATA(lt_condition) = VALUE /itetr/inc_tt_wf_condition( ).

    LOOP AT lt_wfcnd INTO DATA(ls_wfcnd).
      ls_scenario_keys = CORRESPONDING #( ls_wfcnd ).

      DATA(ls_condition) = CORRESPONDING /itetr/inc_s_wf_condition( ls_wfcnd ).
      ls_condition-scenario_key = ls_scenario_keys.
      APPEND ls_condition TO lt_condition.
    ENDLOOP.

    SORT lt_condition BY scenario_key.

    SELECT *
           FROM /itetr/inc_wfscn
           ORDER BY wf_scenario_code
           INTO TABLE @DATA(lt_wfscn).

    CLEAR lt_wf_scenario_code.

    LOOP AT lt_possibility ASSIGNING <ls_possibility>.
      CLEAR ls_condition.
      READ TABLE lt_condition INTO ls_condition WITH KEY scenario_key = <ls_possibility>-scenario_key BINARY SEARCH.
      IF sy-subrc EQ 0.
        <ls_possibility>-wf_scenario_code = ls_condition-wf_scenario_code.

        READ TABLE lt_wfscn INTO DATA(ls_wfscn) WITH KEY wf_scenario_code = ls_condition-wf_scenario_code BINARY SEARCH.
        IF sy-subrc EQ 0.
          <ls_possibility>-wf_priority = ls_wfscn-wf_priority.
        ENDIF.

        APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_condition-wf_scenario_code ) TO lt_wf_scenario_code.
      ELSE.
        DELETE lt_possibility.
      ENDIF.
    ENDLOOP.

    SORT lt_possibility BY document_key star_count priority wf_priority.

    CLEAR lt_approver_list.

    IF lt_wf_scenario_code IS NOT INITIAL.
      SELECT /itetr/inc_wfscn~wf_priority ,
             /itetr/inc_wfscn~wf_scenario_code ,
             /itetr/inc_wfscn~wf_scenario_type ,
             /itetr/inc_wfapr~wf_step_number ,
             /itetr/inc_wfapr~wf_approver ,
             /itetr/inc_wfapr~wf_step_type
             FROM /itetr/inc_wfscn
             INNER JOIN /itetr/inc_wfapr ON /itetr/inc_wfapr~wf_scenario_code EQ /itetr/inc_wfscn~wf_scenario_code
             WHERE /itetr/inc_wfscn~wf_scenario_code IN @lt_wf_scenario_code
             INTO TABLE @lt_approver_list.

      SORT lt_approver_list BY wf_priority wf_scenario_code wf_step_number.
    ENDIF.

    LOOP AT lt_t0001 INTO ls_t0001.
      DATA(lt_return) = VALUE bapiret2_tab( ).

      DATA(ls_parameters) = VALUE /itetr/inc_s_wf_parameters( ).
      ls_parameters-docui = ls_t0001-docui.
      ls_parameters-invno = ls_t0001-invno.
      ls_parameters-erdat = sy-datum.
      ls_parameters-erzet = sy-uzeit.
      ls_parameters-ernam = sy-uname.
      ls_parameters-s_t0001 = ls_t0001.

      LOOP AT lt_detail INTO ls_detail USING KEY wf_condition_keys WHERE docui EQ ls_detail-docui.
        DATA(lv_document_key) = CONV edi_sdata( ls_detail ).

        CLEAR ls_possibility.
        READ TABLE lt_possibility INTO ls_possibility WITH KEY document_key = lv_document_key BINARY SEARCH.
        IF sy-subrc EQ 0.
          DATA(ls_wf_scenario_code) = VALUE /itetr/inc_s_wf_scenario_code( ).
          ls_wf_scenario_code-wf_scenario_code = ls_possibility-wf_scenario_code .
          COLLECT ls_wf_scenario_code INTO ls_parameters-t_wf_scenario_code.

          READ TABLE lt_approver_list TRANSPORTING NO FIELDS WITH KEY wf_scenario_code = ls_possibility-wf_scenario_code.
          IF sy-subrc EQ 0.
            LOOP AT lt_approver_list INTO DATA(ls_approver_list) WHERE wf_scenario_code EQ ls_possibility-wf_scenario_code.
              APPEND ls_approver_list TO ls_parameters-t_approver_list.
            ENDLOOP.
          ELSE.
            APPEND VALUE #( id = mc_msgid type = 'E' number = '011'
                            message_v1 = ls_t0001-invno
                            message_v2 = ls_detail-ebeln
                            message_v3 = ls_possibility-wf_scenario_code ) TO lt_return.
          ENDIF.
        ELSE.
          APPEND VALUE #( id = mc_msgid type = 'E' number = '010'
                          message_v1 = ls_t0001-invno
                          message_v2 = ls_detail-ebeln ) TO lt_return.
        ENDIF.
      ENDLOOP.

      IF ls_parameters-t_wf_scenario_code IS INITIAL.
        APPEND VALUE #( id = mc_msgid type = 'E' number = '009'
                        message_v1 = ls_t0001-invno ) TO lt_return.
      ENDIF.

      IF lt_return IS NOT INITIAL.
        APPEND LINES OF lt_return TO rt_return.
        CONTINUE.
      ENDIF.

      SORT ls_parameters-t_approver_list BY wf_priority wf_step_number wf_approver.
      DELETE ADJACENT DUPLICATES FROM ls_parameters-t_approver_list COMPARING wf_approver.

      LOOP AT lt_t0002 INTO DATA(ls_t0002) USING KEY primary_key WHERE docui EQ ls_t0001-docui.
        APPEND ls_t0002 TO ls_parameters-t_t0002.
      ENDLOOP.

      DATA(lo_event_container) =
      cl_swf_evt_event=>get_event_container(
        EXPORTING
          im_objcateg  = cl_swf_evt_event=>mc_objcateg_cl
          im_objtype   = mc_workflow-class_name
          im_event     = mc_workflow-event_name
      ).

      CHECK lo_event_container IS BOUND.

      DATA(lv_objkey) = CONV sibfinstid( ls_t0001-docui ).

      TRY .
          lo_event_container->set( EXPORTING name = 'PARAMETERS' value = ls_parameters ).

          cl_swf_evt_event=>raise(
            EXPORTING
              im_objcateg        = cl_swf_evt_event=>mc_objcateg_cl
              im_objtype         = mc_workflow-class_name
              im_event           = mc_workflow-event_name
              im_objkey          = lv_objkey
              im_event_container = lo_event_container
          ).

          COMMIT WORK AND WAIT.

          UPDATE /itetr/inc_t0001 SET wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-triggered
                                WHERE docui EQ ls_detail-docui.
          IF sy-subrc EQ 0.
            COMMIT WORK AND WAIT.
          ENDIF.
        CATCH cx_root.
      ENDTRY.
    ENDLOOP.

  ENDMETHOD.


  METHOD create_log.

    DELETE FROM /itetr/inc_wfhdr WHERE docui EQ cs_parameters-docui.
    DELETE FROM /itetr/inc_wfstp WHERE docui EQ cs_parameters-docui.

    DATA(ls_hdrlog) = CORRESPONDING /itetr/inc_wfhdr( cs_parameters ).
    ls_hdrlog-wf_status = mc_wf_status-started.
    ls_hdrlog-wf_status_date = sy-datum.
    ls_hdrlog-wf_status_time = sy-uzeit.

    MODIFY /itetr/inc_wfhdr FROM ls_hdrlog.

    UPDATE /itetr/inc_t0001 SET wf_status = ls_hdrlog-wf_status
                          WHERE docui EQ ls_hdrlog-docui.

  ENDMETHOD.


  METHOD create_task_description.

    DATA lt_ebeln TYPE RANGE OF ekko-ebeln.

    DATA(lv_langu) = CONV sy-langu( 'T' ).

    SELECT DISTINCT
           mseg~ebeln AS low
           INTO CORRESPONDING FIELDS OF TABLE lt_ebeln
           FROM /itetr/inc_t0001
           INNER JOIN /itetr/inc_t0004 ON /itetr/inc_t0004~docui EQ /itetr/inc_t0001~docui
                                      AND /itetr/inc_t0004~despid NE space
           INNER JOIN mkpf ON mkpf~xblnr EQ /itetr/inc_t0004~despid
           INNER JOIN mseg ON mseg~mjahr EQ mkpf~mjahr
                          AND mseg~mblnr EQ mkpf~mblnr
                          AND mseg~xauto EQ space
           WHERE /itetr/inc_t0001~docui EQ is_parameters-docui.

    SELECT DISTINCT
           ekko~ebeln AS low
           APPENDING CORRESPONDING FIELDS OF TABLE @lt_ebeln
           FROM /itetr/inc_t0001
           INNER JOIN /itetr/inc_t0006 ON /itetr/inc_t0006~docui EQ /itetr/inc_t0001~docui
                                      AND /itetr/inc_t0006~orderid NE @space
           INNER JOIN ekko ON ekko~ebeln EQ /itetr/inc_t0006~orderid
           WHERE /itetr/inc_t0001~docui EQ @is_parameters-docui.

    CHECK lt_ebeln IS NOT INITIAL.

    LOOP AT lt_ebeln ASSIGNING FIELD-SYMBOL(<ls_ebeln>).
      <ls_ebeln>-sign = 'I'.
      <ls_ebeln>-option = 'EQ'.
    ENDLOOP.

    SELECT ekko~ebeln ,
           ekko~ernam ,
           ekko~aedat ,
           ekko~ekorg ,
           t024e~ekotx ,
           ekko~ekgrp ,
           t024~eknam ,
           ekko~lifnr ,
           lfa1~name1 AS lifnr_name1 ,
           lfa1~name2 AS lifnr_name2 ,
           ekko~zterm ,
           tvzbt~vtext AS zterm_desc ,
           ekko~waers
           FROM ekko
           LEFT OUTER JOIN lfa1 ON lfa1~lifnr EQ ekko~lifnr
           LEFT OUTER JOIN t024 ON t024~ekgrp EQ ekko~ekgrp
           LEFT OUTER JOIN t024e ON t024e~ekorg EQ ekko~ekorg
           LEFT OUTER JOIN tvzbt ON tvzbt~zterm EQ ekko~zterm
                                AND tvzbt~spras EQ @lv_langu
           WHERE ekko~ebeln IN @lt_ebeln
           ORDER BY ekko~ebeln
           INTO TABLE @DATA(lt_po_header).

    CHECK lt_po_header IS NOT INITIAL.

    SELECT ekpo~ebeln ,
           ekpo~ebelp ,
           ekpo~werks ,
           t001w~name1 AS werks_name ,
           ekpo~lgort ,
           t001l~lgobe ,
           ekpo~matnr ,
           makt~maktx ,
           ekpo~txz01 ,
           ekpo~menge ,
           ekpo~meins ,
           ekpo~netwr ,
           ekpo~netpr ,
           ekpo~peinh
           INTO TABLE @DATA(lt_po_item)
           FROM ekpo
           INNER JOIN t001w ON t001w~werks EQ ekpo~werks
           INNER JOIN t001l ON t001l~werks EQ ekpo~werks
                           AND t001l~lgort EQ ekpo~lgort
           LEFT OUTER JOIN makt ON makt~matnr EQ ekpo~matnr
                               AND makt~spras EQ @lv_langu
           WHERE ekpo~ebeln IN @lt_ebeln
           ORDER BY ekpo~ebeln ,
                    ekpo~ebelp.

    SELECT ekpo~ebeln ,
           SUM( ekpo~netwr ) AS netwr
           INTO TABLE @DATA(lt_po_amount)
           FROM ekpo
           WHERE ekpo~ebeln IN @lt_ebeln
           GROUP BY ekpo~ebeln
           ORDER BY ekpo~ebeln.

    SELECT SINGLE /itetr/inc_t0001~invno ,
                  /itetr/inc_t0001~bukrs ,
                  t001~butxt ,
                  /itetr/inc_t0001~dmbtr ,
                  /itetr/inc_t0001~waers ,
                  /itetr/inc_t0001~lifnr ,
                  lfa1~name1 AS lifnr_name1 ,
                  lfa1~name2 AS lifnr_name2 ,
                  /itetr/inc_t0001~prfid
             FROM /itetr/inc_t0001
             LEFT OUTER JOIN t001 ON t001~bukrs EQ /itetr/inc_t0001~bukrs
             LEFT OUTER JOIN lfa1 ON lfa1~lifnr EQ /itetr/inc_t0001~lifnr
            WHERE /itetr/inc_t0001~docui EQ @is_parameters-docui
             INTO @DATA(ls_header).

    SELECT /itetr/inc_difft~difference_type ,
           dd07v~ddtext AS difference_type_desc
           FROM /itetr/inc_difft
           LEFT OUTER JOIN dd07v ON dd07v~domname EQ '/ITETR/INC_D_DIFFERENCE_TYPE'
                                AND dd07v~domvalue_l EQ /itetr/inc_difft~difference_type
                                AND dd07v~ddlanguage EQ @lv_langu
           WHERE /itetr/inc_difft~docui EQ @is_parameters-docui
           INTO TABLE @DATA(lt_difference).

    SELECT /itetr/inc_t0002~line ,
           /itetr/inc_t0002~ebeln ,
           /itetr/inc_t0002~ebelp ,
           /itetr/inc_t0002~matnr ,
           /itetr/inc_t0002~txz01 ,
           /itetr/inc_t0002~menge ,
           /itetr/inc_t0002~meins ,
           /itetr/inc_t0002~netwr ,
           /itetr/inc_difit~difference_type
           FROM /itetr/inc_t0002
           LEFT OUTER JOIN /itetr/inc_difit ON /itetr/inc_difit~docui EQ /itetr/inc_t0002~docui
                                           AND /itetr/inc_difit~line  EQ /itetr/inc_t0002~line
           WHERE /itetr/inc_t0002~docui EQ @is_parameters-docui
           ORDER BY /itetr/inc_t0002~line
           INTO TABLE @DATA(lt_item).

    SELECT msehi ,
           mseh3
           INTO TABLE @DATA(lt_t006) FROM t006a
           WHERE spras EQ @lv_langu
           ORDER BY msehi.

    rt_html_task_desc = VALUE #( ( tdline = '<html>' )
                                 ( tdline = '<body>' ) ).

    APPEND LINES OF VALUE htmltable( ( tdline = '<table border ="2">' )
                                     ( tdline = '<tr><th colspan="2"><font size = "3"> E-Fatura Başlık Bilgileri </font></th></tr>' )

                                     ( tdline = '<tr><td><font size = "3"> E-Fatura </font></td><td><font size = "3">' )
                                     ( tdline = |{ ls_header-invno ALPHA = OUT }| && '</font></td></tr>' )

                                     ( tdline = '<tr><td><font size = "3"> Senaryo </font></td><td><font size = "3">' )
                                     ( tdline = ls_header-prfid && '</font></td></tr>' )

                                     ( tdline = '<tr><td><font size = "3"> Şirket Kodu </font></td><td><font size = "3">' )
                                     ( tdline = ls_header-bukrs && ` / ` && ls_header-butxt && '</font></td></tr>' )

                                     ( tdline = '<tr><td><font size = "3"> Satıcı </font></td><td><font size = "3">' )
                                     ( tdline = |{ ls_header-lifnr ALPHA = OUT }| && ` / ` && ls_header-lifnr_name1 && ` ` && ls_header-lifnr_name2 && '</font></td></tr>' )

                                     ( tdline = '<tr><td><font size = "3"> Mal Hizmet Tutarı </font></td><td><font size = "3">' )
                                     ( tdline = |{ ls_header-dmbtr NUMBER = USER }| && ` ` && ls_header-waers && '</font></td></tr>' ) ) TO rt_html_task_desc.

    LOOP AT lt_difference INTO DATA(ls_difference).
      APPEND LINES OF VALUE htmltable( ( tdline = '<tr>' )

                                       ( tdline = '<td style="text-align:left"><font size = "3">' )
                                       ( tdline = `Fark Türü ` && sy-tabix && '</font></td>' )

                                       ( tdline = '<td style="text-align:left"><font size = "3">' )
                                       ( tdline = ls_difference-difference_type && ` / ` && ls_difference-difference_type_desc && '</font></td></tr>' )

                                       ( tdline = '</tr>' ) ) TO rt_html_task_desc.
    ENDLOOP.

    APPEND VALUE #( tdline = '</table>' ) TO rt_html_task_desc.

    APPEND LINES OF VALUE htmltable( ( tdline = '<table border ="2">' )
                                     ( tdline = '<tr><th colspan="8"><font size = "3"> E-Fatura Kalem Bilgileri </font></th></tr>' )
                                     ( tdline = '<tr>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> E-Fatura Kalem </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Malzeme        </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Kalem Tanımı   </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Miktar         </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> ÖB             </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Net Değer      </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Sipariş        </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Kalem          </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Fark Tip       </font></td>' )"AN
                                     ( tdline = '</tr>' ) ) TO rt_html_task_desc.

    LOOP AT lt_item INTO DATA(ls_item).
      READ TABLE lt_t006 INTO DATA(ls_t006) WITH KEY msehi = ls_item-meins BINARY SEARCH.

      APPEND LINES OF VALUE htmltable( ( tdline = '<tr>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = |{ ls_item-line NUMBER = ENVIRONMENT }| && '</font></td>' )

                                       ( tdline = '<td style="text-align:left"><font size = "3">' )
                                       ( tdline = |{ ls_item-matnr ALPHA = OUT }| && '</font></td>' )

                                       ( tdline = '<td style="text-align:left"><font size = "3">' )
                                       ( tdline = ls_item-txz01 && '</font></td>' )

                                       ( tdline = '<td style="text-align:right"><font size = "3">' )
                                       ( tdline = |{ ls_item-menge NUMBER = USER }| && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = ls_t006-mseh3 && '</font></td>' )

                                       ( tdline = '<td style="text-align:right"><font size = "3">' )
                                       ( tdline = |{ ls_item-netwr NUMBER = USER }| && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = |{ ls_item-ebeln ALPHA = OUT }| && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = COND #( WHEN ls_item-ebelp IS NOT INITIAL THEN |{ ls_item-ebelp ALPHA = OUT }| ) && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = |{ ls_item-difference_type ALPHA = OUT }| && '</font></td>' )

                                       ( tdline = '</tr>' ) ) TO rt_html_task_desc.

      CLEAR ls_t006.
    ENDLOOP.

    APPEND VALUE #( tdline = '</table>' ) TO rt_html_task_desc.

    LOOP AT lt_po_header INTO DATA(ls_po_header).
      READ TABLE lt_po_amount INTO DATA(ls_po_amount) WITH KEY ebeln = ls_po_header-ebeln BINARY SEARCH.

      APPEND LINES OF VALUE htmltable( ( tdline = '<br>' )
                                       ( tdline = '<table border ="2">' )
                                       ( tdline = '<tr><th colspan="10"><font size = "3"> Satınalma Siparişi:' && ` ` && |{ ls_po_header-ebeln ALPHA = OUT }| && ` ` && 'Başlık Bilgileri </font></th></tr>' )

                                       ( tdline = '<tr><td><font size = "3"> Satınalma Siparişi </font></td><td><font size = "3">' )
                                       ( tdline = |{ ls_po_header-ebeln ALPHA = OUT }| && '</font></td></tr>' )

                                       ( tdline = '<tr><td><font size = "3"> Yaratan </font></td><td><font size = "3">' )
                                       ( tdline = ls_po_header-ernam && '</font></td></tr>' )

                                       ( tdline = '<tr><td><font size = "3"> Yaratma Tarihi </font></td><td><font size = "3">' )
                                       ( tdline = |{ ls_po_header-aedat DATE = USER }| && '</font></td></tr>' )

                                       ( tdline = '<tr><td><font size = "3"> Satınalma Organizasyonu </font></td><td><font size = "3">' )
                                       ( tdline = ls_po_header-ekorg && ` / ` && ls_po_header-ekotx && '</font></td></tr>' )

                                       ( tdline = '<tr><td><font size = "3"> Satınalma Grubu </font></td><td><font size = "3">' )
                                       ( tdline = COND #( WHEN ls_po_header-ekgrp IS NOT INITIAL THEN ls_po_header-ekgrp && ` / ` && ls_po_header-eknam ) && '</font></td></tr>' )

                                       ( tdline = '<tr><td><font size = "3"> Satıcı </font></td><td><font size = "3">' )
                                       ( tdline = |{ ls_po_header-lifnr ALPHA = OUT }| && ` / ` && ls_po_header-lifnr_name1 && ` ` && ls_po_header-lifnr_name2 && '</font></td></tr>' )

                                       ( tdline = '<tr><td><font size = "3"> Ödeme Koşulu </font></td><td><font size = "3">' )
                                       ( tdline = COND #( WHEN ls_po_header-zterm IS NOT INITIAL THEN ls_po_header-zterm && ` / ` )  && ls_po_header-zterm_desc && '</font></td></tr>' )

                                       ( tdline = '<tr><td><font size = "3"> Net Değer </font></td><td><font size = "3">' )
                                       ( tdline = |{ ls_po_amount-netwr NUMBER = USER }| && ` ` && ls_po_header-waers && '</font></td></tr>' )

                                       ( tdline = '</table>' ) ) TO rt_html_task_desc.

      APPEND LINES OF VALUE htmltable( ( tdline = '<table border ="2">' )
                                       ( tdline = '<tr><th colspan="9"><font size = "3"> Satınalma Siparişi:' && ` ` && |{ ls_po_header-ebeln ALPHA = OUT }| && ` ` && 'Kalem Bilgileri </font></th></tr>' )
                                       ( tdline = '<tr>' )
                                       ( tdline = '<td style="text-align:center"><font size = "3"> Kalem        </font></td>' )
                                       ( tdline = '<td style="text-align:center"><font size = "3"> Malzeme      </font></td>' )
                                       ( tdline = '<td style="text-align:center"><font size = "3"> Kalem Tanımı </font></td>' )
                                       ( tdline = '<td style="text-align:center"><font size = "3"> Üretim Yeri  </font></td>' )
                                       ( tdline = '<td style="text-align:center"><font size = "3"> Depo Yeri    </font></td>' )
                                       ( tdline = '<td style="text-align:center"><font size = "3"> Miktar       </font></td>' )
                                       ( tdline = '<td style="text-align:center"><font size = "3"> ÖB           </font></td>' )
                                       ( tdline = '<td style="text-align:center"><font size = "3"> Fiyat Birimi </font></td>' )
                                       ( tdline = '<td style="text-align:center"><font size = "3"> Net Değer    </font></td>' )
                                       ( tdline = '</tr>' ) ) TO rt_html_task_desc.

      LOOP AT lt_po_item INTO DATA(ls_po_item) WHERE ebeln EQ ls_po_header-ebeln.
        CLEAR ls_t006.
        READ TABLE lt_t006 INTO ls_t006 WITH KEY msehi = ls_po_item-meins BINARY SEARCH.

        APPEND LINES OF VALUE htmltable( ( tdline = '<tr>' )

                                         ( tdline = '<td style="text-align:center"><font size = "3">' )
                                         ( tdline = |{ ls_po_item-ebelp ALPHA = OUT }| && '</font></td>' )

                                         ( tdline = '<td style="text-align:left"><font size = "3">' )
                                         ( tdline = |{ ls_po_item-matnr ALPHA = OUT }| && '</font></td>' )

                                         ( tdline = '<td style="text-align:left"><font size = "3">' )
                                         ( tdline = ls_po_item-txz01 && '</font></td>' )

                                         ( tdline = '<td style="text-align:center"><font size = "3">' )
                                         ( tdline = ls_po_item-werks && '</font></td>' )

                                         ( tdline = '<td style="text-align:center"><font size = "3">' )
                                         ( tdline = ls_po_item-lgort && '</font></td>' )

                                         ( tdline = '<td style="text-align:right"><font size = "3">' )
                                         ( tdline = |{ ls_po_item-menge NUMBER = USER }| && '</font></td>' )

                                         ( tdline = '<td style="text-align:center"><font size = "3">' )
                                         ( tdline = ls_t006-mseh3 && '</font></td>' )

                                         ( tdline = '<td style="text-align:right"><font size = "3">' )
                                         ( tdline = |{ ls_po_item-netpr NUMBER = USER }| && ` / ` && |{ ls_po_item-peinh NUMBER = USER }| && '</font></td>' )

                                         ( tdline = '<td style="text-align:right"><font size = "3">' )
                                         ( tdline = |{ ls_po_item-netwr NUMBER = USER }| && '</font></td>' )

                                         ( tdline = '</tr>' ) ) TO rt_html_task_desc.
      ENDLOOP.

      APPEND VALUE #( tdline = '</table>' ) TO rt_html_task_desc.

      CLEAR ls_po_amount.
    ENDLOOP.

    SELECT /itetr/inc_wfstp~docui ,
           /itetr/inc_wfstp~wf_step_number ,
           /itetr/inc_wfstp~wi_id ,
           /itetr/inc_wfstp~wf_pending_date ,
           /itetr/inc_wfstp~wf_pending_time ,
           /itetr/inc_wfstp~wf_pending_user ,
           /itetr/inc_wfstp~wf_status ,
           dd07v~ddtext AS wf_status_desc ,
           /itetr/inc_wfstp~wf_status_date ,
           /itetr/inc_wfstp~wf_status_time ,
           /itetr/inc_wfstp~wf_status_user ,
           /itetr/inc_wfstp~wf_decision_desc
           FROM /itetr/inc_wfstp
           LEFT OUTER JOIN dd07v ON dd07v~domname EQ '/ITETR/INC_D_WF_STATUS'
                                AND dd07v~domvalue_l EQ /itetr/inc_wfstp~wf_status
                                AND dd07v~ddlanguage EQ @lv_langu
           WHERE /itetr/inc_wfstp~docui EQ @is_parameters-docui
           ORDER BY /itetr/inc_wfstp~wf_step_number
           INTO TABLE @DATA(lt_wfstp).

    APPEND LINES OF VALUE htmltable( ( tdline = '<br>' )
                                     ( tdline = '<table border ="2">' )
                                     ( tdline = '<tr><th colspan="9"><font size = "3">' && 'Onay Bilgileri' && '</font></th></tr>' )
                                     ( tdline = '<tr>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Onay Adımı              </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Onaya Düşme Tarihi      </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Onaya Düşme Saati       </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Onayına Düşen Kullanıcı </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Onay Durumu             </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Onay Durumu Tarihi      </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Onay Durumu Saati       </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Onay Durumu Kullanıcısı </font></td>' )
                                     ( tdline = '<td style="text-align:center"><font size = "3"> Onay Durumu Metni       </font></td>' )
                                     ( tdline = '</tr>' ) ) TO rt_html_task_desc.

    LOOP AT lt_wfstp INTO DATA(ls_wfstp).
      APPEND LINES OF VALUE htmltable( ( tdline = '<tr>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = |{ ls_wfstp-wf_step_number ALPHA = OUT }| && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = |{ ls_wfstp-wf_pending_date DATE = USER }| && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = |{ ls_wfstp-wf_pending_time TIME = USER }| && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = ls_wfstp-wf_pending_user && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = ls_wfstp-wf_status_desc && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = |{ ls_wfstp-wf_status_date DATE = USER }| && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = |{ ls_wfstp-wf_status_time TIME = USER }| && '</font></td>' )

                                       ( tdline = '<td style="text-align:center"><font size = "3">' )
                                       ( tdline = ls_wfstp-wf_status_user && '</font></td>' )
                                       ) TO rt_html_task_desc.

      DATA(lt_text_tab) = VALUE htmltable( ).

      CALL FUNCTION 'SOTR_SERV_STRING_TO_TABLE'
        EXPORTING
          text        = CONV string( ls_wfstp-wf_decision_desc )
          line_length = CONV i( 132 )
        TABLES
          text_tab    = lt_text_tab.

      APPEND VALUE #( tdline = '<td style="text-align:left"><font size = "3">' ) TO rt_html_task_desc.

      IF lt_text_tab IS NOT INITIAL.
        APPEND LINES OF lt_text_tab TO rt_html_task_desc.
      ENDIF.

      APPEND VALUE #( tdline = '</font></td></tr>' ) TO rt_html_task_desc.
    ENDLOOP.

    APPEND VALUE #( tdline = '</table>' ) TO rt_html_task_desc.

    rt_html_task_desc = VALUE #( BASE rt_html_task_desc ( tdline = '</body>' )
                                                        ( tdline = '</html>' ) ).

  ENDMETHOD.


  METHOD event_raised.

    DATA(lc_calling_program_gui_1) = CONV sy-cprog( 'SAPMSSO0' ).
    DATA(lc_calling_program_gui_2) = CONV sy-cprog( 'SAPMSSY1' ).
    DATA(lc_calling_program_fiori) = CONV sy-cprog( 'SAPMHTTP' ).

    DATA(lo_wf_container) = im_workitem_context->get_wf_container( ).
    DATA(lo_wi_container) = im_workitem_context->get_wi_container( ).
    DATA(ls_wi_header) = im_workitem_context->get_header( ).

    DATA(lo_cnt_container) = CAST cl_swf_cnt_container( lo_wi_container ).
    DATA(lt_value_table) = lo_cnt_container->if_swf_cnt_conversion~to_abap_container( ).

    FIELD-SYMBOLS <ls_container> TYPE any.

    DATA(ls_parameters) = VALUE /itetr/inc_s_wf_parameters( ).
    DATA(lv_decision_key) = VALUE swr_decikey( ).

    TRY.
        CALL METHOD lo_wf_container->get EXPORTING name = 'PARAMETERS' IMPORTING value = ls_parameters.
        CALL METHOD lo_wi_container->get EXPORTING name = '_WI_RESULT' IMPORTING value = lv_decision_key.
      CATCH cx_root INTO DATA(lx_root).
    ENDTRY.

    DATA(lv_wf_status) = VALUE /itetr/inc_de_wf_status( ).

    CASE lv_decision_key.
      WHEN '0001'.
        lv_wf_status = mc_wf_status-approved.
      WHEN '0002'.
        lv_wf_status = mc_wf_status-rejected.
      WHEN '0003'.
        lv_wf_status = mc_wf_status-cancelled.
      WHEN '0004'.
        lv_wf_status = mc_wf_status-save_as.
    ENDCASE.

    CASE im_event_name.
      WHEN if_swf_ifs_decision_exit=>c_evttyp_before_decision.
        CASE ls_wi_header-wi_rh_task.
          WHEN 'TS00392304'.  "Gelen E-Fatura: &1 Kayıt Onayı
            im_workitem_context->get_decision_alts( IMPORTING et_decialts = DATA(lt_decialts) ).
            DELETE lt_decialts WHERE altkey EQ 3. "Cancelled Decision Option

            IF ls_parameters-final_approval_executed IS INITIAL.
              DELETE lt_decialts WHERE altkey EQ 4. "Save As Decision Option
            ENDIF.

            im_workitem_context->set_decision_alts( lt_decialts ).
        ENDCASE.

      WHEN if_swf_ifs_workitem_exit=>c_evttyp_after_create.

      WHEN if_swf_ifs_workitem_exit=>c_evttyp_after_execution.
        CASE ls_wi_header-wi_rh_task.
          WHEN 'TS00392304'.  "Gelen E-Fatura: &1 Kayıt Onayı
            CHECK sy-cprog NE lc_calling_program_fiori. "GUI Sesion
            CHECK lv_wf_status IS NOT INITIAL.

            execute_update_operations(
              EXPORTING
                iv_wi_id            = ls_wi_header-wi_id
                iv_wf_status        = lv_wf_status
                iv_wf_actual_user   = sy-uname
                iv_wf_decision_desc = space
              IMPORTING
                et_return           = DATA(lt_return)
              CHANGING
                cs_parameters       = ls_parameters
            ).

            LOOP AT lt_return INTO DATA(ls_return) WHERE type CA 'EXA'.
              EXIT.
            ENDLOOP.
            IF sy-subrc EQ 0.
              MESSAGE ID ls_return-id
                    TYPE ls_return-type
                  NUMBER ls_return-number
                    WITH ls_return-message_v1
                         ls_return-message_v2
                         ls_return-message_v3
                         ls_return-message_v4.
            ENDIF.
        ENDCASE.

      WHEN if_swf_ifs_workitem_exit=>c_evttyp_after_async_invoke.
      WHEN if_swf_ifs_workitem_exit=>c_evttyp_after_rule_exec.
      WHEN if_swf_ifs_workitem_exit=>c_evttyp_before_create.
        CASE ls_wi_header-wi_rh_task.
          WHEN 'TS00392304'.  "Gelen E-Fatura: &1 Kayıt Onayı
            me->update_task_description( im_workitem_context ).
        ENDCASE.

      WHEN if_swf_ifs_workitem_exit=>c_evttyp_before_execution.
        CASE ls_wi_header-wi_rh_task.
          WHEN 'TS00392304'.  "Gelen E-Fatura: &1 Kayıt Onayı
            me->update_task_description( im_workitem_context ).
        ENDCASE.

      WHEN if_swf_ifs_workitem_exit=>c_evttyp_before_remove.
      WHEN if_swf_ifs_workitem_exit=>c_evttyp_state_changed.
        CASE ls_wi_header-wi_rh_task.
          WHEN 'TS00392304'.  "Gelen E-Fatura: &1 Kayıt Onayı
            CASE ls_wi_header-wi_stat.
              WHEN 'SELECTED'.
              WHEN 'STARTED'.
              WHEN 'COMMITTED'.
              WHEN 'COMPLETED'.
                CHECK sy-cprog NE lc_calling_program_fiori. "GUI Sesion
                CHECK lv_wf_status IS NOT INITIAL.

                READ TABLE lt_value_table INTO DATA(ls_value_table) WITH KEY name = 'DECISION_NOTE'.
                CHECK sy-subrc EQ 0.

                ASSIGN ls_value_table-value->* TO <ls_container>.
                CHECK sy-subrc EQ 0.

                DATA(ls_business_object) = CORRESPONDING sibflporb( <ls_container> ).

                CHECK ls_business_object-instid IS NOT INITIAL.

                DATA(ls_document_data) = VALUE sofolenti1( ).
                DATA(lt_object_content) = VALUE esy_tt_solisti1( ).

                CALL FUNCTION 'SO_DOCUMENT_READ_API1'
                  EXPORTING
                    document_id                = CONV sofolenti1-doc_id( ls_business_object-instid )
                  IMPORTING
                    document_data              = ls_document_data
                  TABLES
                    object_content             = lt_object_content
                  EXCEPTIONS
                    document_id_not_exist      = 1
                    operation_no_authorization = 2
                    x_error                    = 3
                    OTHERS                     = 4.
                IF sy-subrc <> 0.
*                 Implement suitable error handling here
                ENDIF.

                DATA(lv_wf_decision_desc) = VALUE /itetr/inc_wfstp-wf_decision_desc( ).

                LOOP AT lt_object_content INTO DATA(ls_object_content).
                  IF lv_wf_decision_desc IS INITIAL.
                    lv_wf_decision_desc = ls_object_content-line.
                  ELSE.
                    lv_wf_decision_desc = lv_wf_decision_desc && ` ` && ls_object_content-line.
                  ENDIF.
                ENDLOOP.

                UPDATE /itetr/inc_wfstp SET wf_decision_desc = lv_wf_decision_desc
                                      WHERE docui EQ ls_parameters-docui
                                        AND wf_step_number EQ ls_parameters-wf_step_number.
            ENDCASE.
        ENDCASE.

      WHEN if_swf_ifs_workitem_exit=>c_evttyp_after_action.
      WHEN if_swf_ifs_workitem_exit=>c_evttyp_before_action.
    ENDCASE.

  ENDMETHOD.


  METHOD execute_update_operations.

    DATA(lv_wf_status_date) = sy-datum.
    DATA(lv_wf_status_time) = sy-uzeit.

    UPDATE /itetr/inc_wfstp SET wi_id = iv_wi_id
                                wf_status = iv_wf_status
                                wf_status_date = lv_wf_status_date
                                wf_status_time = lv_wf_status_time
                                wf_status_user = iv_wf_actual_user
                                wf_decision_desc = iv_wf_decision_desc
                          WHERE docui EQ cs_parameters-docui
                            AND wf_step_number EQ cs_parameters-wf_step_number.

    CHECK cs_parameters-final_approval_executed IS NOT INITIAL.

    UPDATE /itetr/inc_wfhdr SET wf_status = iv_wf_status
                                wf_status_date = lv_wf_status_date
                                wf_status_time = lv_wf_status_time
                                wf_completed   = abap_true
                          WHERE docui EQ cs_parameters-docui.

    UPDATE /itetr/inc_t0001 SET wf_status = iv_wf_status
                          WHERE docui EQ cs_parameters-docui.

    CALL FUNCTION '/ITETR/INC_FM_WORKFLOW_MAIL' IN BACKGROUND TASK AS SEPARATE UNIT
      EXPORTING
        is_parameters = cs_parameters.

  ENDMETHOD.


  METHOD get_approver.

    DATA lt_wfstp TYPE TABLE OF /itetr/inc_wfstp.

    CLEAR cs_parameters-t_actor.
    CLEAR cs_parameters-no_approver.
    CLEAR cs_parameters-wf_scenario_code.
    CLEAR cs_parameters-wf_scenario_type.

    CASE iv_wf_status.
      WHEN mc_wf_status-rejected.
        cs_parameters-no_approver = abap_true.
        RETURN.
      WHEN mc_wf_status-cancelled.
        cs_parameters-no_approver = abap_true.
        RETURN.
    ENDCASE.

    DATA(lv_datum) = sy-datum.
    DATA(lv_uzeit) = sy-uzeit.

    DO.
      cs_parameters-wf_step_search_counter = cs_parameters-wf_step_search_counter + 1.

      READ TABLE cs_parameters-t_approver_list INTO DATA(ls_approver_list_header) INDEX cs_parameters-wf_step_search_counter.
      IF sy-subrc EQ 0.
        cs_parameters-wf_step_number = cs_parameters-wf_step_number + 1.

        CLEAR lt_wfstp.

        LOOP AT cs_parameters-t_approver_list INTO DATA(ls_approver_list) WHERE wf_scenario_code EQ ls_approver_list_header-wf_scenario_code
                                                                            AND wf_step_number EQ ls_approver_list_header-wf_step_number.
          cs_parameters-wf_step_search_counter = sy-tabix.

          APPEND VALUE #( otype = 'US' objid = ls_approver_list-wf_approver ) TO cs_parameters-t_actor.
          APPEND VALUE #( otype = 'US' objid = ls_approver_list-wf_approver ) TO cs_parameters-t_actor_approved.

          DATA(ls_wfstp) = VALUE /itetr/inc_wfstp( ).
          ls_wfstp-docui = cs_parameters-docui.
          ls_wfstp-wf_step_number = cs_parameters-wf_step_number.
          ls_wfstp-wf_pending_date = lv_datum.
          ls_wfstp-wf_pending_time = lv_uzeit.
          ls_wfstp-wf_pending_user = ls_approver_list-wf_approver.
          ls_wfstp-wf_status = mc_wf_status-pending.
          ls_wfstp-wf_scenario_code = ls_approver_list-wf_scenario_code.
          ls_wfstp-wf_scenario_type = ls_approver_list-wf_scenario_type.
          APPEND ls_wfstp TO lt_wfstp.

          cs_parameters-wf_scenario_code = ls_approver_list-wf_scenario_code.
          cs_parameters-wf_scenario_type = ls_approver_list-wf_scenario_type.
        ENDLOOP.

        IF lt_wfstp IS NOT INITIAL.
          MODIFY /itetr/inc_wfstp FROM TABLE lt_wfstp.
        ENDIF.

        UPDATE /itetr/inc_wfhdr SET wf_step_number = ls_wfstp-wf_step_number
                                    wf_status      = ls_wfstp-wf_status
                                    wf_status_date = ls_wfstp-wf_pending_date
                                    wf_status_time = ls_wfstp-wf_pending_time
                              WHERE docui EQ cs_parameters-docui.

        UPDATE /itetr/inc_t0001 SET wf_status = ls_wfstp-wf_status
                              WHERE docui EQ cs_parameters-docui.

        CALL FUNCTION '/ITETR/INC_FM_WORKFLOW_MAIL' IN BACKGROUND TASK AS SEPARATE UNIT
          EXPORTING
            is_parameters = cs_parameters.

        EXIT.
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.

    IF cs_parameters-wf_step_search_counter EQ lines( cs_parameters-t_approver_list ).
      cs_parameters-final_approval_executed = abap_true.
    ENDIF.

    CHECK cs_parameters-t_actor IS INITIAL.
    cs_parameters-no_approver = abap_true.

    CHECK cs_parameters-t_actor_approved IS INITIAL.

    UPDATE /itetr/inc_t0001 SET wf_status = mc_wf_status-not_found
                          WHERE docui EQ cs_parameters-docui.

  ENDMETHOD.


  METHOD update_task_description.

    DATA(lo_wf_container) = io_workitem_context->get_wf_container( ).
    DATA(lo_wi_container) = io_workitem_context->get_wi_container( ).
    DATA(ls_wi_header) = io_workitem_context->get_header( ).

    DATA(ls_parameters) = VALUE /itetr/inc_s_wf_parameters( ).

    TRY.
        CALL METHOD lo_wf_container->get EXPORTING name = 'PARAMETERS' IMPORTING value = ls_parameters.

      CATCH cx_root INTO DATA(lx_root).
        DATA(lv_error_text) = lx_root->get_text( ).
    ENDTRY.

    DATA(lt_html_task_desc) = create_task_description( ls_parameters ).

    TRY .
        lo_wi_container->clear( EXPORTING name = 'T_HTML_TASK_DESC' ).

        lo_wi_container->set( EXPORTING name = 'T_HTML_TASK_DESC' value = lt_html_task_desc ).
      CATCH cx_root INTO lx_root.
        lv_error_text = lx_root->get_text( ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.