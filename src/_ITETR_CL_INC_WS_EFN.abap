CLASS /itetr/cl_inc_ws_efn DEFINITION
  PUBLIC
  INHERITING FROM /itetr/cl_inc_ws
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF mty_document_status,
        alimtarihi                TYPE string,
        belgeno                   TYPE string,
        ettn                      TYPE string,
        yanitdetayi               TYPE string,
        yanitdurumu               TYPE string,
        yanitgonderimcevabidetayi TYPE string,
        yanitgonderimcevabikodu   TYPE string,
        yanitgonderimdurumu       TYPE string,
        yanitgonderimtarihi       TYPE string,
        sirano                    TYPE string,
        yereleaktarimdurumu       TYPE string,
        kepdurum                  TYPE string,
        gibiptaldurum             TYPE string,
      END OF mty_document_status .
    TYPES:
      BEGIN OF mty_incoming_document,
        belgeno                 TYPE string,
        belgesirano             TYPE string,
        belgetarihi             TYPE string,
        ettn                    TYPE string,
        zarfid                  TYPE string,
        gonderenetiket          TYPE string,
        gonderenvkntckn         TYPE string,
        belgexmlzipped          TYPE string,
        odenecektutar           TYPE string,
        odenecektutardovizcinsi TYPE string,
      END OF mty_incoming_document .
    TYPES:
      mty_incoming_documents TYPE STANDARD TABLE OF mty_incoming_document WITH DEFAULT KEY .

    CONSTANTS mc_erpcode_parameter TYPE /itetr/com_e_cuspa VALUE 'ERPCODE' ##NO_TEXT.

    METHODS incoming_invoice_download
        REDEFINITION .
protected section.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ITETR/CL_INC_WS_EFN IMPLEMENTATION.


  METHOD incoming_invoice_download.
    DATA: lv_request_xml      TYPE string,
          lv_response_xml     TYPE string,
          lt_xml_table        TYPE TABLE OF smum_xmltb,
          ls_xml_line         TYPE smum_xmltb,
          ls_custom_parameter TYPE /itetr/inc_eicp,
          lv_content          TYPE string,
          lv_zipped_file      TYPE xstring,
          lv_req_xml          TYPE xstring.

    DATA: lv_xml_raw TYPE xstring,
          lt_return  TYPE TABLE OF bapiret2.

    FIELD-SYMBOLS: <lv_return_field> TYPE any.

    READ TABLE mt_custom_parameters INTO ls_custom_parameter WITH TABLE KEY by_cuspa COMPONENTS cuspa = mc_erpcode_parameter.

    CONCATENATE
    '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.connector.uut.cs.com.tr/">'
      '<soapenv:Header>'
        '<wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">'
          '<wsse:UsernameToken>'
                '<wsse:Username>' ms_company_parameters-wsusr '</wsse:Username>'
                '<wsse:Password>' ms_company_parameters-wspwd '</wsse:Password>'
          '</wsse:UsernameToken>'
        '</wsse:Security>'
      '</soapenv:Header>'
       '<soapenv:Body>'
       '<ser:gelenBelgeleriIndirExt>'
           '<parametreler>'
              '<ettn>' is_document_numbers-duich '</ettn>'
              '<belgeTuru>FATURA</belgeTuru>'
              '<belgeFormati>' iv_content_type '</belgeFormati>'
              '<erpKodu>' ls_custom_parameter-value '</erpKodu>'
              '<vergiTcKimlikNo>' mv_company_taxid '</vergiTcKimlikNo>'
           '</parametreler>'
        '</ser:gelenBelgeleriIndirExt>'
      '</soapenv:Body>'
    '</soapenv:Envelope>'
    INTO lv_request_xml.
*    mv_request_url = '/efatura/ws/connectorService'.
    lv_response_xml = run_service( lv_request_xml ).

    lt_xml_table = /itetr/cl_regulative_common=>parse_xml_as_table( lv_response_xml ).
    LOOP AT lt_xml_table INTO ls_xml_line.
      CASE ls_xml_line-cname.
        WHEN 'return'.
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

  ENDMETHOD.
ENDCLASS.