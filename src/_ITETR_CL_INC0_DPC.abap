class /ITETR/CL_INC0_DPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_DATA
  abstract
  create public .

public section.

  interfaces /IWBEP/IF_SB_DPC_COMM_SERVICES .
  interfaces /IWBEP/IF_SB_GENDPC_SHLP_DATA .
  interfaces /IWBEP/IF_SB_GEN_DPC_INJECTION .

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITYSET
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~UPDATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~DELETE_ENTITY
    redefinition .
protected section.

  data mo_injection type ref to /IWBEP/IF_SB_GEN_DPC_INJECTION .

  methods TAXIDSHSET_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_TAXIDSH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods TAXIDSHSET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /ITETR/CL_INC0_MPC=>TT_TAXIDSH
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods TAXIDSHSET_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_TAXIDSH
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods TAXIDSHSET_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods TAXIDSHSET_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_TAXIDSH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods LIFNRSHSET_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_LIFNRSH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods LIFNRSHSET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /ITETR/CL_INC0_MPC=>TT_LIFNRSH
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods LIFNRSHSET_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_LIFNRSH
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods LIFNRSHSET_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods LIFNRSHSET_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_LIFNRSH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICESET_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_INVOICE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICESET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /ITETR/CL_INC0_MPC=>TT_INVOICE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICESET_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_INVOICE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICESET_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICESET_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_INVOICE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICEDETAILTWO_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_INVOICEDETAILTWO
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICEDETAILTWO_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /ITETR/CL_INC0_MPC=>TT_INVOICEDETAILTWO
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICEDETAILTWO_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_INVOICEDETAILTWO
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICEDETAILTWO_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICEDETAILTWO_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_INVOICEDETAILTWO
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICEDETAILONE_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_INVOICEDETAILONE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICEDETAILONE_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /ITETR/CL_INC0_MPC=>TT_INVOICEDETAILONE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICEDETAILONE_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_INVOICEDETAILONE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICEDETAILONE_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods INVOICEDETAILONE_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_INVOICEDETAILONE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods DOWNLOADFILESET_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_DOWNLOADFILE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods DOWNLOADFILESET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /ITETR/CL_INC0_MPC=>TT_DOWNLOADFILE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods DOWNLOADFILESET_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_DOWNLOADFILE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods DOWNLOADFILESET_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods DOWNLOADFILESET_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_DOWNLOADFILE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods BUKRSSHSET_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_BUKRSSH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods BUKRSSHSET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /ITETR/CL_INC0_MPC=>TT_BUKRSSH
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods BUKRSSHSET_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_BUKRSSH
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods BUKRSSHSET_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods BUKRSSHSET_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_BUKRSSH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods BSARTSHSET_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_BSARTSH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods BSARTSHSET_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /ITETR/CL_INC0_MPC=>TT_BSARTSH
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods BSARTSHSET_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_BSARTSH
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods BSARTSHSET_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods BSARTSHSET_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /ITETR/CL_INC0_MPC=>TS_BSARTSH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .

  methods CHECK_SUBSCRIPTION_AUTHORITY
    redefinition .
private section.
ENDCLASS.



CLASS /ITETR/CL_INC0_DPC IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_CRT_ENTITY_BASE
*&* This class has been generated on 23.11.2023 17:40:26 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - /ITETR/CL_INC0_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA taxidshset_create_entity TYPE /itetr/cl_inc0_mpc=>ts_taxidsh.
 DATA invoiceset_create_entity TYPE /itetr/cl_inc0_mpc=>ts_invoice.
 DATA bsartshset_create_entity TYPE /itetr/cl_inc0_mpc=>ts_bsartsh.
 DATA invoicedetailtwo_create_entity TYPE /itetr/cl_inc0_mpc=>ts_invoicedetailtwo.
 DATA lifnrshset_create_entity TYPE /itetr/cl_inc0_mpc=>ts_lifnrsh.
 DATA invoicedetailone_create_entity TYPE /itetr/cl_inc0_mpc=>ts_invoicedetailone.
 DATA downloadfileset_create_entity TYPE /itetr/cl_inc0_mpc=>ts_downloadfile.
 DATA bukrsshset_create_entity TYPE /itetr/cl_inc0_mpc=>ts_bukrssh.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  TaxIdSHSet
*-------------------------------------------------------------------------*
     WHEN 'TaxIdSHSet'.
*     Call the entity set generated method
    taxidshset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = taxidshset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = taxidshset_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceSet
*-------------------------------------------------------------------------*
     WHEN 'InvoiceSet'.
*     Call the entity set generated method
    invoiceset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = invoiceset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = invoiceset_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  BSartSHSet
*-------------------------------------------------------------------------*
     WHEN 'BSartSHSet'.
*     Call the entity set generated method
    bsartshset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = bsartshset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = bsartshset_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceDetailTwoSet
*-------------------------------------------------------------------------*
     WHEN 'InvoiceDetailTwoSet'.
*     Call the entity set generated method
    invoicedetailtwo_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = invoicedetailtwo_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = invoicedetailtwo_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  LifnrSHSet
*-------------------------------------------------------------------------*
     WHEN 'LifnrSHSet'.
*     Call the entity set generated method
    lifnrshset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = lifnrshset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = lifnrshset_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceDetailOneSet
*-------------------------------------------------------------------------*
     WHEN 'InvoiceDetailOneSet'.
*     Call the entity set generated method
    invoicedetailone_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = invoicedetailone_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = invoicedetailone_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  DownloadFileSet
*-------------------------------------------------------------------------*
     WHEN 'DownloadFileSet'.
*     Call the entity set generated method
    downloadfileset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = downloadfileset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = downloadfileset_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  BukrsSHSet
*-------------------------------------------------------------------------*
     WHEN 'BukrsSHSet'.
*     Call the entity set generated method
    bukrsshset_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = bukrsshset_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = bukrsshset_create_entity
      CHANGING
        cr_data = er_entity
   ).

  when others.
    super->/iwbep/if_mgw_appl_srv_runtime~create_entity(
       EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         io_data_provider   = io_data_provider
         it_key_tab = it_key_tab
         it_navigation_path = it_navigation_path
      IMPORTING
        er_entity = er_entity
  ).
ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~DELETE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_DEL_ENTITY_BASE
*&* This class has been generated on 23.11.2023 17:40:26 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - /ITETR/CL_INC0_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  TaxIdSHSet
*-------------------------------------------------------------------------*
      when 'TaxIdSHSet'.
*     Call the entity set generated method
     taxidshset_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  BSartSHSet
*-------------------------------------------------------------------------*
      when 'BSartSHSet'.
*     Call the entity set generated method
     bsartshset_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceDetailTwoSet
*-------------------------------------------------------------------------*
      when 'InvoiceDetailTwoSet'.
*     Call the entity set generated method
     invoicedetailtwo_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceDetailOneSet
*-------------------------------------------------------------------------*
      when 'InvoiceDetailOneSet'.
*     Call the entity set generated method
     invoicedetailone_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  DownloadFileSet
*-------------------------------------------------------------------------*
      when 'DownloadFileSet'.
*     Call the entity set generated method
     downloadfileset_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  BukrsSHSet
*-------------------------------------------------------------------------*
      when 'BukrsSHSet'.
*     Call the entity set generated method
     bukrsshset_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceSet
*-------------------------------------------------------------------------*
      when 'InvoiceSet'.
*     Call the entity set generated method
     invoiceset_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  LifnrSHSet
*-------------------------------------------------------------------------*
      when 'LifnrSHSet'.
*     Call the entity set generated method
     lifnrshset_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

   when others.
     super->/iwbep/if_mgw_appl_srv_runtime~delete_entity(
        EXPORTING
          iv_entity_name = iv_entity_name
          iv_entity_set_name = iv_entity_set_name
          iv_source_name = iv_source_name
          it_key_tab = it_key_tab
          it_navigation_path = it_navigation_path
 ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_GETENTITY_BASE
*&* This class has been generated  on 23.11.2023 17:40:26 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - /ITETR/CL_INC0_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA invoiceset_get_entity TYPE /itetr/cl_inc0_mpc=>ts_invoice.
 DATA taxidshset_get_entity TYPE /itetr/cl_inc0_mpc=>ts_taxidsh.
 DATA bsartshset_get_entity TYPE /itetr/cl_inc0_mpc=>ts_bsartsh.
 DATA lifnrshset_get_entity TYPE /itetr/cl_inc0_mpc=>ts_lifnrsh.
 DATA invoicedetailtwo_get_entity TYPE /itetr/cl_inc0_mpc=>ts_invoicedetailtwo.
 DATA invoicedetailone_get_entity TYPE /itetr/cl_inc0_mpc=>ts_invoicedetailone.
 DATA bukrsshset_get_entity TYPE /itetr/cl_inc0_mpc=>ts_bukrssh.
 DATA downloadfileset_get_entity TYPE /itetr/cl_inc0_mpc=>ts_downloadfile.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data.       "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceSet
*-------------------------------------------------------------------------*
      WHEN 'InvoiceSet'.
*     Call the entity set generated method
          invoiceset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = invoiceset_get_entity
                         es_response_context = es_response_context
          ).

        IF invoiceset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = invoiceset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  TaxIdSHSet
*-------------------------------------------------------------------------*
      WHEN 'TaxIdSHSet'.
*     Call the entity set generated method
          taxidshset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = taxidshset_get_entity
                         es_response_context = es_response_context
          ).

        IF taxidshset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = taxidshset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  BSartSHSet
*-------------------------------------------------------------------------*
      WHEN 'BSartSHSet'.
*     Call the entity set generated method
          bsartshset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = bsartshset_get_entity
                         es_response_context = es_response_context
          ).

        IF bsartshset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = bsartshset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  LifnrSHSet
*-------------------------------------------------------------------------*
      WHEN 'LifnrSHSet'.
*     Call the entity set generated method
          lifnrshset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = lifnrshset_get_entity
                         es_response_context = es_response_context
          ).

        IF lifnrshset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = lifnrshset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceDetailTwoSet
*-------------------------------------------------------------------------*
      WHEN 'InvoiceDetailTwoSet'.
*     Call the entity set generated method
          invoicedetailtwo_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = invoicedetailtwo_get_entity
                         es_response_context = es_response_context
          ).

        IF invoicedetailtwo_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = invoicedetailtwo_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceDetailOneSet
*-------------------------------------------------------------------------*
      WHEN 'InvoiceDetailOneSet'.
*     Call the entity set generated method
          invoicedetailone_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = invoicedetailone_get_entity
                         es_response_context = es_response_context
          ).

        IF invoicedetailone_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = invoicedetailone_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  BukrsSHSet
*-------------------------------------------------------------------------*
      WHEN 'BukrsSHSet'.
*     Call the entity set generated method
          bukrsshset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = bukrsshset_get_entity
                         es_response_context = es_response_context
          ).

        IF bukrsshset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = bukrsshset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  DownloadFileSet
*-------------------------------------------------------------------------*
      WHEN 'DownloadFileSet'.
*     Call the entity set generated method
          downloadfileset_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = downloadfileset_get_entity
                         es_response_context = es_response_context
          ).

        IF downloadfileset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = downloadfileset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.

      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~get_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
    ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITYSET.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TMP_ENTITYSET_BASE
