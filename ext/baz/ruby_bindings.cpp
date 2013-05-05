// ext/baz/ruby_bindings.cpp

#include "ruby_bindings.h"

// Baz is the module object
VALUE Baz = Qnil;

VALUE method_ext_test(VALUE self) {
  return INT2FIX( 3908 );
}

// Bind methods for example module
void init_ruby_module_ruby_native_cpp() {
  Baz  = rb_define_module("Baz");
  rb_define_singleton_method( Baz, "ext_test", (VALUE(*)(ANYARGS))method_ext_test, 0 );
}
