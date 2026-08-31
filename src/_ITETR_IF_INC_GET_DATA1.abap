interface /ITETR/IF_INC_GET_DATA1
  public .


  types:
    MANDT type C length 000003 .
  types:
    /ITETR/INC_E_DOCUI type C length 000032 .
  types:
    BUKRS type C length 000004 .
  types:
    /ITETR/COM_E_AGENT type C length 000010 .
  types:
    /ITETR/COM_E_ENVUI type C length 000036 .
  types:
    /ITETR/COM_E_DUICH type C length 000036 .
  types:
    /ITETR/COM_E_DOCNO type C length 000016 .
  types:
    /ITETR/COM_E_DOCII type C length 000050 .
  types:
    /ITETR/COM_E_DOCQI type C length 000050 .
  types:
    STCD2 type C length 000011 .
  types:
    /ITETR/COM_E_ALIAS type C length 000100 .
  types:
    /ITETR/COM_E_DMBTR type P length 7  decimals 000002 .
  types:
    /ITETR/COM_E_WRBTR type P length 7  decimals 000002 .
  types:
    /ITETR/COM_E_FWSTE type P length 7  decimals 000002 .
  types:
    WAERS type C length 000005 .
  types:
    /ITETR/INC_DE_PRFID type C length 000020 .
  types:
    /ITETR/INC_DE_INVTY type C length 000020 .
  types:
    /ITETR/COM_E_PRINT type C length 000001 .
  types:
    /ITETR/COM_E_APRVD type C length 000001 .
  types:
    /ITETR/COM_E_PROCS type C length 000001 .
  types:
    AWTYP type C length 000005 .
  types:
    BELNR_D type C length 000010 .
  types:
    GJAHR type N length 000004 .
  types:
    /ITETR/COM_E_ARCHV type C length 000001 .
  types:
    /ITETR/COM_E_ATTEX type C length 000001 .
  types:
    /ITETR/COM_E_LNOTE type C length 000255 .
  types:
    /ITETR/INC_DE_RESST type C length 000001 .
  types:
    /ITETR/COM_E_RADSC type C length 000004 .
  types:
    /ITETR/COM_E_STAEX type C length 000255 .
  types:
    /ITETR/COM_E_DESNO type C length 000016 .
  types:
    /ITETR/COM_E_ORDERID type C length 000255 .
  types:
    /ITETR/COM_E_WITHHOLDING type P length 7  decimals 000002 .
  types:
    /ITETR/COM_E_ALLOWANCE type P length 7  decimals 000002 .
  types:
    LIFNR type C length 000010 .
  types:
    NAME1 type C length 000030 .
  types:
    /ITETR/INC_E_ITYPE type C length 000030 .
  types:
    /ITETR/INC_E_IERR type C length 000100 .
  types:
    CHAR4 type C length 000004 .
  types:
    /ITETR/COM_E_STAIC type C length 000004 .
  types:
    KURSF type P length 5  decimals 000005 .
  types:
    /ITETR/INC_FIELD type C length 000001 .
  types:
    /ITETR/INC_E_CUSDN type C length 000040 .
  types:
    /ITETR/INC_E_DDTYP type C length 000001 .
  types:
    /ITETR/INC_E_LODOC type C length 000010 .
  types:
    ESART type C length 000004 .
  types:
    /ITETR/INC_E_CTYPE_MULTIPLE type C length 000020 .
  types:
    /ITETR/INC_DE_0001 type C length 000010 .
  types:
    /ITETR/INC_DE_0002 type C length 000001 .
  types:
    /ITETR/INC_DE_DIFFERENCE_TYPE type C length 000010 .
  types:
    /ITETR/INC_DE_WF_STATUS type C length 000010 .
  types:
    CHAR1 type C length 000001 .
  types:
    EKGRP type C length 000003 .
  types:
    LFART type C length 000004 .
  types:
    begin of /ITETR/INC_T0001,
      MANDT type MANDT,
      DOCUI type /ITETR/INC_E_DOCUI,
      BUKRS type BUKRS,
      AGENT type /ITETR/COM_E_AGENT,
      ENVUI type /ITETR/COM_E_ENVUI,
      INVUI type /ITETR/COM_E_DUICH,
      INVNO type /ITETR/COM_E_DOCNO,
      INVII type /ITETR/COM_E_DOCII,
      INVQI type /ITETR/COM_E_DOCQI,
      TAXID type STCD2,
      ALIASS type /ITETR/COM_E_ALIAS,
      BLDAT type DATS,
      RECDT type DATS,
      DMBTR type /ITETR/COM_E_DMBTR,
      WRBTR type /ITETR/COM_E_WRBTR,
      FWSTE type /ITETR/COM_E_FWSTE,
      WAERS type WAERS,
      PRFID type /ITETR/INC_DE_PRFID,
      INVTY type /ITETR/INC_DE_INVTY,
      PRNTD type /ITETR/COM_E_PRINT,
      APRVD type /ITETR/COM_E_APRVD,
      PROCS type /ITETR/COM_E_PROCS,
      AWTYP type AWTYP,
      BELNR type BELNR_D,
      GJAHR type GJAHR,
      ARCHV type /ITETR/COM_E_ARCHV,
      ATTEX type /ITETR/COM_E_ATTEX,
      LNOTE type /ITETR/COM_E_LNOTE,
      RESST type /ITETR/INC_DE_RESST,
      RADSC type /ITETR/COM_E_RADSC,
      STAEX type /ITETR/COM_E_STAEX,
      DESPID type /ITETR/COM_E_DESNO,
      ORDERID type /ITETR/COM_E_ORDERID,
      WITHHOLDING type /ITETR/COM_E_WITHHOLDING,
      ALLOWANCE type /ITETR/COM_E_ALLOWANCE,
      LIFNR type LIFNR,
      NAME1 type NAME1,
      INVOICE_TYPE type /ITETR/INC_E_ITYPE,
      INVOICE_ERR type /ITETR/INC_E_IERR,
      ZTERM type CHAR4,
      SAP_BELNR type BELNR_D,
      SAP_GJAHR type GJAHR,
      STAIC type /ITETR/COM_E_STAIC,
      KURSF type KURSF,
      XFIELD type /ITETR/INC_FIELD,
      CUSDN type /ITETR/INC_E_CUSDN,
      DDTYP type /ITETR/INC_E_DDTYP,
      LOAD_DOC type /ITETR/INC_E_LODOC,
      BSART type ESART,
      CTYPE type /ITETR/INC_E_CTYPE_MULTIPLE,
      SAPPR type /ITETR/INC_DE_0001,
      GAPPR type /ITETR/INC_DE_0002,
      DIFFERENCE_TYPE type /ITETR/INC_DE_DIFFERENCE_TYPE,
      WF_STATUS type /ITETR/INC_DE_WF_STATUS,
      STAIC_COLOR type CHAR1,
      EKGRP type EKGRP,
      LFART type LFART,
    end of /ITETR/INC_T0001 .
  types:
    LVC_FNAME type C length 000030 .
  types:
    LVC_STYLE type X length 000004 .
  types:
    begin of LVC_S_STYL,
      FIELDNAME type LVC_FNAME,
      STYLE type LVC_STYLE,
      STYLE2 type LVC_STYLE,
      STYLE3 type LVC_STYLE,
      STYLE4 type LVC_STYLE,
      MAXLEN type INT4,
    end of LVC_S_STYL .
  types:
    LVC_T_STYL                     type standard table of LVC_S_STYL                     with non-unique default key .
  types:
    begin of /ITETR/INC_S0001.
    include type /ITETR/INC_T0001.
    types:
      CELLS type LVC_T_STYL,
    end of /ITETR/INC_S0001 .
  types:
    /ITETR/INC_TT_T0001            type standard table of /ITETR/INC_S0001               with non-unique default key .
  types:
    DDSIGN type C length 000001 .
  types:
    DDOPTION type C length 000002 .
  types:
    begin of /ITETR/INC_S_BLDAT,
      SIGN type DDSIGN,
      OPTION type DDOPTION,
      LOW type DATS,
      HIGH type DATS,
    end of /ITETR/INC_S_BLDAT .
  types:
    /ITETR/INC_TT_BLDAT            type standard table of /ITETR/INC_S_BLDAT             with non-unique default key .
  types:
    BSART type C length 000004 .
  types:
    begin of /ITETR/INC_S_BSART,
      SIGN type DDSIGN,
      OPTION type DDOPTION,
      LOW type BSART,
      HIGH type BSART,
    end of /ITETR/INC_S_BSART .
  types:
    /ITETR/INC_TT_BSART            type standard table of /ITETR/INC_S_BSART             with non-unique default key .
  types:
    begin of /ITETR/INC_S_EKGRP,
      SIGN type DDSIGN,
      OPTION type DDOPTION,
      LOW type EKGRP,
      HIGH type EKGRP,
    end of /ITETR/INC_S_EKGRP .
  types:
    /ITETR/INC_TT_EKGRP            type standard table of /ITETR/INC_S_EKGRP             with non-unique default key .
  types:
    begin of /ITETR/INC_S_GJAHR,
      SIGN type DDSIGN,
      OPTION type DDOPTION,
      LOW type GJAHR,
      HIGH type GJAHR,
    end of /ITETR/INC_S_GJAHR .
  types:
    /ITETR/INC_TT_GJAHR            type standard table of /ITETR/INC_S_GJAHR             with non-unique default key .
  types:
    begin of /ITETR/INC_S_INVNO,
      SIGN type DDSIGN,
      OPTION type DDOPTION,
      LOW type /ITETR/COM_E_DOCNO,
      HIGH type /ITETR/COM_E_DOCNO,
    end of /ITETR/INC_S_INVNO .
  types:
    /ITETR/INC_TT_INVNO            type standard table of /ITETR/INC_S_INVNO             with non-unique default key .
  types:
    begin of /ITETR/INC_S_LIFNR,
      SIGN type DDSIGN,
      OPTION type DDOPTION,
      LOW type LIFNR,
      HIGH type LIFNR,
    end of /ITETR/INC_S_LIFNR .
  types:
    /ITETR/INC_TT_LIFNR            type standard table of /ITETR/INC_S_LIFNR             with non-unique default key .
  types:
    CHAR10 type C length 000010 .
  types:
    begin of /ITETR/INC_S_SAPPR,
      SIGN type DDSIGN,
      OPTION type DDOPTION,
      LOW type CHAR10,
      HIGH type CHAR10,
    end of /ITETR/INC_S_SAPPR .
  types:
    /ITETR/INC_TT_SAPPR            type standard table of /ITETR/INC_S_SAPPR             with non-unique default key .
  types:
    begin of /ITETR/INC_S_TAXID,
      SIGN type DDSIGN,
      OPTION type DDOPTION,
      LOW type STCD2,
      HIGH type STCD2,
    end of /ITETR/INC_S_TAXID .
  types:
    /ITETR/INC_TT_TAXID            type standard table of /ITETR/INC_S_TAXID             with non-unique default key .
endinterface.