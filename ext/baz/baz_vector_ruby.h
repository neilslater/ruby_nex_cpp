// ext/baz/baz_vector_ruby.h

#ifndef BAZ_VECTOR_RUBY_H
#define BAZ_VECTOR_RUBY_H

#include "baz_vector_lib.h"
#include <ruby.h>

// Ruby 1.8.7 compatibility patch
#ifndef DBL2NUM
#define DBL2NUM( dbl_val ) rb_float_new( dbl_val )
#endif

void init_baz_vector( VALUE parent_module );

#endif
