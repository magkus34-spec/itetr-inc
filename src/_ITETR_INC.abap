*&---------------------------------------------------------------------*
*& Report /ITETR/INC
*&---------------------------------------------------------------------*
*& Berke Özkaynak
"& Alper NANTU
*&---------------------------------------------------------------------*
REPORT /itetr/inc MESSAGE-ID /itetr/inc.

INCLUDE /itetr/inc_versiyon.
INCLUDE /itetr/inc_top.
INCLUDE /itetr/inc_c01.
INCLUDE /itetr/inc_mdl.

INITIALIZATION.
  go_main_controller = lcl_main_controller=>get_instance( ).

AT SELECTION-SCREEN OUTPUT.
  go_main_controller->screen_output( ).

START-OF-SELECTION.
  go_main_controller->get_data( ).

END-OF-SELECTION.
  go_main_controller->display_data( ).