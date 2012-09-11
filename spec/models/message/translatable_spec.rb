require 'spec_helper'

describe Message::Translatable do
  before(:each) do
    @message = create(:message)
  end

  describe "#translate" do
    it "should queue MessageTranslator" do
      Resque.should_receive(:enqueue).with(MessageTranslator, @message.id)

      @message.send(:translate)
    end
  end

  describe "spanish_body" do
    before(:each) do
      @new_translation = 'new translation'

      message_translator = MessageTranslator.new(@message)
      message_translator.stub(:translation).and_return @new_translation

      MessageTranslator.stub(:new).and_return message_translator
    end

    it "should return the saved translation if saved" do
      spanish = 'donde esta la biblioteca?'
      message = create(:message, spanish_body: spanish)

      message.spanish_body.should == spanish
    end

    it "should retrieve and return the translation if not saved" do
      message = create(:message)

      message.spanish_body.should == @new_translation
    end
  end

  describe "#should_translate?" do
    it "should return true if one or more recipients are spanish speaking" do
      @message.student.parents << create(:parent, spanish_speaking: true)

      @message.send(:should_translate?).should == true
    end

    it "should return false if no recipients are spanish speaking" do
      @message.send(:should_translate?).should == false
    end
  end

  describe "#should_retranslate?" do
    it "should return true if should_translate? is true and the message body has changed" do
      @message.stub(:should_translate?).and_return true
      @message.body = "hey i've changed"

      @message.send(:should_retranslate?).should == true
    end

    it "should return false if should_translate? is false" do
      @message.stub(:should_translate?).and_return false
      @message.body = "hey i've changed"

      @message.send(:should_retranslate?).should == false
    end

    it "should return false if the message body hasn't changed" do
      @message.stub(:should_translate?).and_return true

      @message.send(:should_retranslate?).should == false
    end
  end
end