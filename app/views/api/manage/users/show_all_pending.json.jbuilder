json.pending_expenses do
  json.array! @all_pending_expenses, partial: "api/expenses/expense", as: :expense
end

json.pending_leaves do
  json.array! @all_pending_leaves, partial: "api/leaves/leafe", as: :leafe
end

json.pending_incomes do
  json.array! @all_pending_incomes, partial: "api/manage/users/income", as: :income
end
