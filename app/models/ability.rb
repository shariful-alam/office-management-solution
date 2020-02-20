class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.present?
      if user.admin?
        can :manage, :all
        cannot :reject, Expense, {status: Leafe::REJECTED}
        cannot :approve, Expense, {status: Leafe::REJECTED}
        cannot :reject, Expense, {status: Leafe::APPROVED}
        cannot :update, Expense, {status: Leafe::APPROVED}
        cannot :update, Expense, {status: Leafe::REJECTED}
        cannot :destroy, Expense, {status: Leafe::APPROVED}

        can :manage, AllocatedLeafe, :all

        can :manage, Attendance, :all

        can :manage, Leafe, :all
        cannot :destroy, Leafe, {status: Leafe::APPROVED}

        can :manage, Income, :all

      else
        can :update, User, {user_id: user.id}

        can :manage, Expense, {user_id: user.id}
        cannot :manage, Expense, {status: Leafe::REJECTED}
        cannot :manage, Expense, {status: Leafe::APPROVED}
        cannot :approve, Expense, {user_id: user.id}
        cannot :reject, Expense, {user_id: user.id}
        cannot :show_all_pending, User, :all
        cannot :approve, Expense, :all

        can :show_all, AllocatedLeafe, {user_id: user.id}
        cannot :manage, AllocatedLeafe, :all

        can :create, Attendance, {user_id: user.id}
        can :update, Attendance, {user_id: user.id}

        can :manage, Leafe, {user_id: user.id, status: Leafe::PENDING}
        can :read, Leafe, {user_id: user.id, status: Leafe::APPROVED}
        can :read, Leafe, {user_id: user.id, status: Leafe::REJECTED}
        cannot :edit, Leafe, {status: Leafe::APPROVED}
        cannot :edit, Leafe, {status: Leafe::REJECTED}
        cannot :destroy, Leafe, {status: Leafe::APPROVED}
        cannot :destroy, Leafe, {status: Leafe::REJECTED}
        cannot :approve, Leafe, :all
        cannot :reject, Leafe, :all

        can :create, Income
        can :manage, Income, {user_id: user.id, status: Leafe::PENDING}
        can :read, Income, {user_id: user.id, status: Leafe::APPROVED}
        can :read, Income, {user_id: user.id, status: Leafe::REJECTED}
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