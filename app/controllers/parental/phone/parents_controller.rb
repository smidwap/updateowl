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
        Analytics.track_parent_event @parent, "Parent: Sign Up"

        track_presignup_event "Phone Call: Registered"
      end

      def track_new
        track_presignup_event "Phone Call: Welcome"
      end

      def track_invalid_pin
        track_presignup_event "Phone Call: Invalid Pin"
      end

      def track_presignup_event(event)
        Analytics.track_event(event, {
          "distinct_id" => phone,
          "mp_name_tag" => phone
        })
      end
    end
  end
end