*&* This class has been generated on 23.11.2023 17:40:26 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - /ITETR/CL_INC0_DPC_EXT
*&-----------------------------------------------------------------------------------------------*
 DATA invoiceset_get_entityset TYPE /itetr/cl_inc0_mpc=>tt_invoice.
 DATA downloadfileset_get_entityset TYPE /itetr/cl_inc0_mpc=>tt_downloadfile.
 DATA taxidshset_get_entityset TYPE /itetr/cl_inc0_mpc=>tt_taxidsh.
 DATA bukrsshset_get_entityset TYPE /itetr/cl_inc0_mpc=>tt_bukrssh.
 DATA invoicedetailone_get_entityset TYPE /itetr/cl_inc0_mpc=>tt_invoicedetailone.
 DATA bsartshset_get_entityset TYPE /itetr/cl_inc0_mpc=>tt_bsartsh.
 DATA invoicedetailtwo_get_entityset TYPE /itetr/cl_inc0_mpc=>tt_invoicedetailtwo.
 DATA lifnrshset_get_entityset TYPE /itetr/cl_inc0_mpc=>tt_lifnrsh.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceSet
*-------------------------------------------------------------------------*
   WHEN 'InvoiceSet'.
*     Call the entity set generated method
      invoiceset_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = invoiceset_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = invoiceset_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  DownloadFileSet
*-------------------------------------------------------------------------*
   WHEN 'DownloadFileSet'.
*     Call the entity set generated method
      downloadfileset_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = downloadfileset_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = downloadfileset_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  TaxIdSHSet
*-------------------------------------------------------------------------*
   WHEN 'TaxIdSHSet'.
*     Call the entity set generated method
      taxidshset_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = taxidshset_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = taxidshset_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  BukrsSHSet
*-------------------------------------------------------------------------*
   WHEN 'BukrsSHSet'.
*     Call the entity set generated method
      bukrsshset_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = bukrsshset_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = bukrsshset_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceDetailOneSet
*-------------------------------------------------------------------------*
   WHEN 'InvoiceDetailOneSet'.
*     Call the entity set generated method
      invoicedetailone_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = invoicedetailone_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = invoicedetailone_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  BSartSHSet
*-------------------------------------------------------------------------*
   WHEN 'BSartSHSet'.
*     Call the entity set generated method
      bsartshset_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = bsartshset_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = bsartshset_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceDetailTwoSet
*-------------------------------------------------------------------------*
   WHEN 'InvoiceDetailTwoSet'.
*     Call the entity set generated method
      invoicedetailtwo_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = invoicedetailtwo_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = invoicedetailtwo_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  LifnrSHSet
*-------------------------------------------------------------------------*
   WHEN 'LifnrSHSet'.
*     Call the entity set generated method
      lifnrshset_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = lifnrshset_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = lifnrshset_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

    WHEN OTHERS.
      super->/iwbep/if_mgw_appl_srv_runtime~get_entityset(
        EXPORTING
          iv_entity_name = iv_entity_name
          iv_entity_set_name = iv_entity_set_name
          iv_source_name = iv_source_name
          it_filter_select_options = it_filter_select_options
          it_order = it_order
          is_paging = is_paging
          it_navigation_path = it_navigation_path
          it_key_tab = it_key_tab
          iv_filter_string = iv_filter_string
          iv_search_string = iv_search_string
          io_tech_request_context = io_tech_request_context
       IMPORTING
         er_entityset = er_entityset ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~UPDATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_UPD_ENTITY_BASE
*&* This class has been generated on 23.11.2023 17:40:26 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - /ITETR/CL_INC0_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA invoicedetailtwo_update_entity TYPE /itetr/cl_inc0_mpc=>ts_invoicedetailtwo.
 DATA lifnrshset_update_entity TYPE /itetr/cl_inc0_mpc=>ts_lifnrsh.
 DATA invoicedetailone_update_entity TYPE /itetr/cl_inc0_mpc=>ts_invoicedetailone.
 DATA bsartshset_update_entity TYPE /itetr/cl_inc0_mpc=>ts_bsartsh.
 DATA invoiceset_update_entity TYPE /itetr/cl_inc0_mpc=>ts_invoice.
 DATA downloadfileset_update_entity TYPE /itetr/cl_inc0_mpc=>ts_downloadfile.
 DATA taxidshset_update_entity TYPE /itetr/cl_inc0_mpc=>ts_taxidsh.
 DATA bukrsshset_update_entity TYPE /itetr/cl_inc0_mpc=>ts_bukrssh.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data. "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceDetailTwoSet
*-------------------------------------------------------------------------*
      WHEN 'InvoiceDetailTwoSet'.
*     Call the entity set generated method
          invoicedetailtwo_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = invoicedetailtwo_update_entity
          ).
       IF invoicedetailtwo_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = invoicedetailtwo_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  LifnrSHSet
*-------------------------------------------------------------------------*
      WHEN 'LifnrSHSet'.
*     Call the entity set generated method
          lifnrshset_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = lifnrshset_update_entity
          ).
       IF lifnrshset_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = lifnrshset_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceDetailOneSet
*-------------------------------------------------------------------------*
      WHEN 'InvoiceDetailOneSet'.
*     Call the entity set generated method
          invoicedetailone_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = invoicedetailone_update_entity
          ).
       IF invoicedetailone_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = invoicedetailone_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  BSartSHSet
*-------------------------------------------------------------------------*
      WHEN 'BSartSHSet'.
*     Call the entity set generated method
          bsartshset_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = bsartshset_update_entity
          ).
       IF bsartshset_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = bsartshset_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceSet
*-------------------------------------------------------------------------*
      WHEN 'InvoiceSet'.
*     Call the entity set generated method
          invoiceset_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = invoiceset_update_entity
          ).
       IF invoiceset_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = invoiceset_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  DownloadFileSet
*-------------------------------------------------------------------------*
      WHEN 'DownloadFileSet'.
*     Call the entity set generated method
          downloadfileset_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = downloadfileset_update_entity
          ).
       IF downloadfileset_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = downloadfileset_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  TaxIdSHSet
*-------------------------------------------------------------------------*
      WHEN 'TaxIdSHSet'.
*     Call the entity set generated method
          taxidshset_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = taxidshset_update_entity
          ).
       IF taxidshset_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = taxidshset_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  BukrsSHSet
*-------------------------------------------------------------------------*
      WHEN 'BukrsSHSet'.
*     Call the entity set generated method
          bukrsshset_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = bukrsshset_update_entity
          ).
       IF bukrsshset_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = bukrsshset_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~update_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             io_data_provider   = io_data_provider
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
    ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~COMMIT_WORK.
* Call RFC commit work functionality
DATA lt_message      TYPE bapiret2. "#EC NEEDED
DATA lv_message_text TYPE BAPI_MSG.
DATA lo_logger       TYPE REF TO /iwbep/cl_cos_logger.
DATA lv_subrc        TYPE syst-subrc.

lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).

  IF iv_rfc_dest IS INITIAL OR iv_rfc_dest EQ 'NONE'.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
      wait   = abap_true
    IMPORTING
      return = lt_message.
  ELSE.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      DESTINATION iv_rfc_dest
    EXPORTING
      wait                  = abap_true
    IMPORTING
      return                = lt_message
    EXCEPTIONS
      communication_failure = 1000 MESSAGE lv_message_text
      system_failure        = 1001 MESSAGE lv_message_text
      OTHERS                = 1002.

  IF sy-subrc <> 0.
    lv_subrc = sy-subrc.
    /iwbep/cl_sb_gen_dpc_rt_util=>rfc_exception_handling(
        EXPORTING
          iv_subrc            = lv_subrc
          iv_exp_message_text = lv_message_text
          io_logger           = lo_logger ).
  ENDIF.
  ENDIF.
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~GET_GENERATION_STRATEGY.
* Get generation strategy
  rv_generation_strategy = '1'.
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~LOG_MESSAGE.
* Log message in the application log
DATA lo_logger TYPE REF TO /iwbep/cl_cos_logger.
DATA lv_text TYPE /iwbep/sup_msg_longtext.

  MESSAGE ID iv_msg_id TYPE iv_msg_type NUMBER iv_msg_number
    WITH iv_msg_v1 iv_msg_v2 iv_msg_v3 iv_msg_v4 INTO lv_text.

  lo_logger = mo_context->get_logger( ).
  lo_logger->log_message(
    EXPORTING
     iv_msg_type   = iv_msg_type
     iv_msg_id     = iv_msg_id
     iv_msg_number = iv_msg_number
     iv_msg_text   = lv_text
     iv_msg_v1     = iv_msg_v1
     iv_msg_v2     = iv_msg_v2
     iv_msg_v3     = iv_msg_v3
     iv_msg_v4     = iv_msg_v4
     iv_agent      = 'DPC' ).
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~RFC_EXCEPTION_HANDLING.
* RFC call exception handling
DATA lo_logger  TYPE REF TO /iwbep/cl_cos_logger.

lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).

/iwbep/cl_sb_gen_dpc_rt_util=>rfc_exception_handling(
  EXPORTING
    iv_subrc            = iv_subrc
    iv_exp_message_text = iv_exp_message_text
    io_logger           = lo_logger ).
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~RFC_SAVE_LOG.
  DATA lo_logger  TYPE REF TO /iwbep/cl_cos_logger.
  DATA lo_message_container TYPE REF TO /iwbep/if_message_container.

  lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).
  lo_message_container = /iwbep/if_mgw_conv_srv_runtime~get_message_container( ).

  " Save the RFC call log in the application log
  /iwbep/cl_sb_gen_dpc_rt_util=>rfc_save_log(
    EXPORTING
      is_return            = is_return
      iv_entity_type       = iv_entity_type
      it_return            = it_return
      it_key_tab           = it_key_tab
      io_logger            = lo_logger
      io_message_container = lo_message_container ).
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~SET_INJECTION.
* Unit test injection
  IF io_unit IS BOUND.
    mo_injection = io_unit.
  ELSE.
    mo_injection = me.
  ENDIF.
  endmethod.


  method /IWBEP/IF_SB_GENDPC_SHLP_DATA~GET_SEARCH_HELP_VALUES.
* Call to Search Help run time mechanism to get values
  DATA lo_sh_data TYPE REF TO /iwbep/if_sb_shlp_data.

  CLEAR: et_return_list, es_message.
  lo_sh_data = /iwbep/cl_sb_shlp_data_factory=>get_sh_data_obj( ).

  lo_sh_data->/iwbep/if_sb_gendpc_shlp_data~get_search_help_values(
    EXPORTING
      iv_shlp_name  = iv_shlp_name
      iv_maxrows  = iv_maxrows
      iv_sort = iv_sort
      iv_call_shlt_exit = iv_call_shlt_exit
      it_selopt = it_selopt
    IMPORTING
      et_return_list = et_return_list
      es_message = es_message ).
  endmethod.


  method BSARTSHSET_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'BSARTSHSET_CREATE_ENTITY'.
  endmethod.


  method BSARTSHSET_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'BSARTSHSET_DELETE_ENTITY'.
  endmethod.


  method BSARTSHSET_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'BSARTSHSET_GET_ENTITY'.
  endmethod.


  method BSARTSHSET_GET_ENTITYSET.
