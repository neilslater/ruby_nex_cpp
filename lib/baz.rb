# frozen_string_literal: true

require 'baz/version'
require 'baz/baz'

# Example Ruby module backed by a C++ native extension.
module Baz
  # @!method self.ext_test
  #   Return the native extension's example value.
  #   @return [Integer] the value `3908`

  # @!parse
  #   # A two-dimensional vector implemented by the native extension.
  #   #
  #   # Inherited dup and clone copy native coordinates independently and retain
  #   # Ruby's usual subclass, singleton-method, and frozen-state behavior.
  #   # Copy initialization requires the same Ruby class and an unfrozen
  #   # destination; self-copy is a no-op even when frozen.
  #   class Vector
  #     # @!method initialize(x, y)
  #     #   Convert x then y to doubles before assigning either coordinate.
  #     #   Integers, floats, rationals, and suitable to_f objects are accepted;
  #     #   numeric strings are rejected. Not every Numeric is convertible.
  #     #   Conversion callback exceptions propagate unchanged. Failed validation
  #     #   prevents our coordinate assignment, but does not undo callback effects.
  #     #   @param x [Numeric, #to_f] horizontal coordinate
  #     #   @param y [Numeric, #to_f] vertical coordinate
  #     #   @raise [TypeError] if conversion is unsupported or to_f returns a non-Float
  #     #   @raise [RangeError] if numeric conversion rejects the value, such as a non-real Complex
  #     #   @raise [FrozenError] if the receiver is frozen on entry or after conversion
  #     #
  #     # @!method magnitude
  #     #   Calculate the vector's Euclidean length.
  #     #   @return [Float] the vector magnitude
  #   end

  # Return the Ruby implementation's example value.
  #
  # @return [Integer] the value `36`
  def self.ruby_test
    36
  end
end
