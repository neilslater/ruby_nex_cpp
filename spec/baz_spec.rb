# frozen_string_literal: true

require 'baz'

describe Baz do
  describe '.ruby_test' do
    it 'returns 36' do
      expect(described_class.ruby_test).to be 36
    end
  end

  describe '.ext_test' do
    it 'returns 3908' do
      expect(described_class.ext_test).to be 3908
    end
  end

  describe Baz::Vector do
    let(:vector) { described_class.new(1.0, 2.0) }

    describe '.new' do
      it 'creates a valid vector' do
        expect(described_class.new(0, 0)).to be_a described_class
      end

      it 'rejects a non-number for x' do
        expect { described_class.new('x', 0.0) }.to raise_error TypeError
      end

      it 'rejects a hash for y' do
        expect { described_class.new(0, {}) }.to raise_error TypeError
      end

      it 'rejects an array for y' do
        expect { described_class.new(0, []) }.to raise_error TypeError
      end
    end

    describe '#magnitude' do
      it 'returns the length of a vector' do
        expect(vector.magnitude).to be_within(1e-9).of Math.sqrt(5.0)
      end
    end

    describe '#clone' do
      subject(:copy) { vector.clone }

      it 'creates another vector' do
        expect(copy).to be_a described_class
      end

      it 'creates a distinct Ruby object' do
        expect(copy).not_to equal vector
      end

      it 'copies the C++ data' do
        expect(copy.magnitude).to be_within(1e-9).of Math.sqrt(5.0)
      end
    end
  end
end
