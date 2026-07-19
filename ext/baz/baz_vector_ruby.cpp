// ext/baz/baz_vector_ruby.cpp

///////////////////////////////////////////////////////////////////////////////
//
// Ruby bindings for the standalone C++ BVector class. Ruby owns the storage;
// allocation constructs the C++ object in place and the typed-data free
// callback runs its destructor before releasing that storage.
//
///////////////////////////////////////////////////////////////////////////////

#include "baz_vector_ruby.h"

#include <new>

// File-local handle for the Ruby class object created during extension setup.
static VALUE baz_vector_class = Qnil;

// Ruby calls this when the wrapper is collected. Run the C++ destructor first,
// then release the storage allocated by Ruby's typed-data machinery.
static void bvector_free(void *pointer) {
  BVector *vector = static_cast<BVector *>(pointer);
  vector->~BVector();
  ruby_xfree(vector);
}

// Ruby uses this callback to include native storage in memory accounting.
static size_t bvector_size(const void *pointer) {
  (void)pointer;
  return sizeof(BVector);
}

// This descriptor tells Ruby how to identify, mark, free, and measure the
// native object. BVector holds no Ruby VALUEs, so it needs no mark callback.
static const rb_data_type_t bvector_type = {
  "Baz::Vector",
  {nullptr, bvector_free, bvector_size, nullptr, {nullptr}},
  nullptr,
  nullptr,
  // The destructor is safe to run immediately when Ruby finds the object dead.
  RUBY_TYPED_FREE_IMMEDIATELY
};

// Ruby invokes this allocator before initialize. TypedData_Make_Struct creates
// the Ruby wrapper and reserves BVector-sized native storage owned by Ruby.
static VALUE bvector_alloc(VALUE klass) {
  BVector *vector;
  VALUE object = TypedData_Make_Struct(klass, BVector, &bvector_type, vector);
  // BVector's noexcept constructor makes placement construction safe here.
  new (vector) BVector();
  return object;
}

// Validate that object has our typed-data descriptor, then retrieve its C++
// pointer. Ruby raises TypeError if a different object is supplied.
static BVector *get_bvector(VALUE object) {
  BVector *vector;
  TypedData_Get_Struct(object, BVector, &bvector_type, vector);
  return vector;
}

// Implementation of Baz::Vector#initialize. NUM2DBL performs Ruby's numeric
// conversion and raises TypeError for values that cannot become doubles.
static VALUE baz_vector_initialize(VALUE self, VALUE init_x, VALUE init_y) {
  BVector *vector = get_bvector(self);
  vector->set_xy(NUM2DBL(init_x), NUM2DBL(init_y));
  return self;
}

// Ruby calls initialize_copy after allocating storage for clone or dup.
static VALUE baz_vector_initialize_copy(VALUE copy, VALUE original) {
  if (copy != original) {
    BVector *copy_vector = get_bvector(copy);
    const BVector *original_vector = get_bvector(original);
    // Ruby's clone/dup allocation is followed by C++ value assignment here.
    *copy_vector = *original_vector;
  }
  return copy;
}

// Implementation of Baz::Vector#magnitude; DBL2NUM converts the native result
// back into a Ruby Float.
static VALUE baz_vector_magnitude(VALUE self) {
  const BVector *vector = get_bvector(self);
  return DBL2NUM(vector->magnitude());
}

void init_baz_vector(VALUE parent_module) {
  // Define Baz::Vector as a normal Ruby Object subclass, then replace its
  // allocator and connect Ruby method names to the native callbacks above.
  baz_vector_class = rb_define_class_under(parent_module, "Vector", rb_cObject);
  rb_define_alloc_func(baz_vector_class, bvector_alloc);
  // The final number in each call is the method's explicit Ruby argument count.
  rb_define_method(baz_vector_class, "initialize", RUBY_METHOD_FUNC(baz_vector_initialize), 2);
  rb_define_method(baz_vector_class, "initialize_copy", RUBY_METHOD_FUNC(baz_vector_initialize_copy), 1);
  rb_define_method(baz_vector_class, "magnitude", RUBY_METHOD_FUNC(baz_vector_magnitude), 0);
}
