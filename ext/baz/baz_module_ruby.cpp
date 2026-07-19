// ext/baz/baz_module_ruby.cpp

///////////////////////////////////////////////////////////////////////////////
//
//  Definitions of Ruby bindings for Baz module methods.
//
///////////////////////////////////////////////////////////////////////////////

#include "baz_module_ruby.h"
#include "baz_vector_ruby.h"

// Baz is the module object
VALUE Baz = Qnil;

VALUE method_ext_test(VALUE self) {
  return INT2FIX( 3908 );
}

// Bind methods for example module
void init_baz_module() {
  Baz  = rb_define_module("Baz");
  // (VALUE(*)(ANYARGS))  is effectively  (unsigned long(*)(...)) or similar, and required
  // because C++ won't compile using a NULL pointer as a method.
  rb_define_singleton_method( Baz, "ext_test", (VALUE(*)(ANYARGS))method_ext_test, 0 );

  // Builds Ruby class Baz::Vector (function definition in baz_vector_ruby.cpp)
  init_baz_vector( Baz );
}
