require 'baz'

describe Baz do
  describe "#ruby_test" do
    it "should return 36" do
      Baz.ruby_test.should == 36
    end
  end
  describe "#ext_test" do
    it "should return 3908" do
      Foo.ext_test.should == 3908
    end
  end
end
