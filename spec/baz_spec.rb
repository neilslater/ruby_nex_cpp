# frozen_string_literal: true

require 'spec_helper'

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
end
