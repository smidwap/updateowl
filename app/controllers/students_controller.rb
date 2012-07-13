class StudentsController < ApplicationController
  load_and_authorize_resource :user, only: :select
  load_and_authorize_resource :student

  layout "second_tier_page"

  def preview
  end

  def select
  end
end
