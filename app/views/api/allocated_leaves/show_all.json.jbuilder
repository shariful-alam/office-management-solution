json.show_all do
  json.user @allocated_leafe.user.name
  json.pending_leaves do
    json.array! @leaves_pending.each do |pending_leafe|
      json.start_date full_date(pending_leafe.start_date)
      json.end_date full_date(pending_leafe.end_date)
      json.leave_type pending_leafe.leave_type
    end
  end
  json.approved_leaves do
    json.array! @leaves_approved.each do |approved_leafe|
      json.start_date full_date(approved_leafe.start_date)
      json.end_date full_date(approved_leafe.end_date)
      json.leave_type approved_leafe.leave_type
    end
  end
  json.rejected_leaves do
    json.array! @leaves_rejected.each do |rejected_leafe|
      json.start_date full_date(rejected_leafe.start_date)
      json.end_date full_date(rejected_leafe.end_date)
      json.leave_type rejected_leafe.leave_type
    end
  end
end