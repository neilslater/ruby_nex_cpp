# frozen_string_literal: true

require 'spec_helper'

describe Baz::Vector do
  let(:vector) { described_class.new(3, 4) }

  describe '.allocate' do
    it 'constructs a valid zero vector' do
      expect(described_class.allocate.magnitude).to eq 0.0
    end
  end

  describe '.new' do
    it 'creates a valid vector' do
      expect(described_class.new(0, 0)).to be_a described_class
    end

    it 'accepts integer and float coordinates' do
      expect(described_class.new(3, 4.0).magnitude).to eq 5.0
    end

    it 'accepts rational coordinates' do
      expect(described_class.new(Rational(3, 2), Rational(2, 1)).magnitude).to eq 2.5
    end

    it 'rejects a non-number for x' do
      expect { described_class.new('x', 0.0) }.to raise_error TypeError
    end

    it 'rejects numeric strings' do
      expect { described_class.new('3', 4) }.to raise_error TypeError
    end

    it 'rejects a hash for y' do
      expect { described_class.new(0, {}) }.to raise_error TypeError
    end

    it 'rejects an array for y' do
      expect { described_class.new(0, []) }.to raise_error TypeError
    end

    it 'propagates RangeError for a non-real Complex coordinate' do
      expect { described_class.new(Complex(3, 1), 4) }.to raise_error RangeError
    end
  end

  describe '#magnitude' do
    it 'returns the length of a vector' do
      expect(described_class.new(1.0, 2.0).magnitude).to be_within(1e-9).of Math.sqrt(5.0)
    end
  end

  describe '#initialize' do
    let(:x) { instance_double(Float) }
    let(:y) { instance_double(Float) }
    let(:calls) { [] }

    before do
      allow(x).to receive(:to_f) do
        calls << :x
        6.0
      end
      allow(y).to receive(:to_f) do
        calls << :y
        8.0
      end
    end

    it 'accepts objects with a suitable to_f conversion' do
      vector.send(:initialize, x, y)
      expect(vector.magnitude).to eq 10.0
    end

    it 'converts x before y' do
      vector.send(:initialize, x, y)
      expect(calls).to eq %i[x y]
    end

    it 'propagates an exception raised by a conversion callback' do
      allow(x).to receive(:to_f).and_raise(ArgumentError, 'coordinate failed')
      expect { vector.send(:initialize, x, y) }.to raise_error(ArgumentError, 'coordinate failed')
    end

    it 'does not convert y after x fails', :aggregate_failures do
      allow(x).to receive(:to_f).and_raise(ArgumentError)
      expect { vector.send(:initialize, x, y) }.to raise_error ArgumentError
      expect(y).not_to have_received(:to_f)
    end

    it 'preserves coordinates after x conversion fails', :aggregate_failures do
      allow(x).to receive(:to_f).and_raise(ArgumentError)
      expect { vector.send(:initialize, x, y) }.to raise_error ArgumentError
      expect(vector.magnitude).to eq 5.0
    end

    it 'preserves coordinates after y conversion fails', :aggregate_failures do
      allow(y).to receive(:to_f).and_raise(ArgumentError)
      expect { vector.send(:initialize, x, y) }.to raise_error ArgumentError
      expect(vector.magnitude).to eq 5.0
    end

    it 'rejects a non-Float to_f result without changing coordinates', :aggregate_failures do
      allow(y).to receive(:to_f).and_return(8)
      expect { vector.send(:initialize, x, y) }.to raise_error TypeError
      expect(vector.magnitude).to eq 5.0
    end

    it 'rejects a frozen receiver without changing coordinates', :aggregate_failures do
      vector.freeze
      expect { vector.send(:initialize, 6, 8) }.to raise_error FrozenError
      expect(vector.magnitude).to eq 5.0
    end

    it 'rejects a frozen receiver before invoking conversions', :aggregate_failures do
      vector.freeze
      expect { vector.send(:initialize, x, y) }.to raise_error FrozenError
      expect(x).not_to have_received(:to_f)
      expect(y).not_to have_received(:to_f)
    end

    context 'when x conversion freezes the receiver' do
      before do
        allow(x).to receive(:to_f) do
          vector.freeze
          6.0
        end
      end

      it 'converts y and then rejects assignment', :aggregate_failures do
        expect { vector.send(:initialize, x, y) }.to raise_error FrozenError
        expect(vector.magnitude).to eq 5.0
        expect(y).to have_received(:to_f)
      end
    end

    context 'when y conversion freezes the receiver' do
      before do
        allow(y).to receive(:to_f) do
          vector.freeze
          8.0
        end
      end

      it 'rejects assignment', :aggregate_failures do
        expect { vector.send(:initialize, x, y) }.to raise_error FrozenError
        expect(vector.magnitude).to eq 5.0
      end
    end
  end
end
