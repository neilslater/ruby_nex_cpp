// ext/baz/baz_vector_lib.h

///////////////////////////////////////////////////////////////////////////////
//
//  C++ "library" class that we want to bind to Ruby. Class declaration.
//
///////////////////////////////////////////////////////////////////////////////

#ifndef BAZ_VECTOR_LIB_H
#define BAZ_VECTOR_LIB_H

#include <math.h>

class BVector {
    public:
        BVector();
        ~BVector();

        void set_xy( double ix, double iy );
        double magnitude();

    private:
        double x;
        double y;
};

#endif
