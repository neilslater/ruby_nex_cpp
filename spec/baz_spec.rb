require 'baz'

describe Baz do
  describe "#ruby_test" do
    it "should return 36" do
      Baz.ruby_test.should == 36
    end
  end
  describe "#ext_test" do
    it "should return 3908" do
      Baz.ext_test.should == 3908
    end
  end
end

describe Baz::Vector do
  describe "class method" do
    describe "#new" do
      it "should create a new valid Baz::Vector object" do
        Baz::Vector.new( 0, 0 ).should be_a Baz::Vector
      end

      it "should reject non-numbers when instantiating" do
        lambda { Baz::Vector.new( 'x', 0.0 ) }.should raise_error TypeError
        lambda { Baz::Vector.new( 0, {}) }.should raise_error TypeError
        lambda { Baz::Vector.new( 0, [] ) }.should raise_error TypeError
      end
    end
  end

  describe "instance method" do
    let(:bv) { Baz::Vector.new( 1.0, 2.0 ) }

    describe "#magnitude" do
      it "should return length of a vector" do
        bv.magnitude.should be_within(1e-9).of Math.sqrt( 5.0 )
      end
    end

    describe "#clone" do
      it "should create a copy of a vector, including C++ data" do
        bv_copy = bv.clone
        bv_copy.should be_a Baz::Vector
        bv_copy.object_id.should_not == bv.object_id
        bv_copy.magnitude.should be_within(1e-9).of Math.sqrt( 5.0 )
      end
    end
  end
end