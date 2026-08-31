class /ITETR/CL_INC_WS_VBT definition
  public
  inheriting from /ITETR/CL_INC_WS
  final
  create public .

public section.

  types:
    BEGIN OF mty_incoming_document,
        invoicenumber               TYPE string,
        profileid                   TYPE string,
        invoicetypecode             TYPE string,
        id                          TYPE string,
        sqlid                       TYPE string,
        incomingdate                TYPE string,
        firmid                      TYPE string,
        documentcurrencycode        TYPE string,
        accountingsupplierpartyname TYPE string,
        accountingsuppliervkntckn   TYPE string,
        issuedate                   TYPE string,
        lineextensionamount         TYPE string,
        taxexclusiveamount          TYPE string,
        taxinclusiveamount          TYPE string,
        allowancetotalamount        TYPE string,
        payableamount               TYPE string,
        envelopeid                  TYPE string,
        invoicestatusforuser        TYPE string,
        isprinted                   TYPE string,
        uuid                        TYPE string,
        taxtotalamount              TYPE string,
        withholdingtaxtotalamount   TYPE string,
        locationcode                TYPE string,
        invoicestatus               TYPE string,
        inworkflow                  TYPE string,
        lastapproveruser            TYPE string,
        calculationrate             TYPE string,
        erpprocessuserid            TYPE string,
        erpprocessdate              TYPE string,
        erpprocessbranch            TYPE string,
        iserpprocessed              TYPE string,
        isarchived                  TYPE string,
        archivedate                 TYPE string,
        archiveuser                 TYPE string,
        archivestatus               TYPE string,
        isread                      TYPE string,
        isreaddate                  TYPE string,
      END OF mty_incoming_document .
  types:
    mty_incoming_documents TYPE STANDARD TABLE OF mty_incoming_document WITH DEFAULT KEY .
  types:
    BEGIN OF mty_http_request_header.
    TYPES name  TYPE string.
    TYPES value TYPE string.
    TYPES rtype TYPE char1. "q:query h:header
    TYPES END OF mty_http_request_header .
  types:
    mty_http_request_header_t TYPE TABLE OF mty_http_request_header .

  methods GET_TOKEN
    returning
      value(RV_TOKEN) type STRING .

  methods INCOMING_INVOICE_DOWNLOAD
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC_WS_VBT IMPLEMENTATION.


  method GET_TOKEN.
  endmethod.


  METHOD incoming_invoice_download.
