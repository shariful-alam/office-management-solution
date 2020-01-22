
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == "Office Admin"
      can :manage, :all
    elsif user.present?
      can :manage,Expense,user_id: user.id
      can :manage,User,user_id: user.id
      can :read,Budget, :all
    end
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