*-------------------------------------------------------------
*  Data declaration
*-------------------------------------------------------------
DATA lo_filter TYPE  REF TO /iwbep/if_mgw_req_filter.
DATA lt_filter_select_options TYPE /iwbep/t_mgw_select_option.
DATA lv_filter_str TYPE string.
DATA lv_MAX_HITS TYPE i.
DATA ls_paging TYPE /iwbep/s_mgw_paging.
DATA ls_converted_keys LIKE LINE OF et_entityset.
DATA ls_message TYPE bapiret2.
DATA lt_selopt TYPE ddshselops.
DATA ls_selopt LIKE LINE OF lt_selopt.
DATA ls_filter TYPE /iwbep/s_mgw_select_option.
DATA ls_filter_range TYPE /iwbep/s_cod_select_option.
DATA lr_BATXT LIKE RANGE OF ls_converted_keys-batxt.
DATA ls_BATXT LIKE LINE OF lr_BATXT.
DATA lr_BSART LIKE RANGE OF ls_converted_keys-bsart.
DATA ls_BSART LIKE LINE OF lr_BSART.
DATA lt_result_list TYPE /iwbep/if_sb_gendpc_shlp_data=>tt_result_list.
DATA lv_next TYPE i VALUE 1.
DATA ls_entityset LIKE LINE OF et_entityset.
DATA ls_result_list_next LIKE LINE OF lt_result_list.
DATA ls_result_list LIKE LINE OF lt_result_list.

*-------------------------------------------------------------
*  Map the runtime request to the Search Help select option - Only mapped attributes
*-------------------------------------------------------------
* Get all input information from the technical request context object
* Since DPC works with internal property names and runtime API interface holds external property names
* the process needs to get the all needed input information from the technical request context object
* Get filter or select option information
lo_filter = io_tech_request_context->get_filter( ).
lt_filter_select_options = lo_filter->get_filter_select_options( ).
lv_filter_str = lo_filter->get_filter_string( ).

* Check if the supplied filter is supported by standard gateway runtime process
IF  lv_filter_str            IS NOT INITIAL
AND lt_filter_select_options IS INITIAL.
  " If the string of the Filter System Query Option is not automatically converted into
  " filter option table (lt_filter_select_options), then the filtering combination is not supported
  " Log message in the application log
  me->/iwbep/if_sb_dpc_comm_services~log_message(
    EXPORTING
      iv_msg_type   = 'E'
      iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
      iv_msg_number = 025 ).
  " Raise Exception
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
    EXPORTING
      textid = /iwbep/cx_mgw_tech_exception=>internal_error.
ENDIF.

* Get key table information
io_tech_request_context->get_converted_source_keys(
  IMPORTING
    es_key_values  = ls_converted_keys ).

ls_paging-top = io_tech_request_context->get_top( ).
ls_paging-skip = io_tech_request_context->get_skip( ).

" Calculate the number of max hits to be fetched from the function module
" The lv_max_hits value is a summary of the Top and Skip values
IF ls_paging-top > 0.
  lv_max_hits = is_paging-top + is_paging-skip.
ENDIF.

* Maps filter table lines to the Search Help select option table
LOOP AT lt_filter_select_options INTO ls_filter.

  CASE ls_filter-property.
    WHEN 'BATXT'.              " Equivalent to 'Batxt' property in the service
      lo_filter->convert_select_option(
        EXPORTING
          is_select_option = ls_filter
        IMPORTING
          et_select_option = lr_BATXT ).

      LOOP AT lr_BATXT INTO ls_BATXT.
        ls_selopt-high = ls_BATXT-high.
        ls_selopt-low = ls_BATXT-low.
        ls_selopt-option = ls_BATXT-option.
        ls_selopt-sign = ls_BATXT-sign.
        ls_selopt-shlpfield = 'BATXT'.
        ls_selopt-shlpname = '/ITETR/INC_SH_BSART'.
        APPEND ls_selopt TO lt_selopt.
        CLEAR ls_selopt.
      ENDLOOP.
    WHEN 'BSART'.              " Equivalent to 'Bsart' property in the service
      lo_filter->convert_select_option(
        EXPORTING
          is_select_option = ls_filter
        IMPORTING
          et_select_option = lr_BSART ).

      LOOP AT lr_BSART INTO ls_BSART.
        ls_selopt-high = ls_BSART-high.
        ls_selopt-low = ls_BSART-low.
        ls_selopt-option = ls_BSART-option.
        ls_selopt-sign = ls_BSART-sign.
        ls_selopt-shlpfield = 'BSART'.
        ls_selopt-shlpname = '/ITETR/INC_SH_BSART'.
        APPEND ls_selopt TO lt_selopt.
        CLEAR ls_selopt.
      ENDLOOP.

    WHEN OTHERS.
      " Log message in the application log
      me->/iwbep/if_sb_dpc_comm_services~log_message(
        EXPORTING
          iv_msg_type   = 'E'
          iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
          iv_msg_number = 020
          iv_msg_v1     = ls_filter-property ).
      " Raise Exception
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
        EXPORTING
          textid = /iwbep/cx_mgw_tech_exception=>internal_error.
  ENDCASE.
ENDLOOP.

*-------------------------------------------------------------
*  Call to Search Help get values mechanism
*-------------------------------------------------------------
* Get search help values
me->/iwbep/if_sb_gendpc_shlp_data~get_search_help_values(
  EXPORTING
    iv_shlp_name = '/ITETR/INC_SH_BSART'
    iv_maxrows = lv_MAX_HITS
    iv_sort = 'X'
    iv_call_shlt_exit = 'X'
    it_selopt = lt_selopt
  IMPORTING
    et_return_list = lt_result_list
    es_message = ls_message ).

*-------------------------------------------------------------
*  Map the Search Help returned results to the caller interface - Only mapped attributes
*-------------------------------------------------------------
IF ls_message IS NOT INITIAL.
* Call RFC call exception handling
  me->/iwbep/if_sb_dpc_comm_services~rfc_save_log(
    EXPORTING
      is_return      = ls_message
      iv_entity_type = iv_entity_name
      it_key_tab     = it_key_tab ).
ENDIF.

CLEAR et_entityset.

LOOP AT lt_result_list INTO ls_result_list
  WHERE record_number > ls_paging-skip.

  " Move SH results to GW request responce table
  lv_next = sy-tabix + 1. " next loop iteration
  CASE ls_result_list-field_name.
    WHEN 'BATXT'.
      ls_entityset-batxt = ls_result_list-field_value.
    WHEN 'BSART'.
      ls_entityset-bsart = ls_result_list-field_value.
  ENDCASE.

  " Check if the next line in the result list is a new record
  READ TABLE lt_result_list INTO ls_result_list_next INDEX lv_next.
  IF sy-subrc <> 0
  OR ls_result_list-record_number <> ls_result_list_next-record_number.
    " Save the collected SH result in the GW request table
    APPEND ls_entityset TO et_entityset.
    CLEAR: ls_result_list_next, ls_entityset.
  ENDIF.

ENDLOOP.

  endmethod.


  method BSARTSHSET_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'BSARTSHSET_UPDATE_ENTITY'.
  endmethod.


  method BUKRSSHSET_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'BUKRSSHSET_CREATE_ENTITY'.
  endmethod.


  method BUKRSSHSET_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'BUKRSSHSET_DELETE_ENTITY'.
  endmethod.


  method BUKRSSHSET_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'BUKRSSHSET_GET_ENTITY'.
  endmethod.


  method BUKRSSHSET_GET_ENTITYSET.
*-------------------------------------------------------------
*  Data declaration
*-------------------------------------------------------------
DATA lo_filter TYPE  REF TO /iwbep/if_mgw_req_filter.
DATA lt_filter_select_options TYPE /iwbep/t_mgw_select_option.
DATA lv_filter_str TYPE string.
DATA lv_MAX_HITS TYPE i.
DATA ls_paging TYPE /iwbep/s_mgw_paging.
DATA ls_converted_keys LIKE LINE OF et_entityset.
DATA ls_message TYPE bapiret2.
DATA lt_selopt TYPE ddshselops.
DATA ls_selopt LIKE LINE OF lt_selopt.
DATA ls_filter TYPE /iwbep/s_mgw_select_option.
DATA ls_filter_range TYPE /iwbep/s_cod_select_option.
DATA lr_BUTXT LIKE RANGE OF ls_converted_keys-butxt.
DATA ls_BUTXT LIKE LINE OF lr_BUTXT.
DATA lr_BUKRS LIKE RANGE OF ls_converted_keys-bukrs.
DATA ls_BUKRS LIKE LINE OF lr_BUKRS.
DATA lt_result_list TYPE /iwbep/if_sb_gendpc_shlp_data=>tt_result_list.
DATA lv_next TYPE i VALUE 1.
DATA ls_entityset LIKE LINE OF et_entityset.
DATA ls_result_list_next LIKE LINE OF lt_result_list.
DATA ls_result_list LIKE LINE OF lt_result_list.

*-------------------------------------------------------------
*  Map the runtime request to the Search Help select option - Only mapped attributes
*-------------------------------------------------------------
* Get all input information from the technical request context object
* Since DPC works with internal property names and runtime API interface holds external property names
* the process needs to get the all needed input information from the technical request context object
* Get filter or select option information
lo_filter = io_tech_request_context->get_filter( ).
lt_filter_select_options = lo_filter->get_filter_select_options( ).
lv_filter_str = lo_filter->get_filter_string( ).

* Check if the supplied filter is supported by standard gateway runtime process
IF  lv_filter_str            IS NOT INITIAL
AND lt_filter_select_options IS INITIAL.
  " If the string of the Filter System Query Option is not automatically converted into
  " filter option table (lt_filter_select_options), then the filtering combination is not supported
  " Log message in the application log
  me->/iwbep/if_sb_dpc_comm_services~log_message(
    EXPORTING
      iv_msg_type   = 'E'
      iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
      iv_msg_number = 025 ).
  " Raise Exception
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
    EXPORTING
      textid = /iwbep/cx_mgw_tech_exception=>internal_error.
ENDIF.

* Get key table information
io_tech_request_context->get_converted_source_keys(
  IMPORTING
    es_key_values  = ls_converted_keys ).

ls_paging-top = io_tech_request_context->get_top( ).
ls_paging-skip = io_tech_request_context->get_skip( ).

" Calculate the number of max hits to be fetched from the function module
" The lv_max_hits value is a summary of the Top and Skip values
IF ls_paging-top > 0.
  lv_max_hits = is_paging-top + is_paging-skip.
ENDIF.

* Maps filter table lines to the Search Help select option table
LOOP AT lt_filter_select_options INTO ls_filter.

  CASE ls_filter-property.
    WHEN 'BUTXT'.              " Equivalent to 'Butxt' property in the service
      lo_filter->convert_select_option(
        EXPORTING
          is_select_option = ls_filter
        IMPORTING
          et_select_option = lr_BUTXT ).

      LOOP AT lr_BUTXT INTO ls_BUTXT.
        ls_selopt-high = ls_BUTXT-high.
        ls_selopt-low = ls_BUTXT-low.
        ls_selopt-option = ls_BUTXT-option.
        ls_selopt-sign = ls_BUTXT-sign.
        ls_selopt-shlpfield = 'BUTXT'.
        ls_selopt-shlpname = '/ITETR/INV_SH_BUKRS'.
        APPEND ls_selopt TO lt_selopt.
        CLEAR ls_selopt.
      ENDLOOP.
    WHEN 'BUKRS'.              " Equivalent to 'Bukrs' property in the service
      lo_filter->convert_select_option(
        EXPORTING
          is_select_option = ls_filter
        IMPORTING
          et_select_option = lr_BUKRS ).

      LOOP AT lr_BUKRS INTO ls_BUKRS.
        ls_selopt-high = ls_BUKRS-high.
        ls_selopt-low = ls_BUKRS-low.
        ls_selopt-option = ls_BUKRS-option.
        ls_selopt-sign = ls_BUKRS-sign.
        ls_selopt-shlpfield = 'BUKRS'.
        ls_selopt-shlpname = '/ITETR/INV_SH_BUKRS'.
        APPEND ls_selopt TO lt_selopt.
        CLEAR ls_selopt.
      ENDLOOP.

    WHEN OTHERS.
      " Log message in the application log
      me->/iwbep/if_sb_dpc_comm_services~log_message(
        EXPORTING
          iv_msg_type   = 'E'
          iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
          iv_msg_number = 020
          iv_msg_v1     = ls_filter-property ).
      " Raise Exception
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
        EXPORTING
          textid = /iwbep/cx_mgw_tech_exception=>internal_error.
  ENDCASE.
