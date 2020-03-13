json.pending_incomes do
  json.array! @incomes_pending, partial: "api/manage/users/income", as: :income
end

json.approved_incomes do
  json.array! @incomes_approved, partial: "api/manage/users/income", as: :income
end

json.rejected_incomes do
  json.array! @incomes_rejected, partial: "api/manage/users/income", as: :income
end

