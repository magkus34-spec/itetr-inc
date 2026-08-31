*&---------------------------------------------------------------------*
*& Report /ITETR/INC_CONTROL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT /itetr/inc_control.

INCLUDE /itetr/inc_control_data.
INCLUDE /itetr/inc_control_clsd.
INCLUDE /itetr/inc_control_clsi.
INCLUDE /itetr/inc_control_pbo.
INCLUDE /itetr/inc_control_pai.

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