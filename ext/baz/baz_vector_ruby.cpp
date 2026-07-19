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

static VALUE baz_vector_class = Qnil;

static void bvector_free(void *pointer) {
  BVector *vector = static_cast<BVector *>(pointer);
  vector->~BVector();
  ruby_xfree(vector);
}

static size_t bvector_size(const void *pointer) {
  (void)pointer;
  return sizeof(BVector);
}

static const rb_data_type_t bvector_type = {
  "Baz::Vector",
  {nullptr, bvector_free, bvector_size, nullptr, {nullptr}},
  nullptr,
  nullptr,
  RUBY_TYPED_FREE_IMMEDIATELY
};

static VALUE bvector_alloc(VALUE klass) {
  BVector *vector;
  VALUE object = TypedData_Make_Struct(klass, BVector, &bvector_type, vector);
  // BVector's noexcept constructor makes placement construction safe here.
  new (vector) BVector();
  return object;
}

static BVector *get_bvector(VALUE object) {
  BVector *vector;
  TypedData_Get_Struct(object, BVector, &bvector_type, vector);
  return vector;
}

static VALUE baz_vector_initialize(VALUE self, VALUE init_x, VALUE init_y) {
  BVector *vector = get_bvector(self);
  vector->set_xy(NUM2DBL(init_x), NUM2DBL(init_y));
  return self;
}

static VALUE baz_vector_initialize_copy(VALUE copy, VALUE original) {
  if (copy != original) {
    BVector *copy_vector = get_bvector(copy);
    const BVector *original_vector = get_bvector(original);
    // Ruby's clone/dup allocation is followed by C++ value assignment here.
    *copy_vector = *original_vector;
  }
  return copy;
}

static VALUE baz_vector_magnitude(VALUE self) {
  const BVector *vector = get_bvector(self);
  return DBL2NUM(vector->magnitude());
}

void init_baz_vector(VALUE parent_module) {
  baz_vector_class = rb_define_class_under(parent_module, "Vector", rb_cObject);
  rb_define_alloc_func(baz_vector_class, bvector_alloc);
  rb_define_method(baz_vector_class, "initialize", RUBY_METHOD_FUNC(baz_vector_initialize), 2);
  rb_define_method(baz_vector_class, "initialize_copy", RUBY_METHOD_FUNC(baz_vector_initialize_copy), 1);
  rb_define_method(baz_vector_class, "magnitude", RUBY_METHOD_FUNC(baz_vector_magnitude), 0);
}
