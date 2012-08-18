class Event::NewParent < Event::Base
  attr_accessor :parent, :students

  def initialize(user, parent)
    @user = user
    @parent = parent
    @time = parent.created_at
  end

  def students
    @user.students & @parent.students
  end
end