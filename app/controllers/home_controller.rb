class HomeController < ApplicationController

  def index
    if current_user.nil?
      redirect_to new_user_session_path
    else
      @budgets = Budget.group(:year).order(:year).group(:month).order(:month).sum(:expense)
      @updated_budget = {}
      @budgets.each do |budget|
        arr = []
        arr << budget.first.first
        arr << Date::MONTHNAMES[budget.first.second]
        @updated_budget[arr] = budget.second
      end

      @months = Date::MONTHNAMES.slice(1, 12)
      @incomes = Income.group('(extract(month from income_date))::integer').approved.sum(:amount)
      @income_arr = build_array(@incomes)

      @expenses = Expense.group('(extract(month from expense_date))::integer').approved.sum(:cost)
      @expense_arr = build_array(@expenses)
    end
  end




  private

  def build_array(array)
    return_array = Array.new(13, 0)
    Income::MONTHS.each do |month|
      if array[month]
        return_array[month] += array[month]
      end
    end
    return_array
  end

end

