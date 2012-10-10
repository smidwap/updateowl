class UserMessagesController < ApplicationController
  load_and_authorize_resource :user

  layout "users"

  def index
    @messages = @user.messages
  end
  
  def unchecked
    @messages = @user.messages.unchecked
  end

  def new_mass
    @message = @user.messages.new
    @message.user = @user
    @message.students << @user.students.with_registered_parents

    authorize! :manage, @message

    render layout: "second_tier_page"
  end
end