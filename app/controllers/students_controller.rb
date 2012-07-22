class StudentsController < ApplicationController
  load_and_authorize_resource :user, except: :preview
  load_and_authorize_resource :student

  layout "second_tier_page", only: [:preview, :select, :edit]

  def index
    @students = @user.students.ordered_by_name
  end

  def preview
  end

  def select
  end

  def edit
  end
end
