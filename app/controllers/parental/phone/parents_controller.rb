module Parental
  module Phone
    class ParentsController < BaseController
      def answer
        phone = params[:Direction] == "outbound-api" ? params[:To] : params[:From]
        @parent = Parent.find_by_phone(phone)

        if @parent
          redirect_to parental_phone_parent_deliveries_path(@parent)
        else
          redirect_to new_parental_phone_parent_path
        end
      end

      def new
      end

      def create
        @student = Student.find_by_pin(params[:Digits])

        if @student
          @parent = @student.parents.new \
            phone: params[:From],
            preference: 'phone'
          @parent.school = @student.school
          @student.save!
        else
          render "invalid_pin"
        end

        track_create
      end

      private

      def track_create
        track_event("Parent: Sign Up", {
          "distinct_id" => parent_distinct_id(@parent),
          "mp_name_tag" => parent_name_tag(@parent),
          "Prefernece" => @parent.preference
          "School" => @parent.try(:school).try(:name)
        })
      end
    end
  end
end