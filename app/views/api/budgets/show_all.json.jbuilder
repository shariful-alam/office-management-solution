json.year             @year
json.month            "#{Date::MONTHNAMES[@month]}"
json.total_budget     @total_amount
json.total_expense    @total_expense
json.total_remaining  @total_amount - @total_expense

json.show_all_budgets do
  json.array! @budgets, partial: "api/budgets/budget", as: :budget
end