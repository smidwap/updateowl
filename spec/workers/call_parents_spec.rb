require 'spec_helper'

describe CallParents do
  describe "self.perform" do
    it "should call each parent with unchecked messages" do
      parents = build_stubbed_list(:parent, 2)
      Parent.stub_chain(:with_unchecked_messages, :prefers_phone).and_return parents

      parents.each { |parent| CallParents.should_receive(:call).with(parent) }

      CallParents.perform
    end
  end

  describe "self.from_phone" do
    it "should return '+17132346203' if the Rails environment is production" do
      Rails.stub(:env).and_return "production"

      CallParents.from_phone.should == '+17132346203'
    end

    it "should return '+13174947897' if the Rails environment is not production" do
      Rails.stub(:env).and_return "development"

      CallParents.from_phone.should == '+13174947897'
    end
  end
end