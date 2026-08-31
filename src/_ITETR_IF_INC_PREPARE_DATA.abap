interface /ITETR/IF_INC_PREPARE_DATA
  public .


  types:
    MANDT type C length 000003 .
  types:
    /ITETR/INC_E_DOCUI type C length 000032 .
  types:
    EBELN type C length 000010 .
  types:
    EBELP type N length 000005 .
  types:
    KNTTP type C length 000001 .
  types:
    MATNR type C length 000040 .
  types:
    TXZ01 type C length 000040 .
  types:
    BSTMG type P length 7  decimals 000003 .
  types:
    BSTME type C length 000003 .
  types:
    KOSTL type C length 000010 .
  types:
    SAKNR type C length 000010 .
  types:
    ANLN1 type C length 000012 .
  types:
    MWSKZ type C length 000002 .
  types:
    /ITETR/COM_E_RATE type P length 6  decimals 000002 .
  types:
    BWERT type P length 7  decimals 000002 .
  types:
    BBWERT type P length 7  decimals 000002 .
  types:
    WERKS_D type C length 000004 .
  types:
    XBLNR1 type C length 000016 .
  types:
    MBLNR type C length 000010 .
  types:
    MJAHR type N length 000004 .
  types:
    begin of /ITETR/INC_T0002,
      MANDT type MANDT,
      DOCUI type /ITETR/INC_E_DOCUI,
      LINE type INT4,
      EBELN type EBELN,
      EBELP type EBELP,
      KNTTP type KNTTP,
      MATNR type MATNR,
      TXZ01 type TXZ01,
      MENGE type BSTMG,
      MEINS type BSTME,
      KOSTL type KOSTL,
      SAKTO type SAKNR,
      ANLN1 type ANLN1,
      MWSKZ type MWSKZ,
      RATE type /ITETR/COM_E_RATE,
      NETWR type BWERT,
      BRTWR type BBWERT,
      WERKS type WERKS_D,
      DESPID type XBLNR1,
      MBLNR type MBLNR,
      MJAHR type MJAHR,
      SMBLN type MBLNR,
    end of /ITETR/INC_T0002 .
  types:
    /ITETR/INC_TT_T0002            type standard table of /ITETR/INC_T0002               with non-unique default key .
  types:
    MBLPO type N length 000004 .
  types:
    NSDM_STOCK_QTY type P length 16  decimals 000014 .
  types:
    MEINS type C length 000003 .
  types:
    NAME1 type C length 000030 .
  types:
    LGORT_D type C length 000004 .
  types:
    LGOBE type C length 000016 .
  types:
    DMBTR type P length 12  decimals 000002 .
  types:
    WAERS type C length 000005 .
  types:
    begin of /ITETR/INC_T0003,
      MANDT type MANDT,
      DOCUI type /ITETR/INC_E_DOCUI,
      MBLNR type MBLNR,
      MJAHR type MJAHR,
      ZEILE type MBLPO,
      XBLNR type XBLNR1,
      STOCK_QTY type NSDM_STOCK_QTY,
      MEINS type MEINS,
      WERKS type WERKS_D,
      NAME1 type NAME1,
      LGORT type LGORT_D,
      LGOBE type LGOBE,
      EXC_KDV type DMBTR,
      UNIT_PRICE type DMBTR,
      WAERS type WAERS,
      EBELN type EBELN,
      EBELP type EBELP,
    end of /ITETR/INC_T0003 .
  types:
    begin of /ITETR/INC_S0003.
    include type /ITETR/INC_T0003.
    types:
    end of /ITETR/INC_S0003 .
  types:
    /ITETR/INC_TT_T0003            type standard table of /ITETR/INC_S0003               with non-unique default key .
endinterface.