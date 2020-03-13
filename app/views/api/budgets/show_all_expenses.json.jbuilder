json.year             @year
json.month            "#{Date::MONTHNAMES[@month]}"
json.total_budget     @total_amount
json.total_expense    @total_expense
json.total_remaining  @total_amount - @total_expense

json.show_all_expenses do
  json.array! @expenses, partial: "api/expenses/expense", as: :expense
end