*    TYPES: BEGIN OF ty_pdf,
*             invoicepdffilebytes TYPE string,
*           END OF ty_pdf.
*
*    TYPES: BEGIN OF ty_json_pdf,
*             refreshtoken TYPE string,
*             data         TYPE ty_pdf,
*           END OF ty_json_pdf.
*
*    TYPES: BEGIN OF ty_html,
*             invoicehtmlview TYPE string,
*           END OF ty_html.
*
*    TYPES: BEGIN OF ty_json_html,
*             refreshtoken TYPE string,
*             data         TYPE ty_html,
*           END OF ty_json_html.
*
*    TYPES: BEGIN OF ty_ubl,
*             incominginvoicexmllist TYPE string,
*           END OF ty_ubl.
*
*    TYPES: BEGIN OF ty_json_ubl,
*             refreshtoken TYPE string,
*             data         TYPE ty_ubl,
*           END OF ty_json_ubl.
*
*    DATA: lv_body           TYPE string,
*          lv_response       TYPE string,
*          lt_request_header TYPE mty_http_request_header_t,
*          lv_base64_content TYPE string,
*          lv_zipped_file    TYPE xstring,
*          lt_xml_table      TYPE TABLE OF smum_xmltb,
*          ls_xml_line       TYPE smum_xmltb,
*          lv_file_name      TYPE string,
*          lv_url            TYPE string,
*          lv_apptype        TYPE string,
*          lv_type           TYPE string,
*          lv_token          TYPE string,
*          lv_unzipped_data  TYPE xstring,
*          lt_binary_data    TYPE solix_tab,
*          lv_json_data      TYPE string,
*          lv_invoice_base64 TYPE string,
*          lv_input          TYPE string,
*          ls_json_pdf       TYPE ty_json_pdf,
*          ls_json_ubl       TYPE ty_json_ubl,
*          ls_json_html      TYPE ty_json_html,
*          lv_message        TYPE bapi_msg,
*          lx_exception      TYPE REF TO /itetr/cx_regulative_exception.
*
*    FIELD-SYMBOLS: <ls_request_header> TYPE mty_http_request_header.
*
*
*    lv_token   = get_token( ).
*
*    APPEND INITIAL LINE TO lt_request_header ASSIGNING <ls_request_header>.
*    <ls_request_header>-name  = 'vbtauthorization'.
*    <ls_request_header>-value = lv_token .
*    <ls_request_header>-rtype = 'h'.
*
*
*    CASE iv_content_type.
*      WHEN /itetr/cl_regulative_archive=>mc_content_types-html.
*
*        lv_input = '{"Ettn": "' && is_document_numbers-duich && '"}'.
*
*        lv_response = me->run_service_rest(
*                             EXPORTING
*                               iv_method         = 'POST'
*                               iv_body           = lv_input
*                               it_request_header = lt_request_header
*                               iv_api            = '/api/VbtApi/GetIncomingInvoiceView' ).
*
*        /ui2/cl_json=>deserialize( EXPORTING json = lv_response
*                                             pretty_name = /ui2/cl_json=>pretty_mode-camel_case
*                                    CHANGING data = ls_json_html ).
*
*        rv_invoice_data = /itetr/cl_regulative_common=>convert_string_to_xstring( iv_input = ls_json_html-data-invoicehtmlview ).
*
*      WHEN /itetr/cl_regulative_archive=>mc_content_types-pdf.
*
*        lv_input = '{"InvoiceEttns": ["' && is_document_numbers-duich && '"]}'.
*        lv_response = me->run_service_rest(
*                             EXPORTING
*                               iv_method         = 'POST'
*                               iv_body           = lv_input
*                               it_request_header = lt_request_header
*                               iv_api            = '/api/VbtApi/GetIncomingInvoicePdf' ).
*
*        /ui2/cl_json=>deserialize( EXPORTING json = lv_response
*                                     pretty_name = /ui2/cl_json=>pretty_mode-camel_case
*                                 CHANGING data = ls_json_pdf ).
*
*        rv_invoice_data = /itetr/cl_regulative_common=>decode_base64( iv_input = ls_json_pdf-data-invoicepdffilebytes ).
*
*      WHEN /itetr/cl_regulative_archive=>mc_content_types-ubl.
*
*        lv_input = '{"InvoiceEttns": ["' && is_document_numbers-duich && '"]}'.
*
*        lv_response = me->run_service_rest(
*                     EXPORTING
*                       iv_method         = 'POST'
*                       iv_body           = lv_input
*                       it_request_header = lt_request_header
*                       iv_api            = '/api/VbtApi/GetIncomingInvoiceXmlList' ).
*
*        /ui2/cl_json=>deserialize( EXPORTING json = lv_response
*                                     pretty_name = /ui2/cl_json=>pretty_mode-camel_case
*                                  CHANGING data = ls_json_ubl ).
*
*        lv_zipped_file = /itetr/cl_regulative_common=>decode_base64( iv_input = ls_json_ubl-data-incominginvoicexmllist ).
*        /itetr/cl_regulative_common=>unzip_file_single(
*          EXPORTING
*            iv_zipped_file_xstr = lv_zipped_file
*          IMPORTING
*            ev_output_data_xstr = rv_invoice_data ).
*    ENDCASE.
*
*    IF rv_invoice_data IS INITIAL.
*      lx_exception = /itetr/cx_regulative_exception=>create_by_message( iv_msgno = '004' ).
*      RAISE EXCEPTION lx_exception.
*    ENDIF.

  ENDMETHOD.
ENDCLASS.