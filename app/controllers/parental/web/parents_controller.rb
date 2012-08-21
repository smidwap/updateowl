module Parental
  module Web
    class ParentsController < BaseController
      layout "devise"

      def new
        @parent = Parent.new
      end

      def create
        @student = Student.find_by_pin(params[:pin])

        if @student
          @parent = @student.parents.new \
            email: params[:email],
            preference: 'email'
          @parent.school = @student.school
          @student.save!

          track_create
        else
          redirect_to new_parental_web_parent_path, alert: "The pin number you entered is not valid. Check to make sure you entered the right pin!"
        end
      rescue ActiveRecord::RecordInvalid
        redirect_to new_parental_web_parent_path, alert: @parent.errors.full_messages.to_sentence
      end

      private

      def track_create
        track_event("Parent: Sign Up via Web", {
          "distinct_id" => parent_distinct_id(@parent),
          "mp_name_tag" => parent_name_tag(@parent),
          "School" => @parent.try(:school).try(:name)
        })
      end
    end
  end
end