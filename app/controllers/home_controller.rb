class HomeController < ApplicationController
  layout "users"

  skip_before_filter :authenticate_user!, if: :user_is_from_extension_and_is_authenticated

  def dashboard
    @user = current_user
    @messages = @user.all_messages_for_students.paginate(page: params[:page], per_page: 40).includes(:students, :user)
  end

private

  def user_is_from_extension_and_is_authenticated
    params[:format] == 'extension' && current_user.nil?
  end
end
