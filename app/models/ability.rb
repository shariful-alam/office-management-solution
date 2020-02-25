class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.present?
      if user.admin? or user.super_admin?
        can :manage, :all

        cannot :edit, User, {role: User::SUPER_ADMIN}
        cannot :destroy, User, {role: User::SUPER_ADMIN}

        cannot :reject, Expense, {status: Expense.statuses[:rejected]}
        cannot :approve, Expense, {status: Expense.statuses[:rejected]}
        cannot :reject, Expense, {status: Expense.statuses[:approved]}
        cannot :update, Expense, {status: Expense.statuses[:approved]}
        cannot :update, Expense, {status: Expense.statuses[:rejected]}
        cannot :destroy, Expense, {status: Expense.statuses[:approved]}

        can :manage, AllocatedLeafe, :all

        can :manage, Attendance, :all

        can :manage, Leafe, :all
        cannot :destroy, Leafe, {status: Leafe.statuses[:approved]}

        can :manage, Income, :all

      else
        can :update, User, {user_id: user.id}

        can :manage, Expense, {user_id: user.id}
        cannot :manage, Expense, {status: Expense.statuses[:rejected]}
        cannot :manage, Expense, {status: Expense.statuses[:approved]}
        cannot :approve, Expense, {user_id: user.id}
        cannot :reject, Expense, {user_id: user.id}
        cannot :show_all_pending, User, :all
        cannot :approve, Expense, :all

        can :show_all, AllocatedLeafe, {user_id: user.id}
        cannot :manage, AllocatedLeafe, :all

        can :create, Attendance, {user_id: user.id}
        can :update, Attendance, {user_id: user.id}

        can :manage, Leafe, {user_id: user.id, status: Leafe.statuses[:pending]}
        can :read, Leafe, {user_id: user.id, status: Leafe.statuses[:approved]}
        can :read, Leafe, {user_id: user.id, status: Leafe.statuses[:rejected]}
        cannot :edit, Leafe, {status: Leafe.statuses[:approved]}
        cannot :edit, Leafe, {status: Leafe.statuses[:rejected]}
        cannot :destroy, Leafe, {status: Leafe.statuses[:approved]}
        cannot :destroy, Leafe, {status: Leafe.statuses[:rejected]}
        cannot :approve, Leafe, :all
        cannot :reject, Leafe, :all

        can :create, Income
        can :manage, Income, {user_id: user.id, status: Income.statuses[:pending]}
        can :read, Income, {user_id: user.id, status: Income.statuses[:approved]}
        can :read, Income, {user_id: user.id, status: Income.statuses[:rejected]}
        cannot :approve, Income, :all
        cannot :reject, Income, :all
        can :show_individual, Income, {user_id: user.id}
      end
    else
      cannot :manage, :all
    end
  end
end


# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities