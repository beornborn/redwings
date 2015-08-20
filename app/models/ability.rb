class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      can :manage_projects_participation, User
    else
      can :read, User
      can :update, User, id: user.id
    end
  end
end
