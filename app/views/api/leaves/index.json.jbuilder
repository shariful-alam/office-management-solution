json.pending_leaves do
  json.array! @leaves_pending, partial: "api/leaves/leave", as: :leave
end

json.approved_leaves do
  json.array! @leaves_approved, partial: "api/leaves/leave", as: :leave
end

json.rejected_leaves do
  json.array! @leaves_rejected, partial: "api/leaves/leave", as: :leave
end
