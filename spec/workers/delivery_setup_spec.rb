require 'spec_helper'

describe DeliverySetup do
  before(:each) do
    # Stub to avoid the job being performed on callbacks
    Resque.stub(:enqueue)
  end
  
  describe "self.perform" do
    it "should generate a delivery for each parent of each student the message is sent for" do
      # 2 students, 2 parents each
      students = create_list(:student, 2, parents: create_list(:parent, 2))
      message = create(:message, students: students)
      
      DeliverySetup.perform(message.id)

      Delivery.count.should == 4

      students.each do |student|
        student.parents.each do |parent|
          delivery = Delivery.find_by_student_id_and_parent_id(student.id, parent.id)
          delivery.message.should == message
        end
      end
    end
  end
end