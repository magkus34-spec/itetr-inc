class /ITETR/CL_INC_WF_OPERATIONS definition
  public
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .
  interfaces IF_SWF_IFS_WORKITEM_EXIT .
  interfaces IF_SWF_IFS_DECISION_EXIT .

  constants:
    BEGIN OF mc_workflow ,
        top_task   TYPE sww_top_task VALUE 'WS00392301',
        class_name TYPE seoclsname VALUE '/ITETR/CL_INC_WF_OPERATIONS',
        event_name TYPE hr_s_event VALUE 'START_WORKFLOW',
      END OF mc_workflow .
  constants:
    BEGIN OF mc_wf_status ,
        ready     TYPE /itetr/inc_t0001-wf_status VALUE 'READY',
        triggered TYPE /itetr/inc_t0001-wf_status VALUE 'TRIGGERED',
        started   TYPE /itetr/inc_t0001-wf_status VALUE 'STARTED',
        pending   TYPE /itetr/inc_t0001-wf_status VALUE 'PENDING',
        approved  TYPE /itetr/inc_t0001-wf_status VALUE 'APPROVED',
        rejected  TYPE /itetr/inc_t0001-wf_status VALUE 'REJECTED',
        cancelled TYPE /itetr/inc_t0001-wf_status VALUE 'CANCELLED',
        save_as   TYPE /itetr/inc_t0001-wf_status VALUE 'SAVE_AS',
      END OF mc_wf_status .
  constants:
    BEGIN OF mc_difference_type ,
        amount   TYPE /itetr/inc_difft-difference_type VALUE 'AMOUNT',
        quantity TYPE /itetr/inc_difft-difference_type VALUE 'QUANTITY',
      END OF mc_difference_type .
  constants MC_MSGID type T100-ARBGB value '/ITETR/INC' ##NO_TEXT.
  data MV_DOCUI type /ITETR/INC_E_DOCUI read-only .

  class-events START_WORKFLOW
    exporting
      value(PARAMETERS) type /ITETR/INC_S_WF_PARAMETERS .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to /ITETR/CL_INC_WF_INSTANCE .
  methods CONSTRUCTOR
    importing
      !IS_LPOR type SIBFLPOR optional .
  class-methods CALL_WORKFLOW
    importing
      !IT_DOCUMENT type /ITETR/INC_TT_DOCUMENT_ID_CHAR optional
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  class-methods CREATE_LOG
    changing
      !CS_PARAMETERS type /ITETR/INC_S_WF_PARAMETERS .
  class-methods GET_APPROVER
    importing
      !IV_WF_STATUS type /ITETR/INC_DE_WF_STATUS
    changing
      !CS_PARAMETERS type /ITETR/INC_S_WF_PARAMETERS .
  class-methods EXECUTE_UPDATE_OPERATIONS
    importing
      !IV_WI_ID type SWW_WIID
      !IV_WF_STATUS type /ITETR/INC_DE_WF_STATUS
      !IV_WF_ACTUAL_USER type UNAME
      !IV_WF_DECISION_DESC type /ITETR/INC_DE_WF_DECISION_DESC
    exporting
      !ET_RETURN type BAPIRET2_TAB
    changing
      !CS_PARAMETERS type /ITETR/INC_S_WF_PARAMETERS .
  class-methods CREATE_TASK_DESCRIPTION
    importing
      !IS_PARAMETERS type /ITETR/INC_S_WF_PARAMETERS
    returning
      value(RT_HTML_TASK_DESC) type HTMLTABLE .
protected section.
private section.

  data MS_LPOR type SIBFLPOR .
ENDCLASS.



CLASS /ITETR/CL_INC_WF_OPERATIONS IMPLEMENTATION.


  METHOD bi_object~default_attribute_value.
  ENDMETHOD.


  METHOD bi_object~execute_default_method.
  ENDMETHOD.


  METHOD bi_object~release.
  ENDMETHOD.


  METHOD bi_persistent~find_by_lpor.

    TRY .
        result = NEW /itetr/cl_inc_wf_operations( lpor ).
      CATCH cx_root INTO DATA(lx_root).
        DATA(lv_error_text) = lx_root->get_text( ).
    ENDTRY.

  ENDMETHOD.


  METHOD bi_persistent~lpor.

    result = me->ms_lpor.

  ENDMETHOD.


  METHOD bi_persistent~refresh.
  ENDMETHOD.


  METHOD call_workflow.

    DATA(lo_instance) = get_instance( ).

    rt_return = lo_instance->call_workflow( it_document ).

  ENDMETHOD.


  METHOD constructor.

    me->ms_lpor = is_lpor.

    me->mv_docui = is_lpor-instid.

  ENDMETHOD.


  METHOD create_log.

    DATA(lo_instance) = get_instance( ).

    lo_instance->create_log( CHANGING cs_parameters = cs_parameters ).

  ENDMETHOD.


  METHOD create_task_description.

    DATA(lo_instance) = get_instance( ).

    rt_html_task_desc = lo_instance->create_task_description( is_parameters ).

  ENDMETHOD.


  METHOD execute_update_operations.

    DATA(lo_instance) = get_instance( ).

    lo_instance->execute_update_operations(
      EXPORTING
        iv_wi_id            = iv_wi_id
        iv_wf_status        = iv_wf_status
        iv_wf_actual_user   = iv_wf_actual_user
        iv_wf_decision_desc = iv_wf_decision_desc
      IMPORTING
        et_return           = et_return
      CHANGING
        cs_parameters       = cs_parameters
    ).

  ENDMETHOD.


  METHOD get_approver.

    DATA(lo_instance) = get_instance( ).

    lo_instance->get_approver(
      EXPORTING
        iv_wf_status  = iv_wf_status
      CHANGING
        cs_parameters = cs_parameters
    ).

  ENDMETHOD.


  METHOD get_instance.

    SELECT SINGLE clsname
             FROM seometarel
            WHERE refclsname EQ '/ITETR/CL_INC_WF_INSTANCE'
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


  METHOD if_swf_ifs_workitem_exit~event_raised.

    TRY.
        DATA(lo_instance) = get_instance( ).

        lo_instance->event_raised(
          EXPORTING
            im_event_name       = im_event_name
            im_workitem_context = im_workitem_context
        ).
      CATCH cx_swf_ifs_workitem_exit_error .
    ENDTRY.

  ENDMETHOD.
ENDCLASS.