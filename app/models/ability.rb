class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role?(:user, user.account || Account.new)
      can [:me, :password, :update_me, :update_password, :standups], User
      can [:feed, :mine], ActivityController
      can [:index, :show, :standups], Team
      cannot :manage, Account
    elsif user.has_role?(:admin, user.account || Account.new) #is an admin
      can :manage, :all
    else
      can [:new, :create], Account
    end
  end
end
