// ext/baz/baz.cpp

///////////////////////////////////////////////////////////////////////////////
//
//  Entrance point to library, Init_baz() is called during require. Ruby
//  module and class definitions are set up on this call.
//
///////////////////////////////////////////////////////////////////////////////

#include "baz_module_ruby.h"

extern "C" {
  RUBY_FUNC_EXPORTED void Init_baz(void) {
    init_baz_module();
  }
}
