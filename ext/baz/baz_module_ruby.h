// ext/baz/baz_module_ruby.h

///////////////////////////////////////////////////////////////////////////////
//
//  Declarations of Ruby bindings for Baz module methods.
//
///////////////////////////////////////////////////////////////////////////////

#ifndef BAZ_MODULE_RUBY_H
#define BAZ_MODULE_RUBY_H

#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
#endif
#include <ruby.h>
#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif

// Creates the top-level Baz module and attaches its native methods and classes.
void init_baz_module(void);

#endif
