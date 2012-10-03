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

private

  after_filter :track_consistency, only: :consistency

  def track_consistency
    comparison_type = if params[:comparison_user_id]
      'Coworker'
    elsif params[:school_average_comaprison]
      'School Average'
    else
      'None'
    end

    Analytics.track_event "Consistency: Compare", {
      "School" => @user.school.name,
      "Comparison Type" => comparison_type
    }
  end
end