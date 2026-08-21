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
  #   class Vector
  #     # @!method initialize(x, y)
  #     #   Create a vector with numeric coordinates.
  #     #   @param x [Numeric] horizontal coordinate
  #     #   @param y [Numeric] vertical coordinate
  #     #   @raise [TypeError] if either coordinate cannot be converted to a number
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