ENDLOOP.

*-------------------------------------------------------------
*  Call to Search Help get values mechanism
*-------------------------------------------------------------
* Get search help values
me->/iwbep/if_sb_gendpc_shlp_data~get_search_help_values(
  EXPORTING
    iv_shlp_name = '/ITETR/INV_SH_BUKRS'
    iv_maxrows = lv_MAX_HITS
    iv_sort = 'X'
    iv_call_shlt_exit = 'X'
    it_selopt = lt_selopt
  IMPORTING
    et_return_list = lt_result_list
    es_message = ls_message ).

*-------------------------------------------------------------
*  Map the Search Help returned results to the caller interface - Only mapped attributes
*-------------------------------------------------------------
IF ls_message IS NOT INITIAL.
* Call RFC call exception handling
  me->/iwbep/if_sb_dpc_comm_services~rfc_save_log(
    EXPORTING
      is_return      = ls_message
      iv_entity_type = iv_entity_name
      it_key_tab     = it_key_tab ).
ENDIF.

CLEAR et_entityset.

LOOP AT lt_result_list INTO ls_result_list
  WHERE record_number > ls_paging-skip.

  " Move SH results to GW request responce table
  lv_next = sy-tabix + 1. " next loop iteration
  CASE ls_result_list-field_name.
    WHEN 'BUKRS'.
      ls_entityset-bukrs = ls_result_list-field_value.
    WHEN 'BUTXT'.
      ls_entityset-butxt = ls_result_list-field_value.
  ENDCASE.

  " Check if the next line in the result list is a new record
  READ TABLE lt_result_list INTO ls_result_list_next INDEX lv_next.
  IF sy-subrc <> 0
  OR ls_result_list-record_number <> ls_result_list_next-record_number.
    " Save the collected SH result in the GW request table
    APPEND ls_entityset TO et_entityset.
    CLEAR: ls_result_list_next, ls_entityset.
  ENDIF.

ENDLOOP.

  endmethod.


  method BUKRSSHSET_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'BUKRSSHSET_UPDATE_ENTITY'.
  endmethod.


  method CHECK_SUBSCRIPTION_AUTHORITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'CHECK_SUBSCRIPTION_AUTHORITY'.
  endmethod.


  method DOWNLOADFILESET_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'DOWNLOADFILESET_CREATE_ENTITY'.
  endmethod.


  method DOWNLOADFILESET_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'DOWNLOADFILESET_DELETE_ENTITY'.
  endmethod.


  method DOWNLOADFILESET_GET_ENTITY.
*-------------------------------------------------------------
*  Data declaration
*-------------------------------------------------------------
 DATA ev_doc_base64 TYPE string.
 DATA es_return TYPE /itetr/if_inc_download1=>bapiret2.
 DATA iv_bukrs TYPE /itetr/if_inc_download1=>bukrs.
 DATA iv_content_type TYPE /itetr/if_inc_download1=>/itetr/inc_de_conty.
 DATA iv_document_uid TYPE /itetr/if_inc_download1=>/itetr/inc_e_docui.
 DATA iv_duich TYPE /itetr/if_inc_download1=>/itetr/com_e_duich.
 DATA lv_rfc_name TYPE tfdir-funcname.
 DATA lv_destination TYPE rfcdest.
 DATA lv_subrc TYPE syst-subrc.
 DATA lv_exc_msg TYPE /iwbep/mgw_bop_rfc_excep_text.
 DATA lx_root TYPE REF TO cx_root.
 DATA ls_converted_keys LIKE er_entity.
 DATA lv_source_entity_set_name TYPE string.
 DATA lo_dp_facade TYPE REF TO /iwbep/if_mgw_dp_facade.

*-------------------------------------------------------------
*  Map the runtime request to the RFC - Only mapped attributes
*-------------------------------------------------------------
* Get all input information from the technical request context object
* Since DPC works with internal property names and runtime API interface holds external property names
* the process needs to get the all needed input information from the technical request context object
* Get key table information - for direct call
 io_tech_request_context->get_converted_keys(
   IMPORTING
     es_key_values = ls_converted_keys ).

* Maps key fields to function module parameters

 lv_source_entity_set_name = io_tech_request_context->get_source_entity_set_name( ).

 IF lv_source_entity_set_name = 'DownloadFileSet' AND
    lv_source_entity_set_name NE io_tech_request_context->get_entity_set_name( ).

   io_tech_request_context->get_converted_source_keys(
   IMPORTING es_key_values = ls_converted_keys ).

 ENDIF.

 iv_content_type = ls_converted_keys-iv_content_type.
 iv_document_uid = ls_converted_keys-iv_document_uid.
 iv_duich = ls_converted_keys-iv_duich.
 iv_bukrs = ls_converted_keys-iv_bukrs.
* Get RFC destination
 lo_dp_facade = /iwbep/if_mgw_conv_srv_runtime~get_dp_facade( ).
 lv_destination = /iwbep/cl_sb_gen_dpc_rt_util=>get_rfc_destination( io_dp_facade = lo_dp_facade ).

*-------------------------------------------------------------
*  Call RFC function module
*-------------------------------------------------------------
 lv_rfc_name = '/ITETR/INC_DOWNLOAD'.

 IF lv_destination IS INITIAL OR lv_destination EQ 'NONE'.

   TRY.
       CALL FUNCTION lv_rfc_name
         EXPORTING
           iv_duich        = iv_duich
           iv_document_uid = iv_document_uid
           iv_content_type = iv_content_type
           iv_bukrs        = iv_bukrs
         IMPORTING
           es_return       = es_return
           ev_doc_base64   = ev_doc_base64
         EXCEPTIONS
           system_failure  = 1000 message lv_exc_msg
           OTHERS          = 1002.

       lv_subrc = sy-subrc.
*in case of co-deployment the exception is raised and needs to be caught
     CATCH cx_root INTO lx_root.
       lv_subrc = 1001.
       lv_exc_msg = lx_root->if_message~get_text( ).
   ENDTRY.

 ELSE.

   CALL FUNCTION lv_rfc_name DESTINATION lv_destination
     EXPORTING
       iv_duich              = iv_duich
       iv_document_uid       = iv_document_uid
       iv_content_type       = iv_content_type
       iv_bukrs              = iv_bukrs
     IMPORTING
       es_return             = es_return
       ev_doc_base64         = ev_doc_base64
     EXCEPTIONS
       system_failure        = 1000 MESSAGE lv_exc_msg
       communication_failure = 1001 MESSAGE lv_exc_msg
       OTHERS                = 1002.

   lv_subrc = sy-subrc.

 ENDIF.

*-------------------------------------------------------------
*  Map the RFC response to the caller interface - Only mapped attributes
*-------------------------------------------------------------
*-------------------------------------------------------------
* Error and exception handling
*-------------------------------------------------------------
 IF lv_subrc <> 0.
* Execute the RFC exception handling process
   me->/iwbep/if_sb_dpc_comm_services~rfc_exception_handling(
     EXPORTING
       iv_subrc            = lv_subrc
       iv_exp_message_text = lv_exc_msg ).
 ENDIF.

 IF es_return IS NOT INITIAL.
* Call RFC call exception handling
   me->/iwbep/if_sb_dpc_comm_services~rfc_save_log(
     EXPORTING
       is_return      = es_return
       iv_entity_type = iv_entity_name
       it_key_tab     = it_key_tab ).
 ENDIF.

*-------------------------------------------------------------------------*
*             - Post Backend Call -
*-------------------------------------------------------------------------*
* Map properties from the backend to the Gateway output response structure

 er_entity-iv_content_type = iv_content_type.
 er_entity-iv_document_uid = iv_document_uid.
 er_entity-iv_duich = iv_duich.
 er_entity-iv_bukrs = iv_bukrs.
 er_entity-ev_doc_base64 = ev_doc_base64.
 er_entity-message_v4 = es_return-message_v4.
 er_entity-message_v3 = es_return-message_v3.
 er_entity-message_v2 = es_return-message_v2.
 er_entity-message_v1 = es_return-message_v1.
 er_entity-parameter = es_return-parameter.
 er_entity-log_no = es_return-log_no.
 er_entity-message = es_return-message.
 er_entity-number = es_return-number.
 er_entity-id = es_return-id.
 er_entity-type = es_return-type.
 er_entity-row = es_return-row.
 er_entity-field = es_return-field.
 er_entity-system = es_return-system.
 er_entity-log_msg_no = es_return-log_msg_no.
  endmethod.


  method DOWNLOADFILESET_GET_ENTITYSET.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'DOWNLOADFILESET_GET_ENTITYSET'.
  endmethod.


  method DOWNLOADFILESET_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'DOWNLOADFILESET_UPDATE_ENTITY'.
  endmethod.


  method INVOICEDETAILONE_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICEDETAILONE_CREATE_ENTITY'.
  endmethod.


  method INVOICEDETAILONE_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICEDETAILONE_DELETE_ENTITY'.
  endmethod.


  method INVOICEDETAILONE_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICEDETAILONE_GET_ENTITY'.
  endmethod.


  method INVOICEDETAILONE_GET_ENTITYSET.
*-------------------------------------------------------------
*  Data declaration
*-------------------------------------------------------------
 DATA iv_docui TYPE /itetr/if_inc_prepare_data=>/itetr/inc_e_docui.
 DATA et_t0002  TYPE /itetr/if_inc_prepare_data=>/itetr/inc_tt_t0002.
 DATA ls_et_t0002  TYPE LINE OF /itetr/if_inc_prepare_data=>/itetr/inc_tt_t0002.
 DATA lv_rfc_name TYPE tfdir-funcname.
 DATA lv_destination TYPE rfcdest.
 DATA lv_subrc TYPE syst-subrc.
 DATA lv_exc_msg TYPE /iwbep/mgw_bop_rfc_excep_text.
 DATA lx_root TYPE REF TO cx_root.
 DATA lo_filter TYPE  REF TO /iwbep/if_mgw_req_filter.
 DATA lt_filter_select_options TYPE /iwbep/t_mgw_select_option.
 DATA lv_filter_str TYPE string.
 DATA ls_paging TYPE /iwbep/s_mgw_paging.
 DATA ls_converted_keys LIKE LINE OF et_entityset.
 DATA ls_filter TYPE /iwbep/s_mgw_select_option.
 DATA ls_filter_range TYPE /iwbep/s_cod_select_option.
 DATA lr_IV_DOCUI LIKE RANGE OF ls_converted_keys-iv_docui.
 DATA ls_IV_DOCUI LIKE LINE OF lr_IV_DOCUI.
 DATA lo_dp_facade TYPE REF TO /iwbep/if_mgw_dp_facade.
 DATA ls_gw_et_t0002 LIKE LINE OF et_entityset.
 DATA lv_skip     TYPE int4.
 DATA lv_top      TYPE int4.

*-------------------------------------------------------------
*  Map the runtime request to the RFC - Only mapped attributes
*-------------------------------------------------------------
* Get all input information from the technical request context object
* Since DPC works with internal property names and runtime API interface holds external property names
* the process needs to get the all needed input information from the technical request context object
* Get filter or select option information
 lo_filter = io_tech_request_context->get_filter( ).
 lt_filter_select_options = lo_filter->get_filter_select_options( ).
 lv_filter_str = lo_filter->get_filter_string( ).

