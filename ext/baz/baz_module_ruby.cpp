// ext/baz/baz_module_ruby.cpp

///////////////////////////////////////////////////////////////////////////////
//
//  Definitions of Ruby bindings for Baz module methods.
//
///////////////////////////////////////////////////////////////////////////////

#include "baz_module_ruby.h"
#include "baz_vector_ruby.h"

// Baz is the module object
static VALUE baz_module = Qnil;

static VALUE method_ext_test(VALUE self) {
  (void)self;
  return INT2NUM(3908);
}

// Bind methods for example module
void init_baz_module(void) {
  baz_module = rb_define_module("Baz");
  rb_define_singleton_method(baz_module, "ext_test", RUBY_METHOD_FUNC(method_ext_test), 0);

  // Builds Ruby class Baz::Vector (function definition in baz_vector_ruby.cpp)
  init_baz_vector(baz_module);
}
