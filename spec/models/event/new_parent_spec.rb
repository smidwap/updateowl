require 'spec_helper'

describe Event::NewParent do
  describe "#students" do
    it "should return only the parents students that are accessible to the user" do
      students = build_stubbed_list(:student, 2)

      parent = build_stubbed(:parent)
      parent.students = students

      user = build_stubbed(:user)
      user.students = [students.first]

      @new_parent_event = Event::NewParent.new(user, parent)

      @new_parent_event.students.should == [students.first]
    end
  end
end