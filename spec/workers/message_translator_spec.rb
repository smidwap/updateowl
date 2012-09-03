require 'spec_helper'

describe MessageTranslator do
  before(:each) do
    message = create(:message)

    @message_translator = MessageTranslator.new(message)

    @spanish_translation = 'donde esta mis pantalones?'
    @message_translator.message.body.stub(:to_spanish).and_return @spanish_translation
  end

  describe "#translate" do
    it "should set the message's spanish_body to the spanish translation" do
      @message_translator.translate

      @message_translator.message.reload.spanish_body.should == @spanish_translation
    end
  end

  describe "#translation" do
    it "should return the spanish translation of the message's body" do
      @message_translator.translation.should == @spanish_translation
    end
  end
end