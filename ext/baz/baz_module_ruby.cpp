// ext/baz/baz_module_ruby.cpp

#include "baz_module_ruby.h"

// Baz is the module object
VALUE Baz = Qnil;

VALUE method_ext_test(VALUE self) {
  return INT2FIX( 3908 );
}

// Bind methods for example module
void init_baz_module() {
  Baz  = rb_define_module("Baz");
  rb_define_singleton_method( Baz, "ext_test", (VALUE(*)(ANYARGS))method_ext_test, 0 );
}
