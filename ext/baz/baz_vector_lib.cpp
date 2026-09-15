// ext/baz/baz_vector_lib.cpp

///////////////////////////////////////////////////////////////////////////////
//
//  C++ "library" class that we want to bind to Ruby. Method definitions
//
///////////////////////////////////////////////////////////////////////////////

#include "baz_vector_lib.h"

BVector::BVector() noexcept : x(0.0), y(0.0) {}

void BVector::set_xy( double ix, double iy ) noexcept {
    x = ix;
    y = iy;
}

double BVector::magnitude() const noexcept {
    // hypot avoids intermediate overflow/underflow from squaring coordinates
    // when the final length is still representable as a double.
    return std::hypot( x, y );
}
