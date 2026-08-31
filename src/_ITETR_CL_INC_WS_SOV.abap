class /ITETR/CL_INC_WS_SOV definition
  public
  inheriting from /ITETR/CL_INC_WS
  final
  create public .

public section.

  constants MC_ERPCODE_PARAMETER type /ITETR/COM_E_CUSPA value 'ERPCODE' ##NO_TEXT.

  methods INCOMING_INVOICE_DOWNLOAD
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC_WS_SOV IMPLEMENTATION.


  METHOD incoming_invoice_download.

    DATA: lv_request_xml    TYPE string,
          lt_request_header TYPE mty_service_header_tab,
          lv_response_xml   TYPE string,
          lt_xml_table      TYPE TABLE OF smum_xmltb,
          ls_xml_line       TYPE smum_xmltb,
          lv_content        TYPE string,
          lv_zipped_file    TYPE xstring,
          lv_content_type   TYPE string.

    FIELD-SYMBOLS: <ls_request_header> TYPE mty_service_header.

    IF iv_content_type EQ 'DEF'.
      lv_content_type = 'HTML_DEFAULT'.
    ELSE.
      lv_content_type =  iv_content_type.
    ENDIF.

    IF iv_content_type EQ 'UBL'.

      CONCATENATE
         '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ein="http:/fitcons.com/eInvoice/">'
           '<soapenv:Header/>'
           '<soapenv:Body>'
              '<ein:getUBLRequest>'
                 '<ein:Identifier>' ms_company_parameters-aliass '</ein:Identifier>'
                 '<ein:VKN_TCKN>' mv_company_taxid '</ein:VKN_TCKN>'
                 '<ein:UUID>' is_document_numbers-duich '</ein:UUID>'
                 '<ein:DocType>INVOICE</ein:DocType>'
                 '<ein:Type>INBOUND</ein:Type>'
                 '<ein:Parameters>zip</ein:Parameters>'
              '</ein:getUBLRequest>'
           '</soapenv:Body>'
         '</soapenv:Envelope>'
         INTO lv_request_xml.

      APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
      <ls_request_header>-name  = 'SOAPAction'.
      <ls_request_header>-value = 'getUBL'.
      APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
      <ls_request_header>-name  = 'Content-Type'.
      <ls_request_header>-value = 'text/xml; charset=utf-8'.

      lv_response_xml = run_service( iv_request = lv_request_xml
                                     iv_authenticate = abap_true
                                     it_request_header = lt_request_header ).

      lt_xml_table = /itetr/cl_regulative_common=>parse_xml_as_table( lv_response_xml ).

      LOOP AT lt_xml_table INTO ls_xml_line.
        CASE ls_xml_line-cname.
          WHEN 'DocData'.
            CONCATENATE lv_content
                ls_xml_line-cvalue
                INTO lv_content.
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

    ELSE.

      CONCATENATE
      '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ein="http:/fitcons.com/eInvoice/">'
         '<soapenv:Header/>'
         '<soapenv:Body>'
            '<ein:getInvoiceViewRequest>'
               '<ein:UUID>' is_document_numbers-duich '</ein:UUID>'
*             '<ein:CustInvID> </ein:CustInvID>'
               '<ein:Identifier>' ms_company_parameters-aliass '</ein:Identifier>'
               '<ein:VKN_TCKN>' mv_company_taxid '</ein:VKN_TCKN>'
               '<ein:Type>INBOUND</ein:Type>'
               '<ein:DocType>' lv_content_type '</ein:DocType>'
            '</ein:getInvoiceViewRequest>'
         '</soapenv:Body>'
      '</soapenv:Envelope>'
      INTO lv_request_xml.

      APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
      <ls_request_header>-name  = 'SOAPAction'.
      <ls_request_header>-value = 'getInvoiceView'.
      APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
      <ls_request_header>-name  = 'Content-Type'.
      <ls_request_header>-value = 'text/xml; charset=utf-8'.

      lv_response_xml = run_service( iv_request = lv_request_xml
                                     iv_authenticate = abap_true
                                     it_request_header = lt_request_header ).

      lt_xml_table = /itetr/cl_regulative_common=>parse_xml_as_table( lv_response_xml ).

      LOOP AT lt_xml_table INTO ls_xml_line.
        CASE ls_xml_line-cname.
          WHEN 'DocData'.
            CONCATENATE lv_content
                ls_xml_line-cvalue
                INTO lv_content.
        ENDCASE.
      ENDLOOP.

      IF lv_content IS NOT INITIAL.
        rv_invoice_data = /itetr/cl_regulative_common=>decode_base64( lv_content ).
      ENDIF.
    ENDIF.


  ENDMETHOD.
ENDCLASS.