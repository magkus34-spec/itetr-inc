class /ITETR/CL_INC_GENERAL definition
  public
  final
  create public .

public section.

  methods POPUP_TO_SELECT_FROM_TABLE
    importing
      !IV_HEADER type LVC_TITLE optional
      !IV_DYNPRO_HEIGHT type I optional
      !IV_DYNPRO_WIDTH type I optional
      !IV_SCREEN_HEIGHT type I optional
      !IV_SCREEN_WIDTH type I optional
      !IV_SELECT type XFELD
    changing
      !CT_TABLE type TABLE
    returning
      value(RV_SELECTED_ROW) type I .
protected section.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC_GENERAL IMPLEMENTATION.


  METHOD POPUP_TO_SELECT_FROM_TABLE.
   TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = DATA(lo_salv_table)
          CHANGING
            t_table      = ct_table
         ).
        DATA(lo_columns) = lo_salv_table->get_columns( ).
        lo_columns->set_optimize( abap_true ).
        DATA: lv_winx1 TYPE i,
              lv_winx2 TYPE i,
              lv_winy1 TYPE i,
              lv_winy2 TYPE i.

        CALL FUNCTION 'CY_CENTER_WINDOW'
          EXPORTING
            dynpro_height = iv_dynpro_height
            dynpro_width  = iv_dynpro_width
            screen_height = iv_screen_height
            screen_width  = iv_screen_width
          IMPORTING
            winx1         = lv_winx1
            winx2         = lv_winx2
            winy1         = lv_winy1
            winy2         = lv_winy2.
        lo_salv_table->set_screen_popup(
          start_column = lv_winx1
          end_column   = lv_winx2
          start_line   = lv_winy1
          end_line     = lv_winy2
        ).

        DATA(lo_events) = lo_salv_table->get_event( ).
        DATA(lo_alv_events) = NEW lcl_salv_popup_events( ).
        lo_alv_events->set_alv_table_object( io_alv_table = lo_salv_table ).
        IF iv_select IS NOT INITIAL.
          SET HANDLER lo_alv_events->handle_double_click FOR lo_events.
        ENDIF.
        SET HANDLER lo_alv_events->handle_function_click FOR lo_events.

        IF iv_select IS NOT INITIAL.
          lo_salv_table->set_screen_status(
            EXPORTING
              report        = 'SAPLKKBL'
              pfstatus      = 'ST850'
          ).
        ELSE.
          lo_salv_table->set_screen_status(
            EXPORTING
              report        = 'SAPLKKBL'
              pfstatus      = 'ST0801'
          ).
        ENDIF.

*        CATCH cx_salv_data_error. " ALV: General Error Class (Checked in Syntax Check)..

        lo_salv_table->display( ).
*        DATA(lo_selctions) = lo_salv_table->get_selections( ).
*        DATA(lt_selected_rows) = lo_selctions->get_selected_rows( ).
        DATA(lt_selected_rows) = lo_salv_table->get_selections( )->get_selected_rows( ).
        CHECK lt_selected_rows IS NOT INITIAL.
        rv_selected_row = lt_selected_rows[ 1 ].
      CATCH cx_root.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.