json.show_all do
  json.user     @allocated_leafe.user.name
  json.pending_leaves do
    json.array! @leaves_pending, partial: "api/leaves/leafe", as: :leafe
  end
  json.approved_leaves do
    json.array! @leaves_approved, partial: "api/leaves/leafe", as: :leafe
  end
  json.rejected_leaves do
    json.array! @leaves_rejected, partial: "api/leaves/leafe", as: :leafe
  end
end