// ext/baz/baz_vector_ruby.cpp

#include "baz_vector_ruby.h"

// Memory management

BVector *rb_create_bvector() {
    return new BVector();
}

void rb_delete_bvector( BVector *p_bvector ) {
    delete p_bvector;
    return;
}

// TODO: Object clone

// Ruby low-level integration

VALUE BazVector = Qnil;

inline VALUE bvector_as_ruby_class( BVector *p_bvector , VALUE klass ) {
  return Data_Wrap_Struct( klass, 0, rb_delete_bvector, p_bvector );
}

VALUE bv_alloc(VALUE klass) {
  return bvector_as_ruby_class( rb_create_bvector(), klass );
}

inline BVector *get_bvector( VALUE obj ) {
  BVector *p_bvector;
  Data_Get_Struct( obj, BVector, p_bvector );
  return p_bvector;
}

void assert_value_wraps_bvector( VALUE obj ) {
  if ( TYPE(obj) != T_DATA ||
      RDATA(obj)->dfree != (RUBY_DATA_FUNC)rb_delete_bvector) {
    rb_raise( rb_eTypeError, "Expected a Baz::Vector object, but got something else" );
  }
}

/*
 * Functions that can be bound to a Ruby class
 *
*/

// Native extensions version of initialize
extern "C" VALUE baz_vector_initialize( VALUE self, VALUE init_x, VALUE init_y ) {
  BVector *p_bvector = get_bvector( self );

  p_bvector->set_xy( NUM2DBL( init_x ), NUM2DBL( init_y ) );

  return self;
}

// Example of using a "native" struct method
extern "C" VALUE baz_vector_magnitude( VALUE self ) {
  BVector *p_bvector = get_bvector( self );
  return DBL2NUM( p_bvector->magnitude() );
}

/*
 * Create bindings, should be called as part of library initialisation
 *
*/

void init_baz_vector( VALUE parent_module ) {
  BazVector = rb_define_class_under( parent_module, "Vector", rb_cObject );
  rb_define_alloc_func( BazVector, bv_alloc );
  rb_define_method( BazVector, "initialize", (VALUE(*)(ANYARGS))baz_vector_initialize, 2 );
  rb_define_method( BazVector, "magnitude", (VALUE(*)(ANYARGS))baz_vector_magnitude, 0 );
}
