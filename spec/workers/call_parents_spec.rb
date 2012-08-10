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
end