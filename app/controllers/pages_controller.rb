class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    render layout: nil
  end
end