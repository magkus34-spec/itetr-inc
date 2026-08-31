class /ITETR/CL_INC_BADI_TGW_TASK definition
  public
  final
  create public .

public section.

  interfaces /IWPGW/IF_TGW_TASK_DATA .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC_BADI_TGW_TASK IMPLEMENTATION.


  METHOD /iwpgw/if_tgw_task_data~modify_task_description.
    CHECK is_task_header-task_def_id IS NOT INITIAL.
    CHECK is_task_header-task_def_id+0(10) EQ 'TS00392304'. "Gelen E-Fatura: &1 Kayıt Onayı

    DATA(ls_parameters) = VALUE /itetr/inc_s_wf_parameters( ).

    TRY.
        DATA(lo_wi_manager) = cl_swf_run_wim_factory=>find_by_wiid( CONV #( is_task_header-inst_id ) ).
        DATA(lo_wf_container) = lo_wi_manager->get_wf_container( ).

        CALL METHOD lo_wf_container->if_swf_ifs_parameter_container~get EXPORTING name = 'PARAMETERS' IMPORTING value = ls_parameters.

      CATCH cx_root INTO DATA(lx_root).
        DATA(lv_error_text) = lx_root->get_text( ).
    ENDTRY.

    DATA(lt_html_task_desc) = /itetr/cl_inc_wf_operations=>create_task_description( ls_parameters ).

    CLEAR cv_description.
    CLEAR cv_description_html.

    LOOP AT lt_html_task_desc INTO DATA(ls_html_task_desc).
      IF cv_description_html IS INITIAL.
        cv_description_html = ls_html_task_desc-tdline.
      ELSE.
        cv_description_html = cv_description_html && ls_html_task_desc-tdline.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD /iwpgw/if_tgw_task_data~modify_task_title.
    IF is_task_header-task_def_id IS NOT INITIAL.
      CHECK is_task_header-task_def_id+0(10) EQ 'TS00392304'. "Gelen E-Fatura: &1 Kayıt Onayı
    ENDIF.
  ENDMETHOD.
ENDCLASS.