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
        // noexcept promises that these functions cannot send a C++ exception
        // through a Ruby C API callback.
        BVector() noexcept;

        void set_xy( double ix, double iy ) noexcept;
        // const means calculating the magnitude does not modify this object.
        double magnitude() const noexcept;

    private:
        double x;
        double y;
};

#endif