* Check if the supplied filter is supported by standard gateway runtime process
 IF  lv_filter_str            IS NOT INITIAL
 AND lt_filter_select_options IS INITIAL.
   " If the string of the Filter System Query Option is not automatically converted into
   " filter option table (lt_filter_select_options), then the filtering combination is not supported
   " Log message in the application log
   me->/iwbep/if_sb_dpc_comm_services~log_message(
     EXPORTING
       iv_msg_type   = 'E'
       iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
       iv_msg_number = 025 ).
   " Raise Exception
   RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
     EXPORTING
       textid = /iwbep/cx_mgw_tech_exception=>internal_error.
 ENDIF.

* Get key table information
 io_tech_request_context->get_converted_source_keys(
   IMPORTING
     es_key_values  = ls_converted_keys ).

 ls_paging-top = io_tech_request_context->get_top( ).
 ls_paging-skip = io_tech_request_context->get_skip( ).

* Maps filter table lines to function module parameters
 LOOP AT lt_filter_select_options INTO ls_filter.

   LOOP AT ls_filter-select_options INTO ls_filter_range.
     CASE ls_filter-property.
       WHEN 'IV_DOCUI'.
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_IV_DOCUI ).

         READ TABLE lr_IV_DOCUI INTO ls_IV_DOCUI INDEX 1.
         IF sy-subrc = 0.
           iv_docui = ls_IV_DOCUI-low.
         ENDIF.
       WHEN OTHERS.
         " Log message in the application log
         me->/iwbep/if_sb_dpc_comm_services~log_message(
           EXPORTING
             iv_msg_type   = 'E'
             iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
             iv_msg_number = 020
             iv_msg_v1     = ls_filter-property ).
         " Raise Exception
         RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
           EXPORTING
             textid = /iwbep/cx_mgw_tech_exception=>internal_error.
     ENDCASE.
   ENDLOOP.

 ENDLOOP.

* Get RFC destination
 lo_dp_facade = /iwbep/if_mgw_conv_srv_runtime~get_dp_facade( ).
 lv_destination = /iwbep/cl_sb_gen_dpc_rt_util=>get_rfc_destination( io_dp_facade = lo_dp_facade ).

*-------------------------------------------------------------
*  Call RFC function module
*-------------------------------------------------------------
 lv_rfc_name = '/ITETR/INC_PREPARE_DATA'.

 IF lv_destination IS INITIAL OR lv_destination EQ 'NONE'.

   TRY.
       CALL FUNCTION lv_rfc_name
         EXPORTING
           iv_docui       = iv_docui
         IMPORTING
           et_t0002       = et_t0002
         EXCEPTIONS
           system_failure = 1000 message lv_exc_msg
           OTHERS         = 1002.

       lv_subrc = sy-subrc.
*in case of co-deployment the exception is raised and needs to be caught
     CATCH cx_root INTO lx_root.
       lv_subrc = 1001.
       lv_exc_msg = lx_root->if_message~get_text( ).
   ENDTRY.

 ELSE.

   CALL FUNCTION lv_rfc_name DESTINATION lv_destination
     EXPORTING
       iv_docui              = iv_docui
     IMPORTING
       et_t0002              = et_t0002
     EXCEPTIONS
       system_failure        = 1000 MESSAGE lv_exc_msg
       communication_failure = 1001 MESSAGE lv_exc_msg
       OTHERS                = 1002.

   lv_subrc = sy-subrc.

 ENDIF.

*-------------------------------------------------------------
*  Map the RFC response to the caller interface - Only mapped attributes
*-------------------------------------------------------------
*-------------------------------------------------------------
* Error and exception handling
*-------------------------------------------------------------
 IF lv_subrc <> 0.
* Execute the RFC exception handling process
   me->/iwbep/if_sb_dpc_comm_services~rfc_exception_handling(
     EXPORTING
       iv_subrc            = lv_subrc
       iv_exp_message_text = lv_exc_msg ).
 ENDIF.

*-------------------------------------------------------------------------*
*             - Post Backend Call -
*-------------------------------------------------------------------------*
 IF ls_paging-skip IS NOT INITIAL.
*  If the Skip value was requested at runtime
*  the response table will provide backend entries from skip + 1, meaning start from skip +1
*  for example: skip=5 means to start get results from the 6th row
   lv_skip = ls_paging-skip + 1.
 ENDIF.
*  The Top value was requested at runtime but was not handled as part of the function interface
 IF  ls_paging-top <> 0
 AND lv_skip IS NOT INITIAL.
*  if lv_skip > 0 retrieve the entries from lv_skip + Top - 1
*  for example: skip=5 and top=2 means to start get results from the 6th row and end in row number 7
   lv_top = ls_paging-top + lv_skip - 1.
 ELSEIF ls_paging-top <> 0
 AND    lv_skip IS INITIAL.
   lv_top = ls_paging-top.
 ELSE.
   lv_top = lines( et_t0002 ).
 ENDIF.

*  - Map properties from the backend to the Gateway output response table -

 LOOP AT et_t0002 INTO ls_et_t0002
*  Provide the response entries according to the Top and Skip parameters that were provided at runtime
      FROM lv_skip TO lv_top.
*  Only fields that were mapped will be delivered to the response table
   ls_gw_et_t0002-mjahr = ls_et_t0002-mjahr.
   ls_gw_et_t0002-mblnr = ls_et_t0002-mblnr.
   ls_gw_et_t0002-despid = ls_et_t0002-despid.
   ls_gw_et_t0002-werks = ls_et_t0002-werks.
   ls_gw_et_t0002-brtwr = ls_et_t0002-brtwr.
   ls_gw_et_t0002-netwr = ls_et_t0002-netwr.
   ls_gw_et_t0002-rate = ls_et_t0002-rate.
   ls_gw_et_t0002-mwskz = ls_et_t0002-mwskz.
   ls_gw_et_t0002-anln1 = ls_et_t0002-anln1.
   ls_gw_et_t0002-sakto = ls_et_t0002-sakto.
   ls_gw_et_t0002-kostl = ls_et_t0002-kostl.
   ls_gw_et_t0002-meins = ls_et_t0002-meins.
   ls_gw_et_t0002-menge = ls_et_t0002-menge.
   ls_gw_et_t0002-txz01 = ls_et_t0002-txz01.
   ls_gw_et_t0002-matnr = ls_et_t0002-matnr.
   ls_gw_et_t0002-knttp = ls_et_t0002-knttp.
   ls_gw_et_t0002-ebelp = ls_et_t0002-ebelp.
   ls_gw_et_t0002-ebeln = ls_et_t0002-ebeln.
   ls_gw_et_t0002-line = ls_et_t0002-line.
   ls_gw_et_t0002-docui = ls_et_t0002-docui.
   ls_gw_et_t0002-smbln = ls_et_t0002-smbln.
   APPEND ls_gw_et_t0002 TO et_entityset.
   CLEAR ls_gw_et_t0002.
 ENDLOOP.

  endmethod.


  method INVOICEDETAILONE_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICEDETAILONE_UPDATE_ENTITY'.
  endmethod.


  method INVOICEDETAILTWO_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICEDETAILTWO_CREATE_ENTITY'.
  endmethod.


  method INVOICEDETAILTWO_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICEDETAILTWO_DELETE_ENTITY'.
  endmethod.


  method INVOICEDETAILTWO_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICEDETAILTWO_GET_ENTITY'.
  endmethod.


  method INVOICEDETAILTWO_GET_ENTITYSET.
*-------------------------------------------------------------
*  Data declaration
*-------------------------------------------------------------
 DATA iv_docui TYPE /itetr/if_inc_prepare_data=>/itetr/inc_e_docui.
 DATA et_t0003  TYPE /itetr/if_inc_prepare_data=>/itetr/inc_tt_t0003.
 DATA ls_et_t0003  TYPE LINE OF /itetr/if_inc_prepare_data=>/itetr/inc_tt_t0003.
 DATA lv_rfc_name TYPE tfdir-funcname.
 DATA lv_destination TYPE rfcdest.
 DATA lv_subrc TYPE syst-subrc.
 DATA lv_exc_msg TYPE /iwbep/mgw_bop_rfc_excep_text.
 DATA lx_root TYPE REF TO cx_root.
 DATA lo_filter TYPE  REF TO /iwbep/if_mgw_req_filter.
 DATA lt_filter_select_options TYPE /iwbep/t_mgw_select_option.
 DATA lv_filter_str TYPE string.
 DATA ls_paging TYPE /iwbep/s_mgw_paging.
 DATA ls_converted_keys LIKE LINE OF et_entityset.
 DATA ls_filter TYPE /iwbep/s_mgw_select_option.
 DATA ls_filter_range TYPE /iwbep/s_cod_select_option.
 DATA lr_IV_DOCUI LIKE RANGE OF ls_converted_keys-iv_docui.
 DATA ls_IV_DOCUI LIKE LINE OF lr_IV_DOCUI.
 DATA lo_dp_facade TYPE REF TO /iwbep/if_mgw_dp_facade.
 DATA ls_gw_et_t0003 LIKE LINE OF et_entityset.
 DATA lv_skip     TYPE int4.
 DATA lv_top      TYPE int4.

*-------------------------------------------------------------
*  Map the runtime request to the RFC - Only mapped attributes
*-------------------------------------------------------------
* Get all input information from the technical request context object
* Since DPC works with internal property names and runtime API interface holds external property names
* the process needs to get the all needed input information from the technical request context object
* Get filter or select option information
 lo_filter = io_tech_request_context->get_filter( ).
 lt_filter_select_options = lo_filter->get_filter_select_options( ).
 lv_filter_str = lo_filter->get_filter_string( ).

* Check if the supplied filter is supported by standard gateway runtime process
 IF  lv_filter_str            IS NOT INITIAL
 AND lt_filter_select_options IS INITIAL.
   " If the string of the Filter System Query Option is not automatically converted into
   " filter option table (lt_filter_select_options), then the filtering combination is not supported
   " Log message in the application log
   me->/iwbep/if_sb_dpc_comm_services~log_message(
     EXPORTING
       iv_msg_type   = 'E'
       iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
       iv_msg_number = 025 ).
   " Raise Exception
   RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
     EXPORTING
       textid = /iwbep/cx_mgw_tech_exception=>internal_error.
 ENDIF.

* Get key table information
 io_tech_request_context->get_converted_source_keys(
   IMPORTING
     es_key_values  = ls_converted_keys ).

 ls_paging-top = io_tech_request_context->get_top( ).
 ls_paging-skip = io_tech_request_context->get_skip( ).

* Maps filter table lines to function module parameters
 LOOP AT lt_filter_select_options INTO ls_filter.

   LOOP AT ls_filter-select_options INTO ls_filter_range.
     CASE ls_filter-property.
       WHEN 'IV_DOCUI'.
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_IV_DOCUI ).

         READ TABLE lr_IV_DOCUI INTO ls_IV_DOCUI INDEX 1.
         IF sy-subrc = 0.
           iv_docui = ls_IV_DOCUI-low.
         ENDIF.
       WHEN OTHERS.
         " Log message in the application log
         me->/iwbep/if_sb_dpc_comm_services~log_message(
           EXPORTING
             iv_msg_type   = 'E'
             iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
             iv_msg_number = 020
             iv_msg_v1     = ls_filter-property ).
         " Raise Exception
         RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
           EXPORTING
             textid = /iwbep/cx_mgw_tech_exception=>internal_error.
     ENDCASE.
   ENDLOOP.

 ENDLOOP.

* Get RFC destination
 lo_dp_facade = /iwbep/if_mgw_conv_srv_runtime~get_dp_facade( ).
 lv_destination = /iwbep/cl_sb_gen_dpc_rt_util=>get_rfc_destination( io_dp_facade = lo_dp_facade ).

