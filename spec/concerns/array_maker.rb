require 'spec_helper'

shared_examples_for ArrayMaker do |host_class|
  describe "self#ids_from" do
    it "should return an array of ids" do
      collection = 'something'

      # Basically testing that the correct arguments are called
      host_class.should_receive(:map_field_from_collection_or_member).with(:id, collection)
      host_class.ids_from(collection)
    end
  end

  describe "self#map_field_from_collection_or_member" do
    before(:each) do
      @member_struct = Struct.new(:some_field)
    end

    context "when passed a collection" do
      it "should return an array of the field's values" do
        collection = [@member_struct.new(1), @member_struct.new(2)]
        host_class.map_field_from_collection_or_member(:some_field, collection).should == [1,2]
      end
    end

    context "when passed a member" do
      it "return an array of size 1 that contains the field's value" do
        host_class.map_field_from_collection_or_member(:some_field, @member_struct.new(1)).should == [1]
      end
    end
  end

  describe "self#array_from" do
    context "when passed an array" do
      it "should return the argument" do
        array = [1, 2]
        host_class.array_from(array).should == array
      end
    end

    context "when passed a single object" do
      it "should return an array with just the single object" do
        object = 1
        host_class.array_from(object).should == [object]
      end
    end
  end
end