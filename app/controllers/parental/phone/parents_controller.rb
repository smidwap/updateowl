module Parental
  module Phone
    class ParentsController < BaseController
      def answer
        @parent = Parent.find_by_phone(phone)

        if @parent
          redirect_to parental_phone_parent_deliveries_path(@parent)
        else
          redirect_to new_parental_phone_parent_path
        end
      end

      def new
        track_new
      end

      def create
        @student = Student.find_by_pin(params[:Digits])

        if @student
          @parent = @student.parents.new \
            phone: params[:From],
            preference: 'phone'
          @parent.school = @student.school
          @student.save!

          track_create
        else
          track_invalid_pin

          render "invalid_pin"
        end
      end

      private

      def phone
        phone = params[:Direction] == "outbound-api" ? params[:To] : params[:From]
      end

      def track_create
        track_event("Parent: Sign Up", {
          "distinct_id" => parent_distinct_id(@parent),
          "mp_name_tag" => parent_name_tag(@parent),
          "Preference" => @parent.preference,
          "School" => @parent.try(:school).try(:name)
        })

        track_presignup_event "Phone Call: Registered"
      end

      def track_new
        track_presignup_event "Phone Call: Welcome"
      end

      def track_invalid_pin
        track_presignup_event "Phone Call: Invalid Pin"
      end

      def track_answer
        track_event("Phone Call", {
          "distinct_id" => parent
        })
      end

      def track_presignup_event(event)
        track_event(event, {
          "distinct_id" => phone,
          "mp_name_tag" => phone
        })
      end
    end
  end
end