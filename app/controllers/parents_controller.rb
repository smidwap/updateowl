class ParentsController < ApplicationController
  load_and_authorize_resource :student, only: :create
  load_and_authorize_resource except: :create

  def create
    @parent = @student.parents.new(params[:parent])
    @student.save!
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @parent
  end

  def toggle_preference
    @parent.toggle_preference!

    render :update
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @parent
  end

  def update
    @parent.update_attributes!(params[:parent])

    flash[:notice] = "You successfully updated the parent's contact."
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @parent
  end

  def destroy
    @parent.destroy
  end
end