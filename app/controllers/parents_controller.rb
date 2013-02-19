class ParentsController < ApplicationController
  load_and_authorize_resource :student
  load_and_authorize_resource except: [:new, :create]

  def new
    @parent = @student.parents.new

    render layout: "second_tier_page"
  end

  def create
    @parent = @student.parents.new(params[:parent])
    @parent.school = @student.school

    @student.save!

    track_create

    flash[:notice] = "The parent's contact details have been saved."
    render "students/edit", layout: "second_tier_page"
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @parent
  end

  def edit
    render layout: "second_tier_page"
  end

  def update
    @parent.update_attributes!(params[:parent])

    track_update

    flash[:notice] = "The parent's contact details have been saved."
    render "students/edit", layout: "second_tier_page"
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @parent
  end

  def toggle_translation
    @parent.toggle!(:spanish_speaking)
  end

  def destroy
    @parent.destroy

    track_destroy
  end

  private

  def track_create
    Analytics.track_event "Parent Contact: Create"
  end

  def track_update
    Analytics.track_event "Parent Contact: Save"
  end

  def track_destroy
    Analytics.track_event "Parent Contact: Delete"
  end
end