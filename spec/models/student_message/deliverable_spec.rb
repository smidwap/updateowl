require 'spec_helper'

describe StudentMessage::Deliverable do
  describe "#new_deliveries" do
    it "should return new delivieries for each parent" do
      student_message = build_stubbed(:student_message)

      parents = build_stubbed_list(:parent, 2)
      student_message.stub(:parents).and_return parents

      parents.each do |parent|
        student_message.new_deliveries.select { |delivery| delivery.parent == parent }.count.should == 1
      end
    end
  end
end