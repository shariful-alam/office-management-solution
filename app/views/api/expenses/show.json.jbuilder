json.partial! "api/expenses/expense", expense: @expense
json.status           @expense.status
json.approve_time     full_date_with_time(@expense.updated_at) if @expense.approved?
