class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.present?
      if user.super_admin?

        can :manage, :all
        cannot :edit, User, {role: User::SUPER_ADMIN}
        can :edit, User, {id: user.id}
        cannot :destroy, User, {role: User::SUPER_ADMIN}

      elsif user.admin?

        can :manage, User , :all
        cannot :edit, User, {role: User::SUPER_ADMIN}
        cannot :destroy, User, {role: User::SUPER_ADMIN}

        can :manage, Budget , :all

        can :index, Expense , :all
        can :read, Expense , :all
        can :create, Expense , {user_id: user.id}
        can :update, Expense, {user_id: user.id}
        can :destroy, Expense, {user_id: user.id}
        can :approve, Expense, {status: Expense.statuses[:pending]}
        can :reject, Expense, {status: Expense.statuses[:pending]}
        can :approve, Expense, {status: Expense.statuses[:approved]}
        cannot :reject, Expense, {status: Expense.statuses[:rejected]}
        cannot :approve, Expense, {status: Expense.statuses[:rejected]}
        cannot :reject, Expense, {status: Expense.statuses[:approved]}
        cannot :update, Expense, {status: Expense.statuses[:rejected]}
        cannot :update, Expense, {status: Expense.statuses[:approved]}
        can :destroy, Expense, {status: Expense.statuses[:rejected]}
        cannot :destroy, Expense, {status: Expense.statuses[:approved]}


        can :manage, AllocatedLeafe, :all

        can :manage, Attendance, :all

        can :index, Leafe , :all
        can :read, Leafe , :all
        can :create, Leafe , {user_id: user.id}
        can :update, Leafe, {user_id: user.id}
        can :destroy, Leafe, {user_id: user.id}
        can :approve, Leafe, {status: Leafe.statuses[:pending]}
        can :reject, Leafe, {status: Leafe.statuses[:pending]}
        can :approve, Leafe, {status: Leafe.statuses[:approved]}
        cannot :reject, Leafe, {status: Leafe.statuses[:rejected]}
        cannot :approve, Leafe, {status: Leafe.statuses[:rejected]}
        cannot :reject, Leafe, {status: Leafe.statuses[:approved]}
        cannot :update, Leafe, {status: Leafe.statuses[:rejected]}
        cannot :update, Leafe, {status: Leafe.statuses[:approved]}
        can :destroy, Leafe, {status: Leafe.statuses[:rejected]}
        cannot :destroy, Leafe, {status: Leafe.statuses[:approved]}

        can :index, Income, :all
        can :show_individual, Income, :all
        can :read, Income , :all
        can :create, Income , {user_id: user.id}
        can :update, Income, {user_id: user.id}
        can :destroy, Income, {user_id: user.id}
        can :approve, Income, {status: Income.statuses[:pending]}
        can :reject, Income, {status: Income.statuses[:pending]}
        can :approve, Income, {status: Income.statuses[:approved]}
        cannot :reject, Income, {status: Income.statuses[:rejected]}
        cannot :approve, Income, {status: Income.statuses[:rejected]}
        cannot :reject, Income, {status: Income.statuses[:approved]}
        cannot :update, Income, {status: Income.statuses[:rejected]}
        cannot :update, Income, {status: Income.statuses[:approved]}
        can :destroy, Income, {status: Income.statuses[:rejected]}
        cannot :destroy, Income, {status: Income.statuses[:approved]}

      else
        can :update, User, {user_id: user.id}

        can :manage, Expense, {user_id: user.id}
        cannot :approve, Expense, {user_id: user.id}
        cannot :reject, Expense, {user_id: user.id}
        cannot :manage, Expense, {status: Expense.statuses[:rejected]}
        cannot :manage, Expense, {status: Expense.statuses[:approved]}
        can :read, Expense, {user_id: user.id}
        can :destroy, Expense, {user_id: user.id,status: Expense.statuses[:rejected]}


        cannot :show_all_pending, User, :all
        can :show_all, AllocatedLeafe, {user_id: user.id}
        cannot :manage, AllocatedLeafe, :all

        can :create, Attendance, {user_id: user.id}
        can :update, Attendance, {user_id: user.id}

        can :manage, Leafe, {user_id: user.id}
        cannot :approve, Leafe, {user_id: user.id}
        cannot :reject, Leafe, {user_id: user.id}
        cannot :manage, Leafe, {status: Leafe.statuses[:rejected]}
        cannot :manage, Leafe, {status: Leafe.statuses[:approved]}
        can :read, Leafe, {user_id: user.id}
        can :destroy, Leafe, {user_id: user.id,status: Leafe.statuses[:rejected]}

        can :manage, Income, {user_id: user.id}
        cannot :approve, Income, {user_id: user.id}
        cannot :reject, Income, {user_id: user.id}
        cannot :manage, Income, {status: Income.statuses[:rejected]}
        cannot :manage, Income, {status: Income.statuses[:approved]}
        can :read, Income, {user_id: user.id}
        can :destroy, Income, {user_id: user.id, status: Income.statuses[:rejected]}
        can :show_individual, Income, {user_id: user.id}
      end
    else
      cannot :manage, :all
    end
  end
end


# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities