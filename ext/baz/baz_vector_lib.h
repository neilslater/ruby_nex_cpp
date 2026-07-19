// ext/baz/baz_vector_lib.h

///////////////////////////////////////////////////////////////////////////////
//
//  C++ "library" class that we want to bind to Ruby. Class declaration.
//
///////////////////////////////////////////////////////////////////////////////

#ifndef BAZ_VECTOR_LIB_H
#define BAZ_VECTOR_LIB_H

#include <cmath>

class BVector {
    public:
        BVector() noexcept;

        void set_xy( double ix, double iy ) noexcept;
        double magnitude() const noexcept;

    private:
        double x;
        double y;
};

#endif
