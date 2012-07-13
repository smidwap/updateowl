class StudentsController < ApplicationController
  load_and_authorize_resource :user

  layout "second_tier_page"

  def preview
  end

  def select
  end
end
