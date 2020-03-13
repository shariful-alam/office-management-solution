json.attendances do
  json.available do
    json.array! @attendances_available.each do |attendance|
      json.user               attendance.user.name
      json.check_in_time      only_time(attendance.created_at)
    end
  end
  json.unavailable do
    json.array! @attendances_unavailable.each do |attendance|
      json.user               attendance.user.name
      json.check_in_time      only_time(attendance.created_at)
      json.check_out_time     only_time(attendance.updated_at)
      json.total_time_spent   distance_of_time_in_words(attendance.updated_at - attendance.created_at)
    end
  end
end
