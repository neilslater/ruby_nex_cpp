// ext/baz/baz_vector_ruby.h

///////////////////////////////////////////////////////////////////////////////
//
//  Declarations for Ruby wrappers to BVector class
//
///////////////////////////////////////////////////////////////////////////////

#ifndef BAZ_VECTOR_RUBY_H
#define BAZ_VECTOR_RUBY_H

#include "baz_vector_lib.h"
#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
#endif
#include <ruby.h>
#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif

// Defines Baz::Vector beneath parent_module and exposes its native methods.
void init_baz_vector( VALUE parent_module );

#endif
