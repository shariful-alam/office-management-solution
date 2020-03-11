json.extract! expense, :id, :product_name, :expense_date,:status
json.user expense.user, :id, :name
json.url api_expense_url(expense, format: :json)

