*------------------------------------------------------------------------*
*& Report     : /ITETR/INC_R_TRIGGER_WF
*------------------------------------------------------------------------*
*  Title      : Incoming E-Invoice Registration Automation - WF Triggering
*------------------------------------------------------------------------*
*  Author     : NYUZBASI - Neşet YÜZBAŞI
*------------------------------------------------------------------------*
**************************************************************************
*             H I S T O R Y   O F   R E V I S I O N S
**************************************************************************
*       Date          Programmer         Incident #         Description
*  ---------------  -------------------  -------------    ---------------*
*  02.08.2022       Name Surname         XXXXX53262       New Development
*
*------------------------------------------------------------------------*
REPORT /itetr/inc_r_trigger_wf.

INCLUDE /itetr/inc_i_trigger_wf_data.
INCLUDE /itetr/inc_i_trigger_wf_clsd.
INCLUDE /itetr/inc_i_trigger_wf_clsi.

INITIALIZATION.
  go_main = lcl_main=>get_instance( ).
  go_main->initialization( ).

AT SELECTION-SCREEN OUTPUT.
  go_main->selection_screen_output( ).

AT SELECTION-SCREEN.
  go_main->selection_screen_input( ).

START-OF-SELECTION.
  go_main->start_of_selection( ).