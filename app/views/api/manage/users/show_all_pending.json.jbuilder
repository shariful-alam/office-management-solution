json.pending_expenses do
  json.array! @all_pending_expenses do |expense|
    json.id expense.id
    json.user expense.user, :id, :name
    json.budget_id expense.budget_id
    json.category_id expense.category_id
    json.product_name expense.product_name
    json.cost expense.cost
    json.details expense.details
    json.expense_date expense.expense_date
    json.status expense.status
    json.url api_expense_url(expense, format: :json)
  end
end

json.pending_leaves do
  json.array! @all_pending_leaves do |leave|
    json.id leave.id
    json.user leave.user, :id, :name
    json.start_date leave.start_date
    json.end_date leave.end_date
    json.reason leave.reason
    json.leave_type leave.leave_type
    json.status leave.status
    json.url api_leafe_url(leave, format: :json)
  end
end

json.pending_incomes do
  json.array! @all_pending_incomes do |income|
    json.id income.id
    json.user income.user, :id, :name
    json.amount income.amount
    json.income_date income.income_date
    json.source income.source
    json.status income.status
    json.url api_income_url(income, format: :json)
  end
end