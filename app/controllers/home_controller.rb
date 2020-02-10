class HomeController < ApplicationController

  def index
      if current_user.nil?
        redirect_to new_user_session_path
      end
      @arr = Array.new
      @incomes = Income.all


      @arr << @incomes

      @expenses = Expense.all

      @arr << @expenses
      #raise arr.inspect
      #render json: @arr
  end

  def income_vs_expense
    arr = Array.new
    @incomes = Income.all


    arr << @incomes

    @expenses = Expense.all

    arr << @expenses
    #raise arr.inspect
    render json: arr

  end

end
