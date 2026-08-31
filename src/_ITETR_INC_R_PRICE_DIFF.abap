*&---------------------------------------------------------------------*
*& Report /ITETR/INC_R_PRICE_DIFF
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT /itetr/inc_r_price_diff.

INCLUDE /itetr/inc_i_price_diff_data.
INCLUDE /itetr/inc_i_price_diff_clsd.
INCLUDE /itetr/inc_i_price_diff_clsi.

INITIALIZATION.
  go_main = lcl_main=>get_instance( ).
  go_main->initialization( ).

AT SELECTION-SCREEN OUTPUT.
  go_main->selection_screen_output( ).

AT SELECTION-SCREEN.
  go_main->selection_screen_input( ).

START-OF-SELECTION.
  go_main->start_of_selection( ).