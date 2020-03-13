json.id           budget.id
json.category     budget.category.name
json.year         budget.year
json.month        budget.month
json.amount       budget.amount
json.expense      budget.expense
json.remaining    budget.amount - budget.expense
json.user         budget.user, :id, :name
json.url          api_budget_url(budget, format: :json)

