class /ITETR/CL_INC0100_DPC_EXT definition
  public
  inheriting from /ITETR/CL_INC0100_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITYSET
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC0100_DPC_EXT IMPLEMENTATION.


method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITYSET.
    FIELD-SYMBOLS: <lt_data> TYPE table.
    DATA(lt_orderby) = io_tech_request_context->get_orderby( ).
    DATA(lt_sorter)  = VALUE esp6_sortfield_tab_type( ).
    TRY.
        CALL METHOD super->/iwbep/if_mgw_appl_srv_runtime~get_entityset
          EXPORTING
            iv_entity_name           = iv_entity_name
            iv_entity_set_name       = iv_entity_set_name
            iv_source_name           = iv_source_name
            it_filter_select_options = it_filter_select_options
            it_order                 = it_order
            is_paging                = is_paging
            it_navigation_path       = it_navigation_path
            it_key_tab               = it_key_tab
            iv_filter_string         = iv_filter_string
            iv_search_string         = iv_search_string
            io_tech_request_context  = io_tech_request_context
          IMPORTING
            er_entityset             = er_entityset
            es_response_context      = es_response_context.

        ASSIGN er_entityset->* TO <lt_data>.
        CHECK sy-subrc IS INITIAL.
        IF lt_orderby IS NOT INITIAL.
          LOOP AT lt_orderby ASSIGNING FIELD-SYMBOL(<ls_orderby>).
            APPEND INITIAL LINE TO lt_sorter ASSIGNING FIELD-SYMBOL(<ls_sorter>).
            <ls_sorter>-name     = <ls_orderby>-property.
            <ls_sorter>-flg_desc = COND #( WHEN <ls_orderby>-order EQ 'desc' THEN abap_true ).
          ENDLOOP.
          CALL FUNCTION 'C140_TABLE_DYNAMIC_SORT'
            TABLES
              i_sortfield_tab      = lt_sorter
              x_tab                = <lt_data>
            EXCEPTIONS
              sortfieldtab_too_big = 1
              OTHERS               = 2.
        ENDIF.
      CATCH /iwbep/cx_mgw_busi_exception.
      CATCH /iwbep/cx_mgw_tech_exception.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.