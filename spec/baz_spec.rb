# frozen_string_literal: true

require 'baz'

describe Baz do
  describe '#ruby_test' do
    it 'should return 36' do
      expect(Baz.ruby_test).to be 36
    end
  end
  describe '#ext_test' do
    it 'should return 3908' do
      expect(Baz.ext_test).to be 3908
    end
  end
end

describe Baz::Vector do
  describe 'class method' do
    describe '#new' do
      it 'should create a new valid Baz::Vector object' do
        expect(Baz::Vector.new(0, 0)).to be_a Baz::Vector
      end

      it 'should reject non-numbers when instantiating' do
        expect { Baz::Vector.new('x', 0.0) }.to raise_error TypeError
        expect { Baz::Vector.new(0, {}) }.to raise_error TypeError
        expect { Baz::Vector.new(0, []) }.to raise_error TypeError
      end
    end
  end

  describe 'instance method' do
    let(:bv) { Baz::Vector.new(1.0, 2.0) }

    describe '#magnitude' do
      it 'should return length of a vector' do
        expect(bv.magnitude).to be_within(1e-9).of Math.sqrt(5.0)
      end
    end

    describe '#clone' do
      it 'should create a copy of a vector, including C++ data' do
        bv_copy = bv.clone
        expect(bv_copy).to be_a Baz::Vector
        expect(bv_copy.object_id).to_not eql bv.object_id
        expect(bv_copy.magnitude).to be_within(1e-9).of Math.sqrt(5.0)
      end
    end
  end
end
