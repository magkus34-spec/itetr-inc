class /ITETR/CL_INC_BADI_WF_BEFORE_U definition
  public
  final
  create public .

public section.

  interfaces /IWWRK/IF_WF_WI_BEFORE_UPD_IB .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC_BADI_WF_BEFORE_U IMPLEMENTATION.


  METHOD /iwwrk/if_wf_wi_before_upd_ib~before_update.

    CHECK is_wi_details-wi_rh_task EQ 'TS00392304'. "Gelen E-Fatura: &1 Kayıt Onayı

    DATA(ls_parameters) = VALUE /itetr/inc_s_wf_parameters( ).
    DATA(lv_wf_status) = VALUE /itetr/inc_de_wf_status( ).

    CASE iv_decision_key.
      WHEN '0001'.
        lv_wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-approved.
      WHEN '0002'.
        lv_wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-rejected.
      WHEN '0003'.
        lv_wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-cancelled.
      WHEN '0004'.
        lv_wf_status = /itetr/cl_inc_wf_operations=>mc_wf_status-save_as.
    ENDCASE.

    TRY.
        DATA(lo_wi_manager) = cl_swf_run_wim_factory=>find_by_wiid( CONV #( is_wi_details-wi_id ) ).
        DATA(lo_wf_container) = lo_wi_manager->get_wf_container( ).

        CALL METHOD lo_wf_container->if_swf_ifs_parameter_container~get EXPORTING name = 'PARAMETERS' IMPORTING value = ls_parameters.

      CATCH cx_root INTO DATA(lx_root).
        APPEND VALUE #( id = '/ITETR/INC' type = 'E' number = '000'
                        message = lx_root->get_text( ) ) TO ct_return.
    ENDTRY.

    CHECK ct_return IS INITIAL.

    DATA(lv_decision_desc) = VALUE /itetr/inc_de_wf_decision_desc( ).

    LOOP AT it_wf_container_tab INTO DATA(ls_wf_container_tab) WHERE element CS /iwwrk/if_wf_constants_gw=>gc_action_comments.
      IF lv_decision_desc IS INITIAL.
        lv_decision_desc = ls_wf_container_tab-value.
      ELSE.
        lv_decision_desc = lv_decision_desc && ` ` && ls_wf_container_tab-value.
      ENDIF.
    ENDLOOP.

    /itetr/cl_inc_wf_operations=>execute_update_operations(
      EXPORTING
        iv_wi_id            = is_wi_details-wi_id
        iv_wf_status        = lv_wf_status
        iv_wf_actual_user   = sy-uname
        iv_wf_decision_desc = lv_decision_desc
      IMPORTING
        et_return           = DATA(lt_return)
      CHANGING
        cs_parameters       = ls_parameters
    ).

    LOOP AT lt_return TRANSPORTING NO FIELDS WHERE type CA 'EXA'.
      EXIT.
    ENDLOOP.
    IF sy-subrc EQ 0.
      APPEND LINES OF lt_return TO ct_return.
    ENDIF.

  ENDMETHOD.
ENDCLASS.