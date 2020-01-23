class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.present?
      if user.role == 'Office Admin'
        can :manage, :all

      else
        can :read, :all
        can :manage, Expense, {user_id: user.id}
        cannot :approve, Expense,:all
      end

    end
  end
end


# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities