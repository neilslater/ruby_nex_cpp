// ext/baz/baz_vector_ruby.cpp

///////////////////////////////////////////////////////////////////////////////
//
//  Definitions for Ruby wrappers to BVector class
//
///////////////////////////////////////////////////////////////////////////////

#include "baz_vector_ruby.h"

///////////////////////////////////////////////////////////////////////////////
//
// Memory management. TODO: Check best practice for this.
//

BVector *rb_create_bvector() {
    return new BVector();
}

void rb_delete_bvector( BVector *p_bvector ) {
    delete p_bvector;
    return;
}

///////////////////////////////////////////////////////////////////////////////
//
// Low-level Ruby integration
//

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

///////////////////////////////////////////////////////////////////////////////
//
// Ruby methods exposed in the class API
//

// Native extensions version of initialize
VALUE baz_vector_initialize( VALUE self, VALUE init_x, VALUE init_y ) {
  BVector *p_bvector = get_bvector( self );

  p_bvector->set_xy( NUM2DBL( init_x ), NUM2DBL( init_y ) );

  return self;
}

// Native extensions version of clone
VALUE baz_vector_initialize_copy( VALUE copy, VALUE orig ) {
  BVector *bv_copy;
  BVector *bv_orig;

  if (copy == orig) return copy;
  bv_copy = get_bvector( copy );
  bv_orig = get_bvector( orig );
  memcpy( bv_copy, bv_orig, sizeof(BVector) );

  return copy;
}

// Example of using a "native" struct method
VALUE baz_vector_magnitude( VALUE self ) {
  BVector *p_bvector = get_bvector( self );
  return DBL2NUM( p_bvector->magnitude() );
}

///////////////////////////////////////////////////////////////////////////////
//
// Build Ruby class <Namespace>::Vector
//

void init_baz_vector( VALUE parent_module ) {
  BazVector = rb_define_class_under( parent_module, "Vector", rb_cObject );
  rb_define_alloc_func( BazVector, bv_alloc );
  rb_define_method( BazVector, "initialize", (VALUE(*)(ANYARGS))baz_vector_initialize, 2 );
  rb_define_method( BazVector, "initialize_copy", (VALUE(*)(ANYARGS))baz_vector_initialize_copy, 1 );
  rb_define_method( BazVector, "magnitude", (VALUE(*)(ANYARGS))baz_vector_magnitude, 0 );
}
