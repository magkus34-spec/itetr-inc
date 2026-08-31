class /ITETR/CL_INC_WS_LOG definition
  public
  inheriting from /ITETR/CL_INC_WS
  final
  create public .

public section.

  methods LOGIN
    exporting
      !EV_SESSIONID type STRING .
  methods LOGOUT
    importing
      !IV_SESSIONID type STRING .

  methods INCOMING_INVOICE_DOWNLOAD
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC_WS_LOG IMPLEMENTATION.


 METHOD incoming_invoice_download.
   DATA: lv_invoice_base64 TYPE string,
         lv_request_xml    TYPE string,
         lv_response_xml   TYPE string,
         lv_zipped_file    TYPE xstring,
         lv_file_name      TYPE string,
         lt_request_header TYPE mty_service_header_tab,
         lv_sessionid      TYPE string,
         ls_xml_line       TYPE smum_xmltb,
         lt_xml_table      TYPE TABLE OF smum_xmltb,
         lx_exception      TYPE REF TO /itetr/cx_regulative_exception,
         lv_content        TYPE string.

   FIELD-SYMBOLS: <ls_request_header> TYPE mty_service_header.

   CALL METHOD me->login
     IMPORTING
       ev_sessionid = lv_sessionid.

   CONCATENATE
   '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">'
      '<soapenv:Header/>'
      '<soapenv:Body>'
         '<tem:getDocumentData>'
            '<tem:sessionID>' lv_sessionid '</tem:sessionID>'
            '<tem:uuid>' is_document_numbers-duich '</tem:uuid>'
            '<tem:docType>EINVOICE</tem:docType>'
            '<tem:dataType>' iv_content_type '</tem:dataType>'
         '</tem:getDocumentData>'
      '</soapenv:Body>'
   '</soapenv:Envelope>'
   INTO lv_request_xml.

   APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
   <ls_request_header>-name  = 'SOAPAction'.
   <ls_request_header>-value = 'http://tempuri.org/IPostBoxService/getDocumentData'.
   APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
   <ls_request_header>-name  = 'Content-Type'.
   <ls_request_header>-value = 'text/xml; charset=utf-8'.

   lv_response_xml = run_service( iv_request = lv_request_xml
                                  iv_authenticate = abap_true
                                  it_request_header = lt_request_header ).

   lt_xml_table = /itetr/cl_regulative_common=>parse_xml_as_table( lv_response_xml ).

   LOOP AT lt_xml_table INTO ls_xml_line.
     CASE ls_xml_line-cname.
       WHEN 'Value'.
         CONCATENATE lv_content ls_xml_line-cvalue INTO lv_content.
     ENDCASE.
   ENDLOOP.

   IF lv_content IS NOT INITIAL.
     lv_zipped_file = /itetr/cl_regulative_common=>decode_base64( iv_input = lv_content ).
     /itetr/cl_regulative_common=>unzip_file_single(
       EXPORTING
         iv_zipped_file_xstr = lv_zipped_file
       IMPORTING
         ev_output_data_xstr = rv_invoice_data ).
   ENDIF.
*
   CALL METHOD me->logout
     EXPORTING
       iv_sessionid = lv_sessionid.
 ENDMETHOD.


  METHOD login.
    DATA: lv_request_xml    TYPE string,
          lv_response_xml   TYPE string,
          lt_request_header TYPE mty_service_header_tab,
          lv_sessionid      TYPE string,
          lv_zipped_file    TYPE xstring,
          lt_xml_table      TYPE TABLE OF smum_xmltb,
          ls_xml_line       TYPE smum_xmltb,
          lv_taxpayers_xml  TYPE string,
          ls_taxpayer       TYPE /itetr/inv_taxp,
          ls_user_list      TYPE /itetr/inv_s_userlist,
          ls_user           TYPE /itetr/inv_s_user,
          ls_documents      TYPE /itetr/inv_s_userlist_doc,
          ls_alias          TYPE /itetr/inv_s_userlist_alias.

    FIELD-SYMBOLS: <ls_request_header> TYPE mty_service_header.

    CONCATENATE
    '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:efat="http://schemas.datacontract.org/2004/07/eFaturaWebService">'
       '<soapenv:Header/>'
       '<soapenv:Body>'
          '<tem:Login>'
             '<tem:login>'
                '<efat:passWord>' me->ms_company_parameters-wspwd '</efat:passWord>'
                '<efat:userName>' me->ms_company_parameters-wsusr '</efat:userName>'
            ' </tem:login>'
          '</tem:Login>'
       '</soapenv:Body>'
    '</soapenv:Envelope>'
    INTO lv_request_xml.

    APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
    <ls_request_header>-name  = 'SOAPAction'.
    <ls_request_header>-value = 'http://tempuri.org/IPostBoxService/Login'.
    APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
    <ls_request_header>-name  = 'Content-Type'.
    <ls_request_header>-value = 'text/xml; charset=utf-8'.

    lv_response_xml = run_service( iv_request = lv_request_xml
                                   iv_authenticate = abap_true
                                   it_request_header = lt_request_header ).

    lt_xml_table = /itetr/cl_regulative_common=>parse_xml_as_table( lv_response_xml ).
    LOOP AT lt_xml_table INTO ls_xml_line.
      CASE ls_xml_line-cname.
        WHEN 'sessionID'.
          CONCATENATE lv_sessionid ls_xml_line-cvalue INTO lv_sessionid.
      ENDCASE.
    ENDLOOP.

    IF lv_sessionid IS NOT INITIAL.
      ev_sessionid = lv_sessionid.
    ENDIF.
  ENDMETHOD.


  METHOD logout.
    DATA: lv_request_xml    TYPE string,
          lv_response_xml   TYPE string,
          lt_request_header TYPE mty_service_header_tab,
          lv_sessionid      TYPE string,
          lv_zipped_file    TYPE xstring,
          lt_xml_table      TYPE TABLE OF smum_xmltb,
          ls_xml_line       TYPE smum_xmltb,
          lv_taxpayers_xml  TYPE string,
          ls_taxpayer       TYPE /itetr/inv_taxp,
          ls_user_list      TYPE /itetr/inv_s_userlist,
          ls_user           TYPE /itetr/inv_s_user,
          ls_documents      TYPE /itetr/inv_s_userlist_doc,
          ls_alias          TYPE /itetr/inv_s_userlist_alias.

    FIELD-SYMBOLS: <ls_request_header> TYPE mty_service_header.

    CONCATENATE
    '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:efat="http://schemas.datacontract.org/2004/07/eFaturaWebService">'
       '<soapenv:Header/>'
       '<soapenv:Body>'
          '<tem:Logout>'
                ' <tem:sessionID>' iv_sessionid '</tem:sessionID>'
            ' </tem:Logout>'
       '</soapenv:Body>'
    '</soapenv:Envelope>'
    INTO lv_request_xml.

    APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
    <ls_request_header>-name  = 'SOAPAction'.
    <ls_request_header>-value = 'http://tempuri.org/IPostBoxService/Logout'.
    APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
    <ls_request_header>-name  = 'Content-Type'.
    <ls_request_header>-value = 'text/xml; charset=utf-8'.

    lv_response_xml = run_service( iv_request = lv_request_xml
                                   iv_authenticate = abap_true
                                   it_request_header = lt_request_header ).
  ENDMETHOD.
ENDCLASS.