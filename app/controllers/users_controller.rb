class UsersController < ApplicationController
  load_and_authorize_resource

  def consistency
    if params[:comparison_user_id]
      @comparison = User.find(params[:comparison_user_id])
      @consistency = Consistency.new(@user, @comparison)
    elsif params[:school_average_comaprison]
      @comparison = @user.school
      @consistency = Consistency.new(@user, @comparison)
    else
      @consistency = Consistency.new(@user)
    end
  end
end