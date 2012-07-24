require 'spec_helper'

describe Parent do
  describe "#prefers_email?" do
    it "should return true if the parent prefers email" do
      build_stubbed(:parent_prefers_email).prefers_email?.should == true
    end

    it "should return false if the parent does not prefer email" do
      build_stubbed(:parent_prefers_phone).prefers_email?.should == false
    end
  end

  describe "#prefers_phone?" do
    it "should return true if the parent prefers phone" do
      build_stubbed(:parent_prefers_phone).prefers_phone?.should == true
    end

    it "should return false if the parent does not prefer phone" do
      build_stubbed(:parent_prefers_email).prefers_phone?.should == false
    end
  end
end
