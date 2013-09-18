// ext/baz/baz.cpp

#include <ruby.h>

#include "baz_module_ruby.h"

// Make bindings (C-style calls required for Ruby to bind) . . .
extern "C" void Init_baz() {
  init_baz_module();
}
