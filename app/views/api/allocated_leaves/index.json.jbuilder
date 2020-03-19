json.allocated_leafe do
  json.array! @allocated_leaves, partial: "api/allocated_leaves/allocated_leafe", as: :allocated_leafe
end