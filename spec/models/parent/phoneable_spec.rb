require 'spec_helper'

describe Parent::Phoneable do
  PHONE_NUMBER_PARTS = {
    phone_area_code: '219',
    phone_three_digits: '309',
    phone_four_digits: '0213'
  }

  before(:each) do
    @parent = build_stubbed(:parent)
  end

  PHONE_NUMBER_PARTS.keys.each do |key|
    describe "#{key}" do
      it "should return the instance variable if set" do
        @parent.send("#{key}=", 'test')
        @parent.send(key).should == 'test'
      end

      it "should return the appropriate part of the phone number if phone is set" do
        @parent.phone = '+12193090213'
        @parent.send(key).should == PHONE_NUMBER_PARTS[key]
      end

      it "should return nil if phone is not set" do
        @parent.phone = nil
        @parent.send(key).should == nil
      end
    end
  end

  describe "#set_phone" do
    it "should combine the phone number attributes to create an international phone number suitable for twilio" do
      @parent.phone_area_code = '219'
      @parent.phone_three_digits = '309'
      @parent.phone_four_digits = '0213'

      @parent.send(:set_phone)

      @parent.phone.should == '+12193090213'
    end
  end
end