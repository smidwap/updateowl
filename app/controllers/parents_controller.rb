class ParentsController < ApplicationController
  load_and_authorize_resource :student, only: :create
  load_and_authorize_resource except: :create

  def create
    @parent = @student.parents.create!(params[:parent])
  rescue ActiveRecord::RecordInvalid
  end

  def toggle_preference
    @parent.toggle_preference!

    render :update
  rescue ActiveRecord::RecordInvalid
  end

  def update
    @parent.update_attributes!(params[:parent])

    flash[:notice] = "You successfully updated the parent's contact."
  rescue ActiveRecord::RecordInvalid
  end

  def destroy
    @parent.destroy
  end
end