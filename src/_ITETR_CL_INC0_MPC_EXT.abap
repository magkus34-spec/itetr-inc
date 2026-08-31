class /ITETR/CL_INC0_MPC_EXT definition
  public
  inheriting from /ITETR/CL_INC0_MPC
  create public .

public section.

  methods DEFINE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /ITETR/CL_INC0_MPC_EXT IMPLEMENTATION.


    method DEFINE.

     DATA: lo_entity_type TYPE REF TO /iwbep/if_mgw_odata_entity_typ,
           lo_property    TYPE REF TO /iwbep/cl_mgw_odata_property,
           lo_annotation  TYPE REF TO /iwbep/if_mgw_odata_annotation.

    super->define( ). "Ensure you call the parent metadata

    DATA(property)   = model->get_entity_type('Invoice')->get_property('Bldat').
    DATA(annotation) = property->/iwbep/if_mgw_odata_annotatabl~create_annotation( /iwbep/if_mgw_med_odata_types=>gc_sap_namespace ).
    annotation->add( iv_key = 'display-format' iv_value = 'Date' ).
    annotation->add( iv_key = 'filter-restriction' iv_value = 'interval').

    "model->get_entity_type('Invoices')->get_property('Docui')->disable_conversion( ).

  endmethod.
ENDCLASS.