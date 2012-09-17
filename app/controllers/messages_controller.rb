class MessagesController < ApplicationController
  load_and_authorize_resource

  layout "second_tier_page"

  def show
  end

  def create#FIX
  end
end