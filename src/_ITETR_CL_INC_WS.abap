class /ITETR/CL_INC_WS definition
  public
  abstract
  create public .

public section.

  types:
    mty_taxpayers_list TYPE STANDARD TABLE OF /itetr/inv_taxp WITH DEFAULT KEY .
  types:
    BEGIN OF mty_outgoing_document_status.
    TYPES stacd TYPE /itetr/com_e_stacd.
    TYPES staex TYPE /itetr/com_e_staex.
    TYPES resst TYPE /itetr/inc_de_resst.
    TYPES radsc TYPE /itetr/com_e_radsc.
    TYPES rsend TYPE /itetr/com_e_rsend.
    TYPES envui TYPE /itetr/com_e_envui.
    TYPES invui TYPE /itetr/com_e_duich.
    TYPES invno TYPE /itetr/com_e_docno.
    TYPES invqi TYPE /itetr/com_e_docqi.
    TYPES END OF mty_outgoing_document_status .
  types:
    BEGIN OF mty_service_header.
    TYPES name TYPE string.
    TYPES value TYPE string.
    TYPES END OF mty_service_header .
  types:
    mty_service_header_tab TYPE TABLE OF mty_service_header WITH DEFAULT KEY .

  class-methods FACTORY
    importing
      !IV_COMPANY type BUKRS
    returning
      value(RO_INSTANCE) type ref to /ITETR/CL_INC_WS
    raising
      /ITETR/CX_REGULATIVE_EXCEPTION .
  methods INCOMING_INVOICE_DOWNLOAD
  abstract
    importing
      !IS_DOCUMENT_NUMBERS type /ITETR/INC_DOCUMENT_NUMBERS
      !IV_CONTENT_TYPE type /ITETR/COM_E_CONTY
    returning
      value(RV_INVOICE_DATA) type /ITETR/COM_E_CONTN
    raising
      /ITETR/CX_REGULATIVE_EXCEPTION .
protected section.

  data MV_COMPANY_TAXID type STCD2 .
  data MS_COMPANY_PARAMETERS type /ITETR/INC_EINP .
  data:
    mt_custom_parameters  TYPE STANDARD TABLE OF /itetr/inv_eicp
                            WITH NON-UNIQUE SORTED KEY by_cuspa COMPONENTS cuspa .
  data MV_REQUEST_URL type STRING .

  methods RUN_SERVICE
    importing
      !IV_REQUEST type STRING
      !IV_USE_ALTERNATIVE_ENDPOINT type XFELD optional
      !IV_AUTHENTICATE type XFELD optional
      !IT_REQUEST_HEADER type MTY_SERVICE_HEADER_TAB optional
    returning
      value(RV_RESPONSE) type STRING
    raising
      /ITETR/CX_REGULATIVE_EXCEPTION .
private section.

  methods GET_SERVICE_PARAMETERS
    importing
      !IS_COMPANY_PARAMETERS type /ITETR/INC_EINP .
ENDCLASS.



