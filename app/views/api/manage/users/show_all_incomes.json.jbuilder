json.approved_incomes do
  json.array! @incomes_approved do |income|
    json.id income.id
    json.user income.user, :id, :name
    json.amount income.amount
    json.source income.source
    json.status income.status
    json.url api_income_url(income, format: :json)
  end
end

json.pending_incomes do
  json.array! @incomes_pending do |income|
    json.id income.id
    json.user income.user, :id, :name
    json.amount income.amount
    json.source income.source
    json.status income.status
    json.url api_income_url(income, format: :json)
  end
end

json.rejected_incomes do
  json.array! @incomes_rejected do |income|
    json.id income.id
    json.user income.user, :id, :name
    json.amount income.amount
    json.source income.source
    json.status income.status
    json.url api_income_url(income, format: :json)
  end
end

