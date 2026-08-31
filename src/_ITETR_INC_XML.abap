*&---------------------------------------------------------------------*
*& Report /ITETR/INC_XML
*&---------------------------------------------------------------------*
*& Berke Özkaynak
*&---------------------------------------------------------------------*
REPORT /itetr/inc_xml.

INCLUDE /itetr/inc_xml_top.
INCLUDE /itetr/inc_xml_c01.

INITIALIZATION.
  go_main_controller = lcl_main_controller=>get_instance( ).

START-OF-SELECTION.
  go_main_controller->get_data( ).

END-OF-SELECTION.
  go_main_controller->update_table( ).