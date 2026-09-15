# frozen_string_literal: true

require 'spec_helper'

describe Baz::Vector do
  describe '#magnitude' do
    it 'returns the length of a vector' do
      expect(described_class.new(1.0, 2.0).magnitude).to be_within(1e-9).of Math.sqrt(5.0)
    end

    [
      [0, 0, 0.0],
      [3, 4, 5.0],
      [-3, 4, 5.0],
      [3, -4, 5.0],
      [-3, -4, 5.0]
    ].each do |init_x, init_y, expected|
      it "returns #{expected} for coordinates #{init_x}, #{init_y}" do
        expect(described_class.new(init_x, init_y).magnitude).to eq expected
      end
    end

    [1e200, 1e-200, Float::MAX / 2].each do |coordinate|
      it "avoids intermediate range errors for coordinates #{coordinate}, #{coordinate}", :aggregate_failures do
        magnitude = described_class.new(coordinate, coordinate).magnitude
        expect(magnitude).to be_finite
        expect(magnitude).to be_positive
        # Scaling the result makes this a relative check: zero must fail even
        # for tiny coordinates, without squaring extreme reference values.
        expect(magnitude / coordinate).to be_within(1e-14).of Math.sqrt(2.0)
      end
    end

    it 'handles coordinates with very different scales' do
      magnitude = described_class.new(1e200, 1e-200).magnitude
      expect(magnitude / 1e200).to be_within(1e-14).of 1.0
    end

    it 'returns positive infinity when the true length exceeds the Float range' do
      expect(described_class.new(Float::MAX, Float::MAX).magnitude).to eq Float::INFINITY
    end

    [
      [Float::INFINITY, 1.0],
      [1.0, -Float::INFINITY],
      [Float::INFINITY, -Float::INFINITY],
      [Float::INFINITY, Float::NAN],
      [Float::NAN, -Float::INFINITY]
    ].each do |init_x, init_y|
      it "returns positive infinity for coordinates #{init_x}, #{init_y}" do
        expect(described_class.new(init_x, init_y).magnitude).to eq Float::INFINITY
      end
    end

    [[Float::NAN, 1.0], [1.0, Float::NAN], [Float::NAN, Float::NAN]].each do |init_x, init_y|
      it "returns NaN for coordinates #{init_x}, #{init_y}" do
        expect(described_class.new(init_x, init_y).magnitude).to be_nan
      end
    end
  end
end
