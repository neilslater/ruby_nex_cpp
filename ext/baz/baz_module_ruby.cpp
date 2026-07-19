// ext/baz/baz_module_ruby.cpp

///////////////////////////////////////////////////////////////////////////////
//
//  Definitions of Ruby bindings for Baz module methods.
//
///////////////////////////////////////////////////////////////////////////////

#include "baz_module_ruby.h"
#include "baz_vector_ruby.h"

// VALUE is Ruby's handle type. Keeping this file-local handle lets later
// setup calls refer to the Ruby Baz module.
static VALUE baz_module = Qnil;

// Every exposed Ruby method receives its receiver as the first argument.
static VALUE method_ext_test(VALUE self) {
  // This method does not use its receiver; the cast avoids a compiler warning.
  (void)self;
  // Convert the native integer into a Ruby Integer before returning it.
  return INT2NUM(3908);
}

// Bind methods for example module
void init_baz_module(void) {
  baz_module = rb_define_module("Baz");
  // RUBY_METHOD_FUNC adapts the callback to Ruby's generic function type; the
  // final zero declares that the Ruby method accepts no explicit arguments.
  rb_define_singleton_method(baz_module, "ext_test", RUBY_METHOD_FUNC(method_ext_test), 0);

  // Builds Ruby class Baz::Vector (function definition in baz_vector_ruby.cpp)
  init_baz_vector(baz_module);
}
