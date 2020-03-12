json.allocated_leaves do
    json.array! @allocated_leaves.each do |allocated_leafe|
      json.id allocated_leafe.id
      json.user allocated_leafe.user.name
      json.total_leaves allocated_leafe.total_leave
      json.used_leaves allocated_leafe.used_leave
      json.remaining_leaves allocated_leafe.total_leave - allocated_leafe.used_leave
      json.url api_allocated_leafe_url(allocated_leafe, format: :json)
    end
end
