json.extract! expense, :id, :product_name, :expense_date
json.user expense.user ,:id, :name
json.url expense_url(expense, format: :json)
