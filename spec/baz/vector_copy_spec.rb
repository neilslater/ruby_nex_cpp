# frozen_string_literal: true

require 'spec_helper'

describe Baz::Vector do
  let(:vector) { described_class.new(3, 4) }

  shared_examples 'an independent vector copy' do
    it 'preserves the Ruby class' do
      expect(copy).to be_instance_of vector.class
    end

    it 'creates a distinct Ruby object' do
      expect(copy).not_to equal vector
    end

    it 'copies the native coordinates' do
      expect(copy.magnitude).to eq 5.0
    end

    it 'keeps the copy independent when the original changes' do
      copy
      vector.send(:initialize, 6, 8)
      expect([vector.magnitude, copy.magnitude]).to eq [10.0, 5.0]
    end

    it 'keeps the original independent when the copy changes' do
      copy.send(:initialize, 5, 12)
      expect([vector.magnitude, copy.magnitude]).to eq [5.0, 13.0]
    end
  end

  describe '#dup' do
    subject(:copy) { vector.dup }

    it_behaves_like 'an independent vector copy'

    it 'makes an unfrozen copy of a frozen source', :aggregate_failures do
      vector.freeze
      expect(copy).not_to be_frozen
      expect(copy.magnitude).to eq 5.0
    end

    it 'does not copy singleton methods' do
      def vector.label = 'original'
      expect(copy).not_to respond_to :label
    end
  end

  describe '#clone' do
    subject(:copy) { vector.clone }

    it_behaves_like 'an independent vector copy'

    it 'preserves a frozen source', :aggregate_failures do
      vector.freeze
      expect(copy).to be_frozen
      expect(copy.magnitude).to eq 5.0
    end

    it 'can make an unfrozen clone of a frozen source', :aggregate_failures do
      vector.freeze
      unfrozen = vector.clone(freeze: false)
      expect(unfrozen).not_to be_frozen
      expect(unfrozen.magnitude).to eq 5.0
    end

    it 'can freeze a clone of an unfrozen source', :aggregate_failures do
      frozen = vector.clone(freeze: true)
      expect(frozen).to be_frozen
      expect(frozen.magnitude).to eq 5.0
      expect(vector).not_to be_frozen
    end

    it 'copies singleton methods' do
      def vector.label = 'original'
      expect(copy.label).to eq 'original'
    end
  end

  describe 'copying a subclass with an extra constructor argument' do
    let(:vector_class) do
      Class.new(described_class) do
        attr_reader :label

        def initialize(init_x, init_y, label)
          super(init_x, init_y)
          @label = label
        end
      end
    end
    let(:vector) { vector_class.new(3, 4, 'original') }

    it 'preserves the subclass and Ruby state with dup', :aggregate_failures do
      expect(vector.dup).to be_instance_of vector_class
      expect(vector.dup.label).to eq 'original'
      expect(vector.dup.magnitude).to eq 5.0
    end

    it 'preserves the subclass and Ruby state with clone', :aggregate_failures do
      expect(vector.clone).to be_instance_of vector_class
      expect(vector.clone.label).to eq 'original'
      expect(vector.clone.magnitude).to eq 5.0
    end
  end

  describe '#initialize_copy' do
    it 'copies another vector of the same class' do
      vector.send(:initialize_copy, described_class.new(5, 12))
      expect(vector.magnitude).to eq 13.0
    end

    it 'rejects a distinct frozen destination without changing coordinates', :aggregate_failures do
      vector.freeze
      expect { vector.send(:initialize_copy, described_class.new(5, 12)) }.to raise_error FrozenError
      expect(vector.magnitude).to eq 5.0
    end

    it 'leaves frozen self-copy as a no-op', :aggregate_failures do
      vector.freeze
      expect(vector.send(:initialize_copy, vector)).to equal vector
      expect(vector.magnitude).to eq 5.0
    end

    it 'rejects a subclass source without changing coordinates', :aggregate_failures do
      original = Class.new(described_class).new(5, 12)
      expect { vector.send(:initialize_copy, original) }.to raise_error TypeError
      expect(vector.magnitude).to eq 5.0
    end

    it 'rejects a base-class source for a subclass destination', :aggregate_failures do
      copy = Class.new(described_class).new(5, 12)
      expect { copy.send(:initialize_copy, vector) }.to raise_error TypeError
      expect(copy.magnitude).to eq 13.0
    end

    it 'rejects a sibling subclass source', :aggregate_failures do
      original = Class.new(described_class).new(3, 4)
      copy = Class.new(described_class).new(5, 12)
      expect { copy.send(:initialize_copy, original) }.to raise_error TypeError
      expect(copy.magnitude).to eq 13.0
    end

    it 'rejects unrelated typed data without changing coordinates', :aggregate_failures do
      expect { vector.send(:initialize_copy, Time.at(0)) }.to raise_error TypeError
      expect(vector.magnitude).to eq 5.0
    end
  end
end