*-------------------------------------------------------------
*  Call RFC function module
*-------------------------------------------------------------
 lv_rfc_name = '/ITETR/INC_PREPARE_DATA'.

 IF lv_destination IS INITIAL OR lv_destination EQ 'NONE'.

   TRY.
       CALL FUNCTION lv_rfc_name
         EXPORTING
           iv_docui       = iv_docui
         IMPORTING
           et_t0003       = et_t0003
         EXCEPTIONS
           system_failure = 1000 message lv_exc_msg
           OTHERS         = 1002.

       lv_subrc = sy-subrc.
*in case of co-deployment the exception is raised and needs to be caught
     CATCH cx_root INTO lx_root.
       lv_subrc = 1001.
       lv_exc_msg = lx_root->if_message~get_text( ).
   ENDTRY.

 ELSE.

   CALL FUNCTION lv_rfc_name DESTINATION lv_destination
     EXPORTING
       iv_docui              = iv_docui
     IMPORTING
       et_t0003              = et_t0003
     EXCEPTIONS
       system_failure        = 1000 MESSAGE lv_exc_msg
       communication_failure = 1001 MESSAGE lv_exc_msg
       OTHERS                = 1002.

   lv_subrc = sy-subrc.

 ENDIF.

*-------------------------------------------------------------
*  Map the RFC response to the caller interface - Only mapped attributes
*-------------------------------------------------------------
*-------------------------------------------------------------
* Error and exception handling
*-------------------------------------------------------------
 IF lv_subrc <> 0.
* Execute the RFC exception handling process
   me->/iwbep/if_sb_dpc_comm_services~rfc_exception_handling(
     EXPORTING
       iv_subrc            = lv_subrc
       iv_exp_message_text = lv_exc_msg ).
 ENDIF.

*-------------------------------------------------------------------------*
*             - Post Backend Call -
*-------------------------------------------------------------------------*
 IF ls_paging-skip IS NOT INITIAL.
*  If the Skip value was requested at runtime
*  the response table will provide backend entries from skip + 1, meaning start from skip +1
*  for example: skip=5 means to start get results from the 6th row
   lv_skip = ls_paging-skip + 1.
 ENDIF.
*  The Top value was requested at runtime but was not handled as part of the function interface
 IF  ls_paging-top <> 0
 AND lv_skip IS NOT INITIAL.
*  if lv_skip > 0 retrieve the entries from lv_skip + Top - 1
*  for example: skip=5 and top=2 means to start get results from the 6th row and end in row number 7
   lv_top = ls_paging-top + lv_skip - 1.
 ELSEIF ls_paging-top <> 0
 AND    lv_skip IS INITIAL.
   lv_top = ls_paging-top.
 ELSE.
   lv_top = lines( et_t0003 ).
 ENDIF.

*  - Map properties from the backend to the Gateway output response table -

 LOOP AT et_t0003 INTO ls_et_t0003
*  Provide the response entries according to the Top and Skip parameters that were provided at runtime
      FROM lv_skip TO lv_top.
*  Only fields that were mapped will be delivered to the response table
   ls_gw_et_t0003-ebeln = ls_et_t0003-ebeln.
   ls_gw_et_t0003-waers = ls_et_t0003-waers.
   ls_gw_et_t0003-exc_kdv = ls_et_t0003-exc_kdv.
   ls_gw_et_t0003-unit_price = ls_et_t0003-unit_price.
   ls_gw_et_t0003-lgobe = ls_et_t0003-lgobe.
   ls_gw_et_t0003-lgort = ls_et_t0003-lgort.
   ls_gw_et_t0003-name1 = ls_et_t0003-name1.
   ls_gw_et_t0003-werks = ls_et_t0003-werks.
   ls_gw_et_t0003-meins = ls_et_t0003-meins.
   ls_gw_et_t0003-stock_qty = ls_et_t0003-stock_qty.
   ls_gw_et_t0003-xblnr = ls_et_t0003-xblnr.
   ls_gw_et_t0003-zeile = ls_et_t0003-zeile.
   ls_gw_et_t0003-mjahr = ls_et_t0003-mjahr.
   ls_gw_et_t0003-mblnr = ls_et_t0003-mblnr.
   ls_gw_et_t0003-docui = ls_et_t0003-docui.
   ls_gw_et_t0003-ebelp = ls_et_t0003-ebelp.
   APPEND ls_gw_et_t0003 TO et_entityset.
   CLEAR ls_gw_et_t0003.
 ENDLOOP.

  endmethod.


  method INVOICEDETAILTWO_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICEDETAILTWO_UPDATE_ENTITY'.
  endmethod.


  method INVOICESET_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICESET_CREATE_ENTITY'.
  endmethod.


  method INVOICESET_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICESET_DELETE_ENTITY'.
  endmethod.


  method INVOICESET_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICESET_GET_ENTITY'.
  endmethod.


  method INVOICESET_GET_ENTITYSET.
*-------------------------------------------------------------
*  Data declaration
*-------------------------------------------------------------
 DATA iv_bukrs TYPE /itetr/if_inc_get_data1=>bukrs.
 DATA iv_field TYPE /itetr/if_inc_get_data1=>char1.
 DATA et_data  TYPE /itetr/if_inc_get_data1=>/itetr/inc_tt_t0001.
 DATA iv_bldat  TYPE /itetr/if_inc_get_data1=>/itetr/inc_tt_bldat.
 DATA iv_bsart  TYPE /itetr/if_inc_get_data1=>/itetr/inc_tt_bsart.
 DATA iv_gjahr  TYPE /itetr/if_inc_get_data1=>/itetr/inc_tt_gjahr.
 DATA iv_invno  TYPE /itetr/if_inc_get_data1=>/itetr/inc_tt_invno.
 DATA iv_lifnr  TYPE /itetr/if_inc_get_data1=>/itetr/inc_tt_lifnr.
 DATA iv_sappr  TYPE /itetr/if_inc_get_data1=>/itetr/inc_tt_sappr.
 DATA iv_taxid  TYPE /itetr/if_inc_get_data1=>/itetr/inc_tt_taxid.
 DATA ls_cells  TYPE LINE OF /itetr/if_inc_get_data1=>lvc_t_styl.
 DATA ls_et_data  TYPE LINE OF /itetr/if_inc_get_data1=>/itetr/inc_tt_t0001.
 DATA ls_iv_bldat  TYPE LINE OF /itetr/if_inc_get_data1=>/itetr/inc_tt_bldat.
 DATA ls_iv_bsart  TYPE LINE OF /itetr/if_inc_get_data1=>/itetr/inc_tt_bsart.
 DATA ls_iv_gjahr  TYPE LINE OF /itetr/if_inc_get_data1=>/itetr/inc_tt_gjahr.
 DATA ls_iv_invno  TYPE LINE OF /itetr/if_inc_get_data1=>/itetr/inc_tt_invno.
 DATA ls_iv_lifnr  TYPE LINE OF /itetr/if_inc_get_data1=>/itetr/inc_tt_lifnr.
 DATA ls_iv_sappr  TYPE LINE OF /itetr/if_inc_get_data1=>/itetr/inc_tt_sappr.
 DATA ls_iv_taxid  TYPE LINE OF /itetr/if_inc_get_data1=>/itetr/inc_tt_taxid.
 DATA lv_rfc_name TYPE tfdir-funcname.
 DATA lv_destination TYPE rfcdest.
 DATA lv_subrc TYPE syst-subrc.
 DATA lv_exc_msg TYPE /iwbep/mgw_bop_rfc_excep_text.
 DATA lx_root TYPE REF TO cx_root.
 DATA lo_filter TYPE  REF TO /iwbep/if_mgw_req_filter.
 DATA lt_filter_select_options TYPE /iwbep/t_mgw_select_option.
 DATA lv_filter_str TYPE string.
 DATA ls_paging TYPE /iwbep/s_mgw_paging.
 DATA ls_converted_keys LIKE LINE OF et_entityset.
 DATA ls_filter TYPE /iwbep/s_mgw_select_option.
 DATA ls_filter_range TYPE /iwbep/s_cod_select_option.
 DATA lr_BUKRS LIKE RANGE OF ls_converted_keys-bukrs.
 DATA ls_BUKRS LIKE LINE OF lr_BUKRS.
 DATA lr_IV_FIELD LIKE RANGE OF ls_converted_keys-iv_field.
 DATA ls_IV_FIELD LIKE LINE OF lr_IV_FIELD.
 DATA lr_BSART LIKE RANGE OF ls_converted_keys-bsart.
 DATA ls_BSART LIKE LINE OF lr_BSART.
 DATA lr_SAPPR LIKE RANGE OF ls_converted_keys-sappr.
 DATA ls_SAPPR LIKE LINE OF lr_SAPPR.
 DATA lr_LIFNR LIKE RANGE OF ls_converted_keys-lifnr.
 DATA ls_LIFNR LIKE LINE OF lr_LIFNR.
 DATA lr_GJAHR LIKE RANGE OF ls_converted_keys-gjahr.
 DATA ls_GJAHR LIKE LINE OF lr_GJAHR.
 DATA lr_BLDAT LIKE RANGE OF ls_converted_keys-bldat.
 DATA ls_BLDAT LIKE LINE OF lr_BLDAT.
 DATA lr_TAXID LIKE RANGE OF ls_converted_keys-taxid.
 DATA ls_TAXID LIKE LINE OF lr_TAXID.
 DATA lr_INVNO LIKE RANGE OF ls_converted_keys-invno.
 DATA ls_INVNO LIKE LINE OF lr_INVNO.
 DATA lo_dp_facade TYPE REF TO /iwbep/if_mgw_dp_facade.
 DATA ls_gw_et_data LIKE LINE OF et_entityset.
 DATA lv_skip     TYPE int4.
 DATA lv_top      TYPE int4.

*-------------------------------------------------------------
*  Map the runtime request to the RFC - Only mapped attributes
*-------------------------------------------------------------
* Get all input information from the technical request context object
* Since DPC works with internal property names and runtime API interface holds external property names
* the process needs to get the all needed input information from the technical request context object
* Get filter or select option information
 lo_filter = io_tech_request_context->get_filter( ).
 lt_filter_select_options = lo_filter->get_filter_select_options( ).
 lv_filter_str = lo_filter->get_filter_string( ).

* Check if the supplied filter is supported by standard gateway runtime process
 IF  lv_filter_str            IS NOT INITIAL
 AND lt_filter_select_options IS INITIAL.
   " If the string of the Filter System Query Option is not automatically converted into
   " filter option table (lt_filter_select_options), then the filtering combination is not supported
   " Log message in the application log
   me->/iwbep/if_sb_dpc_comm_services~log_message(
     EXPORTING
       iv_msg_type   = 'E'
       iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
       iv_msg_number = 025 ).
   " Raise Exception
   RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
     EXPORTING
       textid = /iwbep/cx_mgw_tech_exception=>internal_error.
 ENDIF.

* Get key table information
 io_tech_request_context->get_converted_source_keys(
   IMPORTING
     es_key_values  = ls_converted_keys ).

 ls_paging-top = io_tech_request_context->get_top( ).
 ls_paging-skip = io_tech_request_context->get_skip( ).

