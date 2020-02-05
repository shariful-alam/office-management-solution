class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.present?
      if user.role == User::ADMIN or user.role == User::SUPER_ADMIN
        can :manage, :all
        cannot :reject, Expense, {status: 'Rejected'}
        cannot :approve, Expense, {status: 'Rejected'}
        cannot :reject, Expense, {status: 'Approved'}
        cannot :update, Expense, {status: 'Approved'}
        cannot :update, Expense, {status: 'Rejected'}

        can :manage, AllocatedLeafe, :all

        can :manage, Attendance, :all

        can :manage, Leafe, :all

        can :manage, Income, :all
      else
        can :update, User, {user_id: user.id}

        can :manage, Expense, {user_id: user.id}
        cannot :manage, Expense, {status: 'Rejected'}
        cannot :manage, Expense, {status: 'Approved'}
        cannot :approve, Expense, {user_id: user.id}
        cannot :reject, Expense, {user_id: user.id}
        can :read, Expense, {user_id: user.id}
        cannot :show_all_pending, User, :all
        cannot :approve, Expense, :all

        can :show_all, AllocatedLeafe, {user_id: user.id}
        cannot :manage, AllocatedLeafe, :all

        can :create, Attendance, {user_id: user.id}
        can :update, Attendance, {user_id: user.id}

        can :manage, Leafe, {user_id: user.id, status: 'Pending'}
        can :read, Leafe, {user_id: user.id, status: 'Approved'}
        can :read, Leafe, {user_id: user.id, status: 'Rejected'}
        cannot :approve, Leafe, :all

        can :create, Income
        can :manage, Income, {user_id: user.id, status: 'Pending'}
        can :read, Income, {user_id: user.id, status: 'Approved'}
        can :read, Income, {user_id: user.id, status: 'Rejected'}
        cannot :approve, Income, :all
        cannot :reject, Income, :all
      end
    else
      cannot :manage, :all
    end
  end
end


# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities