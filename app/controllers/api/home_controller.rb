class Api::HomeController < Api::ApiController

  before_action :authenticate_user_from_token

  def index
    if current_user.nil?
      render json: {message: "Login Required"}, status: 401
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
      @income_arr = Array.new(13, 0)
      @incomes = Income.group('(extract(month from income_date))::integer').approved.sum(:amount)
      Income::MONTHS.each do |m|
        if @incomes[m]
          @income_arr[m] += @incomes[m]
        end
      end

      @expense_arr = Array.new(13, 0)
      @expense = Expense.group('(extract(month from expense_date))::integer').approved.sum(:cost)
      Income::MONTHS.each do |m|
        if @expense[m]
          @expense_arr[m] += @expense[m]
        end
      end
      render json: {months: @months, budgets: @updated_budget, incomes: @income_arr, expenses: @expense_arr}
    end
  end

end

