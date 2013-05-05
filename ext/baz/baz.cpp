// ext/baz/baz.cpp

#include <ruby.h>

#include "ruby_bindings.h"

// Make bindings (C-style calls required for Ruby to bind) . . .
extern "C" void Init_baz() {
  init_ruby_module_ruby_native_cpp();
}
