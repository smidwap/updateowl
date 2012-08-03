class ParentsController < ApplicationController
  load_and_authorize_resource :student
  load_and_authorize_resource except: [:new, :create]

  def new
    @parent = @student.parents.new

    render layout: "second_tier_page"
  end

  def create
    @parent = @student.parents.new(params[:parent])

    @student.save!

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

    flash[:notice] = "The parent's contact details have been saved."
    render "students/edit", layout: "second_tier_page"
  rescue ActiveRecord::RecordInvalid
    render_resource_invalid @parent
  end

  def destroy
    @parent.destroy
  end
end