* Maps filter table lines to function module parameters
 LOOP AT lt_filter_select_options INTO ls_filter.

   LOOP AT ls_filter-select_options INTO ls_filter_range.
     CASE ls_filter-property.
       WHEN 'BUKRS'.
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_BUKRS ).

         READ TABLE lr_BUKRS INTO ls_BUKRS INDEX 1.
         IF sy-subrc = 0.
           iv_bukrs = ls_BUKRS-low.
         ENDIF.
       WHEN 'IV_FIELD'.
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_IV_FIELD ).

         READ TABLE lr_IV_FIELD INTO ls_IV_FIELD INDEX 1.
         IF sy-subrc = 0.
           iv_field = ls_IV_FIELD-low.
         ENDIF.
       WHEN 'BSART'.              " Equivalent to 'Bsart' property in the service
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_BSART ).

         LOOP AT lr_BSART INTO ls_BSART.
           ls_iv_bsart-high = ls_BSART-high.
           ls_iv_bsart-low = ls_BSART-low.
           ls_iv_bsart-option = ls_BSART-option.
           ls_iv_bsart-sign = ls_BSART-sign.
           APPEND ls_iv_bsart TO iv_bsart.
         ENDLOOP.
       WHEN 'SAPPR'.              " Equivalent to 'Sappr' property in the service
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_SAPPR ).

         LOOP AT lr_SAPPR INTO ls_SAPPR.
           ls_iv_sappr-high = ls_SAPPR-high.
           ls_iv_sappr-low = ls_SAPPR-low.
           ls_iv_sappr-option = ls_SAPPR-option.
           ls_iv_sappr-sign = ls_SAPPR-sign.
           APPEND ls_iv_sappr TO iv_sappr.
         ENDLOOP.
       WHEN 'LIFNR'.              " Equivalent to 'Lifnr' property in the service
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_LIFNR ).

         LOOP AT lr_LIFNR INTO ls_LIFNR.
           ls_iv_lifnr-high = ls_LIFNR-high.
           ls_iv_lifnr-low = ls_LIFNR-low.
           ls_iv_lifnr-option = ls_LIFNR-option.
           ls_iv_lifnr-sign = ls_LIFNR-sign.
           APPEND ls_iv_lifnr TO iv_lifnr.
         ENDLOOP.
       WHEN 'GJAHR'.              " Equivalent to 'Gjahr' property in the service
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_GJAHR ).

         LOOP AT lr_GJAHR INTO ls_GJAHR.
           ls_iv_gjahr-high = ls_GJAHR-high.
           ls_iv_gjahr-low = ls_GJAHR-low.
           ls_iv_gjahr-option = ls_GJAHR-option.
           ls_iv_gjahr-sign = ls_GJAHR-sign.
           APPEND ls_iv_gjahr TO iv_gjahr.
         ENDLOOP.
       WHEN 'BLDAT'.              " Equivalent to 'Bldat' property in the service
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_BLDAT ).

         LOOP AT lr_BLDAT INTO ls_BLDAT.
           ls_iv_bldat-high = ls_BLDAT-high.
           ls_iv_bldat-low = ls_BLDAT-low.
           ls_iv_bldat-option = ls_BLDAT-option.
           ls_iv_bldat-sign = ls_BLDAT-sign.
           APPEND ls_iv_bldat TO iv_bldat.
         ENDLOOP.
       WHEN 'TAXID'.              " Equivalent to 'Taxid' property in the service
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_TAXID ).

         LOOP AT lr_TAXID INTO ls_TAXID.
           ls_iv_taxid-high = ls_TAXID-high.
           ls_iv_taxid-low = ls_TAXID-low.
           ls_iv_taxid-option = ls_TAXID-option.
           ls_iv_taxid-sign = ls_TAXID-sign.
           APPEND ls_iv_taxid TO iv_taxid.
         ENDLOOP.
       WHEN 'INVNO'.              " Equivalent to 'Invno' property in the service
         lo_filter->convert_select_option(
           EXPORTING
             is_select_option = ls_filter
           IMPORTING
             et_select_option = lr_INVNO ).

         LOOP AT lr_INVNO INTO ls_INVNO.
           ls_iv_invno-high = ls_INVNO-high.
           ls_iv_invno-low = ls_INVNO-low.
           ls_iv_invno-option = ls_INVNO-option.
           ls_iv_invno-sign = ls_INVNO-sign.
           APPEND ls_iv_invno TO iv_invno.
         ENDLOOP.

       WHEN OTHERS.
         " Log message in the application log
         me->/iwbep/if_sb_dpc_comm_services~log_message(
           EXPORTING
             iv_msg_type   = 'E'
             iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
             iv_msg_number = 020
             iv_msg_v1     = ls_filter-property ).
         " Raise Exception
         RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
           EXPORTING
             textid = /iwbep/cx_mgw_tech_exception=>internal_error.
     ENDCASE.
   ENDLOOP.

 ENDLOOP.

* Get RFC destination
 lo_dp_facade = /iwbep/if_mgw_conv_srv_runtime~get_dp_facade( ).
 lv_destination = /iwbep/cl_sb_gen_dpc_rt_util=>get_rfc_destination( io_dp_facade = lo_dp_facade ).

*-------------------------------------------------------------
*  Call RFC function module
*-------------------------------------------------------------
 lv_rfc_name = '/ITETR/INC_GET_DATA'.

 IF lv_destination IS INITIAL OR lv_destination EQ 'NONE'.

   TRY.
       CALL FUNCTION lv_rfc_name
         EXPORTING
           iv_invno       = iv_invno
           iv_taxid       = iv_taxid
           iv_bldat       = iv_bldat
           iv_gjahr       = iv_gjahr
           iv_lifnr       = iv_lifnr
           iv_sappr       = iv_sappr
           iv_bukrs       = iv_bukrs
           iv_field       = iv_field
           iv_bsart       = iv_bsart
         IMPORTING
           et_data        = et_data
         EXCEPTIONS
           system_failure = 1000 message lv_exc_msg
           OTHERS         = 1002.

       lv_subrc = sy-subrc.
*in case of co-deployment the exception is raised and needs to be caught
     CATCH cx_root INTO lx_root.
       lv_subrc = 1001.
       lv_exc_msg = lx_root->if_message~get_text( ).
   ENDTRY.

 ELSE.

   CALL FUNCTION lv_rfc_name DESTINATION lv_destination
     EXPORTING
       iv_invno              = iv_invno
       iv_taxid              = iv_taxid
       iv_bldat              = iv_bldat
       iv_gjahr              = iv_gjahr
       iv_lifnr              = iv_lifnr
       iv_sappr              = iv_sappr
       iv_bukrs              = iv_bukrs
       iv_field              = iv_field
       iv_bsart              = iv_bsart
     IMPORTING
       et_data               = et_data
     EXCEPTIONS
       system_failure        = 1000 MESSAGE lv_exc_msg
       communication_failure = 1001 MESSAGE lv_exc_msg
       OTHERS                = 1002.

   lv_subrc = sy-subrc.

 ENDIF.

*-------------------------------------------------------------
*  Map the RFC response to the caller interface - Only mapped attributes
*-------------------------------------------------------------
*-------------------------------------------------------------
* Error and exception handling
*-------------------------------------------------------------
 IF lv_subrc <> 0.
* Execute the RFC exception handling process
   me->/iwbep/if_sb_dpc_comm_services~rfc_exception_handling(
     EXPORTING
       iv_subrc            = lv_subrc
       iv_exp_message_text = lv_exc_msg ).
 ENDIF.

*-------------------------------------------------------------------------*
*             - Post Backend Call -
*-------------------------------------------------------------------------*
 IF ls_paging-skip IS NOT INITIAL.
*  If the Skip value was requested at runtime
*  the response table will provide backend entries from skip + 1, meaning start from skip +1
*  for example: skip=5 means to start get results from the 6th row
   lv_skip = ls_paging-skip + 1.
 ENDIF.
*  The Top value was requested at runtime but was not handled as part of the function interface
 IF  ls_paging-top <> 0
 AND lv_skip IS NOT INITIAL.
*  if lv_skip > 0 retrieve the entries from lv_skip + Top - 1
*  for example: skip=5 and top=2 means to start get results from the 6th row and end in row number 7
   lv_top = ls_paging-top + lv_skip - 1.
 ELSEIF ls_paging-top <> 0
 AND    lv_skip IS INITIAL.
   lv_top = ls_paging-top.
 ELSE.
   lv_top = lines( et_data ).
 ENDIF.

*  - Map properties from the backend to the Gateway output response table -

 LOOP AT et_data INTO ls_et_data
*  Provide the response entries according to the Top and Skip parameters that were provided at runtime
      FROM lv_skip TO lv_top.
*  Only fields that were mapped will be delivered to the response table
   ls_gw_et_data-recdt = ls_et_data-recdt.
   ls_gw_et_data-dmbtr = ls_et_data-dmbtr.
   ls_gw_et_data-aliass = ls_et_data-aliass.
   ls_gw_et_data-bldat = ls_et_data-bldat.
   ls_gw_et_data-invqi = ls_et_data-invqi.
   ls_gw_et_data-taxid = ls_et_data-taxid.
   ls_gw_et_data-invno = ls_et_data-invno.
   ls_gw_et_data-invii = ls_et_data-invii.
   ls_gw_et_data-envui = ls_et_data-envui.
   ls_gw_et_data-invui = ls_et_data-invui.
   ls_gw_et_data-agent = ls_et_data-agent.
   ls_gw_et_data-bukrs = ls_et_data-bukrs.
   ls_gw_et_data-docui = ls_et_data-docui.
   ls_gw_et_data-belnr = ls_et_data-belnr.
   ls_gw_et_data-gjahr = ls_et_data-gjahr.
   ls_gw_et_data-archv = ls_et_data-archv.
   ls_gw_et_data-attex = ls_et_data-attex.
   ls_gw_et_data-lnote = ls_et_data-lnote.
   ls_gw_et_data-resst = ls_et_data-resst.
   ls_gw_et_data-radsc = ls_et_data-radsc.
   ls_gw_et_data-wrbtr = ls_et_data-wrbtr.
   ls_gw_et_data-despid = ls_et_data-despid.
   ls_gw_et_data-orderid = ls_et_data-orderid.
   ls_gw_et_data-withholding = ls_et_data-withholding.
   ls_gw_et_data-allowance = ls_et_data-allowance.
   ls_gw_et_data-lifnr = ls_et_data-lifnr.
   ls_gw_et_data-name1 = ls_et_data-name1.
   ls_gw_et_data-zterm = ls_et_data-zterm.
   ls_gw_et_data-sap_belnr = ls_et_data-sap_belnr.
   ls_gw_et_data-sap_gjahr = ls_et_data-sap_gjahr.
   ls_gw_et_data-staic = ls_et_data-staic.
   ls_gw_et_data-kursf = ls_et_data-kursf.
   ls_gw_et_data-xfield = ls_et_data-xfield.
   ls_gw_et_data-cusdn = ls_et_data-cusdn.
   ls_gw_et_data-ddtyp = ls_et_data-ddtyp.
   ls_gw_et_data-load_doc = ls_et_data-load_doc.
   ls_gw_et_data-bsart = ls_et_data-bsart.
   ls_gw_et_data-ctype = ls_et_data-ctype.
   ls_gw_et_data-sappr = ls_et_data-sappr.
   ls_gw_et_data-gappr = ls_et_data-gappr.
   ls_gw_et_data-difference_type = ls_et_data-difference_type.
   ls_gw_et_data-wf_status = ls_et_data-wf_status.
   ls_gw_et_data-waers = ls_et_data-waers.
   ls_gw_et_data-fwste = ls_et_data-fwste.
   ls_gw_et_data-invty = ls_et_data-invty.
   ls_gw_et_data-prfid = ls_et_data-prfid.
   ls_gw_et_data-aprvd = ls_et_data-aprvd.
   ls_gw_et_data-prntd = ls_et_data-prntd.
   ls_gw_et_data-procs = ls_et_data-procs.
   ls_gw_et_data-staex = ls_et_data-staex.
   ls_gw_et_data-staic_color = ls_et_data-staic_color.
   ls_gw_et_data-awtyp = ls_et_data-awtyp.
   APPEND ls_gw_et_data TO et_entityset.
   CLEAR ls_gw_et_data.
 ENDLOOP.

  endmethod.


  method INVOICESET_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'INVOICESET_UPDATE_ENTITY'.
  endmethod.


  method LIFNRSHSET_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'LIFNRSHSET_CREATE_ENTITY'.
  endmethod.


  method LIFNRSHSET_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'LIFNRSHSET_DELETE_ENTITY'.
  endmethod.


  method LIFNRSHSET_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'LIFNRSHSET_GET_ENTITY'.
  endmethod.


  method LIFNRSHSET_GET_ENTITYSET.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'LIFNRSHSET_GET_ENTITYSET'.
  endmethod.


  method LIFNRSHSET_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'LIFNRSHSET_UPDATE_ENTITY'.
  endmethod.


  method TAXIDSHSET_CREATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'TAXIDSHSET_CREATE_ENTITY'.
  endmethod.


  method TAXIDSHSET_DELETE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'TAXIDSHSET_DELETE_ENTITY'.
  endmethod.


  method TAXIDSHSET_GET_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'TAXIDSHSET_GET_ENTITY'.
  endmethod.


  method TAXIDSHSET_GET_ENTITYSET.
