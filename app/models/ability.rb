class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.admin?
      can :manage, :all
    else
      can [:index, :show, :learn], Course
      can [:index], Learning
    end
  end
end
