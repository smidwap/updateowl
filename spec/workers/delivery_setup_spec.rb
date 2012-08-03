require 'spec_helper'

describe DeliverySetup do
  describe "self.perform" do
    it "should" do
      student = create(:student)

      parent_1 = create(:parent)
      student.parents << parent_1

      parent_2 = create(:parent)
      student.parents << parent_2

      message = create(:message, student: student)
      
      DeliverySetup.perform(message.id)

      [parent_1, parent_2].each { |parent| parent.deliveries.count.should == 1 }
    end
  end
end