CLASS /ITETR/CL_INC_WS IMPLEMENTATION.


  METHOD factory.
    DATA: ls_company_parameters TYPE /itetr/inc_einp,
          lo_root               TYPE REF TO cx_root,
          lv_reference_class    TYPE seoclsname.

    SELECT SINGLE *
      INTO ls_company_parameters
      FROM /itetr/inc_einp
      WHERE bukrs = iv_company.

    CHECK sy-subrc EQ 0.

    SELECT SINGLE refcl
      INTO lv_reference_class
      FROM /itetr/com_refcl
      WHERE bukrs = iv_company
        AND prncl = '/ITETR/CL_INC_WS'.  "AS 01.01.2022

    IF lv_reference_class IS INITIAL.
      CONCATENATE '/ITETR/CL_INC_WS_' ls_company_parameters-intid INTO lv_reference_class.
    ENDIF.

    TRY .
        CREATE OBJECT ro_instance TYPE (lv_reference_class).
        ro_instance->get_service_parameters( ls_company_parameters ).
      CATCH cx_root INTO lo_root.
        DATA(lv_message) = lo_root->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD get_service_parameters.
    DATA: ls_custom_parameter TYPE /itetr/inc_eicp.

    ms_company_parameters = is_company_parameters.

    SELECT *
      INTO TABLE mt_custom_parameters
      FROM /itetr/inc_eicp
      WHERE bukrs = ms_company_parameters-bukrs.

    SELECT *
      APPENDING TABLE mt_custom_parameters
      FROM /itetr/inc_eicp
      WHERE bukrs = ms_company_parameters-bukrs.

    READ TABLE mt_custom_parameters INTO ls_custom_parameter WITH TABLE KEY by_cuspa COMPONENTS cuspa = 'TEST_VKN'.
    IF sy-subrc = 0.
      mv_company_taxid = ls_custom_parameter-value.
    ELSE.
      SELECT SINGLE value
        INTO mv_company_taxid
        FROM /itetr/com_cmppi
        WHERE bukrs = ms_company_parameters-bukrs
          AND prtid = 'VKN'.
    ENDIF.
  ENDMETHOD.


  METHOD run_service.
    DATA: lv_request_length  TYPE i,
          lv_length_text     TYPE string,
          lo_http_client     TYPE REF TO if_http_client,
          lv_message         TYPE bapi_msg,
          lt_xml_table       TYPE TABLE OF smum_xmltb,
          ls_xml_line        TYPE smum_xmltb,
          lx_exception       TYPE REF TO /itetr/cx_regulative_exception,
          lv_endpoint        TYPE /itetr/com_e_wsend,
          lv_user            TYPE string,
          lv_password        TYPE string,
          lv_response_code   TYPE i,
          lv_response_reason TYPE string,
          lv_authorization   TYPE string,
          ls_request_header  TYPE /itetr/cl_einvoice_ws=>mty_service_header.

    lv_request_length = strlen( iv_request ).
    MOVE lv_request_length TO lv_length_text.
    CONDENSE lv_length_text.

    IF iv_use_alternative_endpoint = abap_true.
      lv_endpoint = ms_company_parameters-wsena.
    ELSE.
      lv_endpoint = ms_company_parameters-wsend.
    ENDIF.

    cl_http_client=>create_by_destination(
      EXPORTING
        destination              = lv_endpoint
      IMPORTING
        client                   = lo_http_client
      EXCEPTIONS
        argument_not_found       = 1
        destination_not_found    = 2
        destination_no_authority = 3
        plugin_not_active        = 4
        internal_error           = 5
        OTHERS                   = 6 ).
    IF sy-subrc <> 0.
      lx_exception = /itetr/cx_regulative_exception=>create_by_message( iv_msgno = '004' ).
      RAISE EXCEPTION lx_exception.
    ENDIF.

    IF iv_authenticate IS NOT INITIAL.
      lv_user = ms_company_parameters-wsusr.
      lv_password = ms_company_parameters-wspwd.
      lo_http_client->authenticate(
        EXPORTING
          username = lv_user
          password = lv_password ).
    ENDIF.

    lo_http_client->request->set_header_field( name  = '~request_method'
                                               value = 'POST' ).

    IF mv_request_url IS NOT INITIAL.
      lo_http_client->request->set_header_field( name  = '~request_uri'
                                                 value = mv_request_url ).
    ENDIF.

    lo_http_client->request->set_header_field( name  = 'Content-Length'
                                               value = lv_length_text ).

    IF it_request_header IS NOT INITIAL.
      LOOP AT it_request_header INTO ls_request_header.
        lo_http_client->request->set_header_field( name  = ls_request_header-name
                                                   value = ls_request_header-value ).
      ENDLOOP.
    ELSE.
      lo_http_client->request->set_header_field( name  = 'Content-Type'
                                                 value = 'text/xml; charset=utf-8' ).
    ENDIF.

    lo_http_client->request->set_cdata( data   = iv_request
                                        offset = 0
                                        length = lv_request_length ).

    lo_http_client->send(
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5 ).
    IF sy-subrc <> 0.
      lx_exception = /itetr/cx_regulative_exception=>create_by_message( iv_msgno = '004' ).
      RAISE EXCEPTION lx_exception.
    ENDIF.

    lo_http_client->receive(
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 4 ).
    IF sy-subrc <> 0.
      rv_response = lo_http_client->response->get_cdata( ).
      REPLACE ALL OCCURRENCES OF REGEX '<[a-zA-Z\/][^>]*>' IN rv_response WITH space.
      REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf IN rv_response WITH ` `.
      lv_message = rv_response.
      lx_exception = /itetr/cx_regulative_exception=>create_by_message( iv_msgno = '004'
                                                                        iv_msgv1 = lv_message(50)
                                                                        iv_msgv2 = lv_message+50(50)
                                                                        iv_msgv3 = lv_message+100(50)
                                                                        iv_msgv4 = lv_message+150(50) ).
      RAISE EXCEPTION lx_exception.
    ELSE.
      rv_response = lo_http_client->response->get_cdata( ).
      IF rv_response IS INITIAL.
        lo_http_client->response->get_status(
          IMPORTING
            code   = lv_response_code
            reason = lv_response_reason ).
        WRITE lv_response_code TO lv_message LEFT-JUSTIFIED.
        CONCATENATE lv_message lv_response_reason INTO lv_message SEPARATED BY '-'.
        lx_exception = /itetr/cx_regulative_exception=>create_by_message( iv_msgno = '004'
                                                                          iv_msgv1 = lv_message(50)
                                                                          iv_msgv2 = lv_message+50(50)
                                                                          iv_msgv3 = lv_message+100(50)
                                                                          iv_msgv4 = lv_message+150(50) ).
        RAISE EXCEPTION lx_exception.
      ELSE.
        lt_xml_table = /itetr/cl_regulative_common=>parse_xml_as_table( rv_response ).

        LOOP AT lt_xml_table INTO ls_xml_line.
          CASE ls_xml_line-cname.
            WHEN 'faultstring'.
              lv_message = ls_xml_line-cvalue.
              lx_exception = /itetr/cx_regulative_exception=>create_by_message( iv_msgno = '004'
                                                                                iv_msgv1 = lv_message(50)
                                                                                iv_msgv2 = lv_message+50(50)
                                                                                iv_msgv3 = lv_message+100(50)
                                                                                iv_msgv4 = lv_message+150(50) ).
              RAISE EXCEPTION lx_exception.
          ENDCASE.
        ENDLOOP.
      ENDIF.
    ENDIF.

    IF lo_http_client IS BOUND.
      lo_http_client->close( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.