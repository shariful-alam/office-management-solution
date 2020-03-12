json.budgets do
  json.array! @budgets, partial: "api/budgets/budget", as: :budget
end

json.budget_amount do
  json.array! @budget_amount.each do |month, amount|
    json.set! "#{Date::MONTHNAMES[month]}" do
      json.month month.to_i
      json.year @year.to_i
      json.url_for_month_budget show_all_api_budgets_url(format: :json)+"?token=#{current_user.token}&month=#{month}&year=#{@year}"
      json.amount amount
      json.expense @budget_expense[month].second
      json.remaining amount - @budget_expense[month].second
      json.url_for_month_expenses show_all_expenses_api_budgets_url(format: :json)+"?token=#{current_user.token}&month=#{month}&year=#{@year}"
    end
  end
end
