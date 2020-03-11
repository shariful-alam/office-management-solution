#json.array! @budgets, partial: "api/budgets/budget", as: :budget
json.array! @budget_amount do |budget|
  json.budget_amount [{month: "#{Date::MONTHNAMES[budget.first]}",
                       url_for_month: show_all_api_budgets_url(format: :json)+"?token=#{current_user.token}&month=#{budget.first}&year=#{@year}",
                       amount: budget.second,
                       expense: @budget_expense[budget.first].second,
                       remaining: budget.second - @budget_expense[budget.first].second }]
end