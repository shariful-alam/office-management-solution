json.id income.id
json.user income.user, :id, :name
json.amount income.amount
json.source income.source
json.status income.status
json.url api_income_url(income, format: :json)