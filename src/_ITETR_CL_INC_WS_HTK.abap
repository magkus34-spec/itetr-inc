class /ITETR/CL_INC_WS_HTK definition
  public
  inheriting from /ITETR/CL_INC_WS
  final
  create public .

public section.

  constants MC_ERPCODE_PARAMETER type /ITETR/COM_E_CUSPA value 'ERPCODE' ##NO_TEXT.

  methods GET_TOKEN
    returning
      value(RV_TOKEN) type STRING .
  methods UTILENCRYPT
    exporting
      !EV_CRPSW type STRING
      !EV_CRUSER type STRING .

  methods INCOMING_INVOICE_DOWNLOAD
    redefinition .
protected section.

  methods RUN_SERVICE_REST
    importing
      !IV_BODY type STRING
      !IT_REQUEST_HEADER type MTY_SERVICE_HEADER_TAB optional
      !IV_URL type STRING
      !IV_METHOD type STRING
    returning
      value(RV_RESPONSE) type STRING .
private section.
ENDCLASS.



CLASS /ITETR/CL_INC_WS_HTK IMPLEMENTATION.


  METHOD get_token.

    TYPES : BEGIN OF ty_result,
              token TYPE string.
    TYPES END OF ty_result.

    DATA: lv_body               TYPE string,
          lv_response           TYPE string,
          lt_request_header     TYPE mty_service_header_tab,
          lv_cruser             TYPE string,
          lv_crpsw              TYPE string,
          lt_result             TYPE TABLE OF ty_result.

    FIELD-SYMBOLS: <ls_request_header> TYPE mty_service_header.

    CALL METHOD me->utilencrypt
      IMPORTING
        ev_cruser = lv_cruser
        ev_crpsw  = lv_crpsw.

    CONCATENATE '{ "apiKey": "' ms_company_parameters-apikey '", "username": "' lv_cruser '", "password": "' lv_crpsw '" }' INTO lv_body.

    lv_response = run_service_rest( iv_body            = lv_body
                                    iv_url             = 'https://econnecttest.hizliteknoloji.com.tr/HizliApi/RestApi/Login'
                                    iv_method          = 'POST'
                                    it_request_header = lt_request_header ).

    /ui2/cl_json=>deserialize( EXPORTING json        = lv_response
                                         pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                               CHANGING  data        = lt_result ).
    READ TABLE lt_result INTO DATA(ls_result) INDEX 1.
    IF sy-subrc EQ 0.
      rv_token = ls_result-token.
    ENDIF.

  ENDMETHOD.


  METHOD incoming_invoice_download.

    TYPES : BEGIN OF ty_result,
              documentfile TYPE string.
    TYPES END OF ty_result.

    DATA: lv_request_xml      TYPE string,
          lv_response         TYPE string,
          lt_xml_table        TYPE TABLE OF smum_xmltb,
          ls_xml_line         TYPE smum_xmltb,
          ls_custom_parameter TYPE /itetr/inv_eicp,
          lv_content          TYPE string,
          lv_zipped_file      TYPE xstring,
          lv_body             TYPE string,
          lv_url              TYPE string,
          lv_apptype          TYPE string,
          lv_uuid             TYPE string,
          lv_tur              TYPE string,
          lv_isdraft          TYPE string,
          lv_token            TYPE string,
          lt_request_header   TYPE mty_service_header_tab,
          ls_result           TYPE ty_result,
          lv_base64_content   TYPE string,
          lv_output           TYPE string,
          lv_invoice          TYPE string.

    FIELD-SYMBOLS: <ls_request_header> TYPE mty_service_header.

    lv_token   = get_token( ).

    lv_apptype = '1'.
    lv_uuid    = is_document_numbers-duich.
    lv_isdraft = 'false'.

    IF iv_content_type EQ 'UBL'.
      lv_tur = 'XML'.
    ELSE.
      lv_tur = iv_content_type.
    ENDIF.

    lv_url     = 'https://econnecttest.hizliteknoloji.com.tr/HizliApi/RestApi/GetDocumentFile' &&
                 '?AppType=' && lv_apptype &&
                 '&Uuid='    && lv_uuid &&
                 '&Tur='     && lv_tur &&
                 '&IsDraft=' && lv_isdraft.

    APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
    <ls_request_header>-name  = 'Authorization'.
    <ls_request_header>-value = |Bearer { lv_token }|.

    lv_response  = run_service_rest( iv_body           = lv_body
                                     iv_url            = lv_url
                                     iv_method         = 'GET'
                                     it_request_header = lt_request_header ).

    /ui2/cl_json=>deserialize( EXPORTING json    = lv_response
                                     pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                           CHANGING  data        = ls_result ).

    IF ls_result-documentfile IS NOT INITIAL.
      lv_base64_content = ls_result-documentfile.
    ENDIF.

    rv_invoice_data = /itetr/cl_regulative_common=>decode_base64( iv_input = lv_base64_content ).


  ENDMETHOD.


  METHOD run_service_rest.

    DATA: lo_http_client     TYPE REF TO if_http_client,
          lv_message         TYPE bapi_msg,
          lt_xml_table       TYPE TABLE OF smum_xmltb,
          ls_xml_line        TYPE smum_xmltb,
          lx_exception       TYPE REF TO /itetr/cx_regulative_exception,
          lv_response_code   TYPE i,
          lv_response_reason TYPE string,
          ls_request_header  TYPE /itetr/cl_einvoice_ws=>mty_service_header.

    CALL METHOD cl_http_client=>create_by_url
      EXPORTING
        url                = iv_url
      IMPORTING
        client             = lo_http_client
      EXCEPTIONS
        argument_not_found = 1
        plugin_not_active  = 2
        internal_error     = 3
        OTHERS             = 4.
    IF sy-subrc <> 0.
      lx_exception = /itetr/cx_regulative_exception=>create_by_message( iv_msgno = '004' ).
      RAISE EXCEPTION lx_exception.
    ENDIF.

    lo_http_client->request->set_header_field( name  = 'Accept'
                                               value = 'application/json' ).

    lo_http_client->request->set_header_field( name  = 'Content-Type'
                                               value = 'application/json' ).

    IF it_request_header IS NOT INITIAL.
      LOOP AT it_request_header INTO ls_request_header.
        lo_http_client->request->set_header_field( name  = ls_request_header-name
                                                   value = ls_request_header-value ).
      ENDLOOP.
    ENDIF.

    IF iv_method EQ 'POST'.
      CALL METHOD lo_http_client->request->set_method( if_http_request=>co_request_method_post ).
    ELSEIF iv_method EQ 'GET'.
      CALL METHOD lo_http_client->request->set_method( if_http_request=>co_request_method_get ).
    ENDIF.

    lo_http_client->request->set_cdata( data   = iv_body ).

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


  METHOD utilencrypt.

    TYPES : BEGIN OF ty_result ,
              username TYPE string,
              password TYPE string.
    TYPES END OF ty_result.

    DATA: lv_body               TYPE string,
          lv_response           TYPE string,
          lt_request_header     TYPE mty_service_header_tab,
          ls_result             TYPE ty_result.


    FIELD-SYMBOLS: <ls_request_header> TYPE mty_service_header.

    CONCATENATE '{ "secretKey": "' ms_company_parameters-secretkey '", "username": "' ms_company_parameters-wsusr '", "password": "' ms_company_parameters-wspwd '" }' INTO lv_body.

    lv_response = run_service_rest( iv_body           = lv_body
                                    iv_url            = 'https://econnecttest.hizliteknoloji.com.tr/HizliApi/RestApi/UtilEncrypt'
                                    iv_method         = 'POST'
                                    it_request_header = lt_request_header ).

    /ui2/cl_json=>deserialize( EXPORTING json        = lv_response
                                         pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                               CHANGING  data        = ls_result ).

    ev_cruser = ls_result-username.
    ev_crpsw  = ls_result-password.

  ENDMETHOD.
ENDCLASS.