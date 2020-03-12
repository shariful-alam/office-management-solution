json.extract! @income, :id, :amount, :income_date, :source, :status
json.user @income.user ,:id, :name
json.url api_income_url(@income, format: :json)