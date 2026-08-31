*&---------------------------------------------------------------------*
*& Report /ITETR/INC_R_GET_INVOICE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT /itetr/inc_r_get_invoice.

INCLUDE /itetr/inc_r_get_invoice_data.
INCLUDE /itetr/inc_r_get_invoice_clsd.
INCLUDE /itetr/inc_r_get_invoice_clsi.
INCLUDE /itetr/inc_r_get_invoice_pbo.
INCLUDE /itetr/inc_r_get_invoice_pai.

INITIALIZATION.
  go_main = lcl_main=>get_instance( ).
  go_main->initialization( ).

AT SELECTION-SCREEN OUTPUT.
  go_main->selection_screen_output( ).

AT SELECTION-SCREEN.
  go_main->selection_screen_input( ).

START-OF-SELECTION.
  go_main->start_of_selection( ).

END-OF-SELECTION.
  go_main->end_of_selection( ).