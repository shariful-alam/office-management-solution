class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.present?
      if user.role == 'Office Admin'
        can :manage, :all
        can :manage, AllocatedLeafe, :all
        can :manage, Attendance,:all
        can :manage, Leafe, :all
      else
        can :read, :all
        can :manage, Expense, {user_id: user.id}
        cannot :approve, Expense,:all
        cannot :read, AllocatedLeafe, :all
        can :show_all, AllocatedLeafe, {user_id: user.id}

        can :manage, Attendance, {user_id: user.id}
        cannot :read, Attendance
        can :create, Leafe
        cannot :read, Leafe
      end

    end
  end
end


# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities