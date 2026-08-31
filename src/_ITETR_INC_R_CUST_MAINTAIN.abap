*&---------------------------------------------------------------------*
*& Report /ITETR/INC_R_CUST_MAINTAIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT /itetr/inc_r_cust_maintain.

INCLUDE /itetr/inc_r_cust_maint_data.
INCLUDE /itetr/inc_r_cust_maint_clsd.
INCLUDE /itetr/inc_r_cust_maint_clsi.
INCLUDE /itetr/inc_r_cust_maint_pbo.
INCLUDE /itetr/inc_r_cust_maint_pai.

INITIALIZATION.
  go_main = lcl_main=>get_instance( ).
  go_main->initialization( ).

START-OF-SELECTION.
  go_main->start_of_selection( ).