*-------------------------------------------------------------
*  Data declaration
*-------------------------------------------------------------
DATA lo_filter TYPE  REF TO /iwbep/if_mgw_req_filter.
DATA lt_filter_select_options TYPE /iwbep/t_mgw_select_option.
DATA lv_filter_str TYPE string.
DATA lv_MAX_HITS TYPE i.
DATA ls_paging TYPE /iwbep/s_mgw_paging.
DATA ls_converted_keys LIKE LINE OF et_entityset.
DATA ls_message TYPE bapiret2.
DATA lt_selopt TYPE ddshselops.
DATA ls_selopt LIKE LINE OF lt_selopt.
DATA ls_filter TYPE /iwbep/s_mgw_select_option.
DATA ls_filter_range TYPE /iwbep/s_cod_select_option.
DATA lr_NAME1 LIKE RANGE OF ls_converted_keys-name1.
DATA ls_NAME1 LIKE LINE OF lr_NAME1.
DATA lr_NAME2 LIKE RANGE OF ls_converted_keys-name2.
DATA ls_NAME2 LIKE LINE OF lr_NAME2.
DATA lr_LAND1 LIKE RANGE OF ls_converted_keys-land1.
DATA ls_LAND1 LIKE LINE OF lr_LAND1.
DATA lr_SORTL LIKE RANGE OF ls_converted_keys-sortl.
DATA ls_SORTL LIKE LINE OF lr_SORTL.
DATA lr_STCD2 LIKE RANGE OF ls_converted_keys-stcd2.
DATA ls_STCD2 LIKE LINE OF lr_STCD2.
DATA lt_result_list TYPE /iwbep/if_sb_gendpc_shlp_data=>tt_result_list.
DATA lv_next TYPE i VALUE 1.
DATA ls_entityset LIKE LINE OF et_entityset.
DATA ls_result_list_next LIKE LINE OF lt_result_list.
DATA ls_result_list LIKE LINE OF lt_result_list.

*-------------------------------------------------------------
*  Map the runtime request to the Search Help select option - Only mapped attributes
*-------------------------------------------------------------
* Get all input information from the technical request context object
* Since DPC works with internal property names and runtime API interface holds external property names
* the process needs to get the all needed input information from the technical request context object
* Get filter or select option information
lo_filter = io_tech_request_context->get_filter( ).
lt_filter_select_options = lo_filter->get_filter_select_options( ).
lv_filter_str = lo_filter->get_filter_string( ).

* Check if the supplied filter is supported by standard gateway runtime process
IF  lv_filter_str            IS NOT INITIAL
AND lt_filter_select_options IS INITIAL.
  " If the string of the Filter System Query Option is not automatically converted into
  " filter option table (lt_filter_select_options), then the filtering combination is not supported
  " Log message in the application log
  me->/iwbep/if_sb_dpc_comm_services~log_message(
    EXPORTING
      iv_msg_type   = 'E'
      iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
      iv_msg_number = 025 ).
  " Raise Exception
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
    EXPORTING
      textid = /iwbep/cx_mgw_tech_exception=>internal_error.
ENDIF.

* Get key table information
io_tech_request_context->get_converted_source_keys(
  IMPORTING
    es_key_values  = ls_converted_keys ).

ls_paging-top = io_tech_request_context->get_top( ).
ls_paging-skip = io_tech_request_context->get_skip( ).

" Calculate the number of max hits to be fetched from the function module
" The lv_max_hits value is a summary of the Top and Skip values
IF ls_paging-top > 0.
  lv_max_hits = is_paging-top + is_paging-skip.
ENDIF.

* Maps filter table lines to the Search Help select option table
LOOP AT lt_filter_select_options INTO ls_filter.

  CASE ls_filter-property.
    WHEN 'NAME1'.              " Equivalent to 'Name1' property in the service
      lo_filter->convert_select_option(
        EXPORTING
          is_select_option = ls_filter
        IMPORTING
          et_select_option = lr_NAME1 ).

      LOOP AT lr_NAME1 INTO ls_NAME1.
        ls_selopt-high = ls_NAME1-high.
        ls_selopt-low = ls_NAME1-low.
        ls_selopt-option = ls_NAME1-option.
        ls_selopt-sign = ls_NAME1-sign.
        ls_selopt-shlpfield = 'NAME1'.
        ls_selopt-shlpname = '/ITETR/INC_SH_STCD2'.
        APPEND ls_selopt TO lt_selopt.
        CLEAR ls_selopt.
      ENDLOOP.
    WHEN 'NAME2'.              " Equivalent to 'Name2' property in the service
      lo_filter->convert_select_option(
        EXPORTING
          is_select_option = ls_filter
        IMPORTING
          et_select_option = lr_NAME2 ).

      LOOP AT lr_NAME2 INTO ls_NAME2.
        ls_selopt-high = ls_NAME2-high.
        ls_selopt-low = ls_NAME2-low.
        ls_selopt-option = ls_NAME2-option.
        ls_selopt-sign = ls_NAME2-sign.
        ls_selopt-shlpfield = 'NAME2'.
        ls_selopt-shlpname = '/ITETR/INC_SH_STCD2'.
        APPEND ls_selopt TO lt_selopt.
        CLEAR ls_selopt.
      ENDLOOP.
    WHEN 'LAND1'.              " Equivalent to 'Land1' property in the service
      lo_filter->convert_select_option(
        EXPORTING
          is_select_option = ls_filter
        IMPORTING
          et_select_option = lr_LAND1 ).

      LOOP AT lr_LAND1 INTO ls_LAND1.
        ls_selopt-high = ls_LAND1-high.
        ls_selopt-low = ls_LAND1-low.
        ls_selopt-option = ls_LAND1-option.
        ls_selopt-sign = ls_LAND1-sign.
        ls_selopt-shlpfield = 'LAND1'.
        ls_selopt-shlpname = '/ITETR/INC_SH_STCD2'.
        APPEND ls_selopt TO lt_selopt.
        CLEAR ls_selopt.
      ENDLOOP.
    WHEN 'SORTL'.              " Equivalent to 'Sortl' property in the service
      lo_filter->convert_select_option(
        EXPORTING
          is_select_option = ls_filter
        IMPORTING
          et_select_option = lr_SORTL ).

      LOOP AT lr_SORTL INTO ls_SORTL.
        ls_selopt-high = ls_SORTL-high.
        ls_selopt-low = ls_SORTL-low.
        ls_selopt-option = ls_SORTL-option.
        ls_selopt-sign = ls_SORTL-sign.
        ls_selopt-shlpfield = 'SORTL'.
        ls_selopt-shlpname = '/ITETR/INC_SH_STCD2'.
        APPEND ls_selopt TO lt_selopt.
        CLEAR ls_selopt.
      ENDLOOP.
    WHEN 'STCD2'.              " Equivalent to 'Stcd2' property in the service
      lo_filter->convert_select_option(
        EXPORTING
          is_select_option = ls_filter
        IMPORTING
          et_select_option = lr_STCD2 ).

      LOOP AT lr_STCD2 INTO ls_STCD2.
        ls_selopt-high = ls_STCD2-high.
        ls_selopt-low = ls_STCD2-low.
        ls_selopt-option = ls_STCD2-option.
        ls_selopt-sign = ls_STCD2-sign.
        ls_selopt-shlpfield = 'STCD2'.
        ls_selopt-shlpname = '/ITETR/INC_SH_STCD2'.
        APPEND ls_selopt TO lt_selopt.
        CLEAR ls_selopt.
      ENDLOOP.

    WHEN OTHERS.
      " Log message in the application log
      me->/iwbep/if_sb_dpc_comm_services~log_message(
        EXPORTING
          iv_msg_type   = 'E'
          iv_msg_id     = '/IWBEP/MC_SB_DPC_ADM'
          iv_msg_number = 020
          iv_msg_v1     = ls_filter-property ).
      " Raise Exception
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
        EXPORTING
          textid = /iwbep/cx_mgw_tech_exception=>internal_error.
  ENDCASE.
ENDLOOP.

*-------------------------------------------------------------
*  Call to Search Help get values mechanism
*-------------------------------------------------------------
* Get search help values
me->/iwbep/if_sb_gendpc_shlp_data~get_search_help_values(
  EXPORTING
    iv_shlp_name = '/ITETR/INC_SH_STCD2'
    iv_maxrows = lv_MAX_HITS
    iv_sort = 'X'
    iv_call_shlt_exit = 'X'
    it_selopt = lt_selopt
  IMPORTING
    et_return_list = lt_result_list
    es_message = ls_message ).

*-------------------------------------------------------------
*  Map the Search Help returned results to the caller interface - Only mapped attributes
*-------------------------------------------------------------
IF ls_message IS NOT INITIAL.
* Call RFC call exception handling
  me->/iwbep/if_sb_dpc_comm_services~rfc_save_log(
    EXPORTING
      is_return      = ls_message
      iv_entity_type = iv_entity_name
      it_key_tab     = it_key_tab ).
ENDIF.

CLEAR et_entityset.

LOOP AT lt_result_list INTO ls_result_list
  WHERE record_number > ls_paging-skip.

  " Move SH results to GW request responce table
  lv_next = sy-tabix + 1. " next loop iteration
  CASE ls_result_list-field_name.
    WHEN 'LAND1'.
      ls_entityset-land1 = ls_result_list-field_value.
    WHEN 'NAME1'.
      ls_entityset-name1 = ls_result_list-field_value.
    WHEN 'NAME2'.
      ls_entityset-name2 = ls_result_list-field_value.
    WHEN 'SORTL'.
      ls_entityset-sortl = ls_result_list-field_value.
    WHEN 'STCD2'.
      ls_entityset-stcd2 = ls_result_list-field_value.
  ENDCASE.

  " Check if the next line in the result list is a new record
  READ TABLE lt_result_list INTO ls_result_list_next INDEX lv_next.
  IF sy-subrc <> 0
  OR ls_result_list-record_number <> ls_result_list_next-record_number.
    " Save the collected SH result in the GW request table
    APPEND ls_entityset TO et_entityset.
    CLEAR: ls_result_list_next, ls_entityset.
  ENDIF.

ENDLOOP.

  endmethod.


  method TAXIDSHSET_UPDATE_ENTITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'TAXIDSHSET_UPDATE_ENTITY'.
  endmethod.
ENDCLASS.