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

  describe "#current_contact" do
    it "should return the phone number if preference is phone" do
      phone = '2193090213'
      build_stubbed(:parent_prefers_phone, phone: phone).current_contact.should == phone
    end

    it "should return the email if preference is email" do
      email = 'smidwap@gmail.com'
      build_stubbed(:parent_prefers_email, email: email).current_contact.should == email
    end
  end

  describe "#sufficient_contact_details" do
    it "should add a validation error if the parent prefers email but has a blank email address (i.e. no input)" do
      parent = build_stubbed(:parent_prefers_email, email: "")

      parent.send(:sufficient_contact_details)

      parent.errors.count.should == 1
    end

    it "should add a validation error if the parent prefers phone but has no phone (i.e. no input)" do
      parent = build_stubbed(:parent_prefers_phone, phone: "")

      parent.send(:sufficient_contact_details)

      parent.errors.count.should == 1
    end

    it "should not add any validation errors if the user prefers phone and has a phone number" do
      parent = build_stubbed(:parent_prefers_phone)

      parent.send(:sufficient_contact_details)

      parent.errors.count.should == 0
    end

    it "should not add any validation errors if the user prefers email and has an email" do
      parent = build_stubbed(:parent_prefers_email)

      parent.send(:sufficient_contact_details)

      parent.errors.count.should == 0
    end
  end
end
