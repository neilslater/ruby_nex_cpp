// ext/baz/baz_vector_lib.cpp

#include "baz_vector_lib.h"

BVector::BVector() {
    x = 0.0;
    y = 0.0;
}

BVector::~BVector() {
    // Nothing to do
}

void BVector::set_xy( double ix, double iy ) {
    x = ix;
    y = iy;
    return;
}

double BVector::magnitude() {
    return sqrt( x * x + y * y );
}
