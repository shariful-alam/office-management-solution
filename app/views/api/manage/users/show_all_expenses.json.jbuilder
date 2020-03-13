json.users_expense @expense_for_user

json.pending_expenses do
  json.array! @pending_expenses do |expense|
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

json.approved_expenses do
  json.array! @approved_expenses do |expense|
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

json.rejected_expenses do
  json.array! @rejected_expenses do |expense|
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