json.id               expense.id
json.user             expense.user, :id, :name
json.product_name     expense.product_name
json.category         expense.category.name
json.cost             expense.cost
json.expense_date     expense.expense_date
json.url              api_expense_url(expense, format: :json)
