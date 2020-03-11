json.extract! budget, :id, :year, :month, :amount, :expense
json.category budget.category.name
json.user budget.user, :id, :name
json.url api_budget_url(budget, format: :json)

