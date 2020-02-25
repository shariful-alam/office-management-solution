class HomeController < ApplicationController

  def index
    if current_user.nil?
      redirect_to new_user_session_path
    end

    @budgets = Budget.group(:year).order(:year).group(:month).order(:month).sum(:expense)
    @updated_budget = {}
    @budgets.each do |budget|
      arr = Array.new
      arr.push(budget.first.first)
      arr.push(Date::MONTHNAMES[budget.first.second])
      @updated_budget[arr] = budget.second
    end



    @months = Date::MONTHNAMES.slice(1, 12)
    @income_arr = Array.new(13, 0)
    @incomes = Income.group('(extract(month from income_date))::integer').sum(:amount)
    Income::MONTHS.each do |m|
      if @incomes[m]
        @income_arr[m] += @incomes[m]
      end
    end

    @expense_arr = Array.new(13, 0)
    @expense = Expense.group('(extract(month from expense_date))::integer').sum(:cost)
    Income::MONTHS.each do |m|
      if @expense[m]
        @expense_arr[m] += @expense[m]
      end
    end
  end
end

