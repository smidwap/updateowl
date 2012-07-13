class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Message do |message|
      message.sender_id == user.id && user.has_student?(message.student)
    end

    can :manage, User, id: user.id

    can :manage, Student do |student|
      user.has_student?(student)
    end
  end
end