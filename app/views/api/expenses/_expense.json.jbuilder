json.extract! expense, :user_id, :id, :product_name, :expense_date
json.url expense_url(expense, format: :json)