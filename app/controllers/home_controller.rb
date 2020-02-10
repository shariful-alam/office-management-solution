class HomeController < ApplicationController

  def index
      if current_user.nil?
        redirect_to new_user_session_path
      end
      @arr = Array.new
      @incomes = Income.pluck(:amount)
      #raise @incomes.inspect

      @arr << @incomes

      @expenses = Expense.pluck(:cost)

=begin
      @arr << @expenses
      #raise arr.inspect
=end
      #render json: @incomes
  end

  def income_vs_expense
    arr = Array.new

    january = {}
    january[:label] = "January"
    january[:income] = 50000
    january[:expense] = 50000

    arr << january

    february = {}
    february[:label] = "February"
    february[:income] = 50000
    february[:expense] = 50000

    arr << february
    render json: arr

  end

end
