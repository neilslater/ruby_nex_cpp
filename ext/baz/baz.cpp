// ext/baz/baz.cpp

///////////////////////////////////////////////////////////////////////////////
//
//  Entrance point to library, Init_baz() is called during require. Ruby
//  module and class definitions are set up on this call.
//
///////////////////////////////////////////////////////////////////////////////

#include "baz_module_ruby.h"

// Ruby looks up this exact unmangled symbol when `require 'baz/baz'` runs.
// extern "C" prevents C++ name mangling; RUBY_FUNC_EXPORTED makes it visible
// outside the compiled shared library.
extern "C" {
  RUBY_FUNC_EXPORTED void Init_baz(void) {
    init_baz_module();
  }
}
