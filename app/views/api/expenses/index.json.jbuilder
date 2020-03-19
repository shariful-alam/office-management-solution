json.pending_expenses do
  json.array! @pending_expenses, partial: "api/expenses/expense", as: :expense
end

json.approved_expenses do
  json.array! @approved_expenses, partial: "api/expenses/expense", as: :expense
end

json.rejected_expenses do
  json.array! @rejected_expenses, partial: "api/expenses/expense", as: :expense
end
