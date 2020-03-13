json.allocated_leaves do
    json.leafe_for_year @allocated_leafe.year
    json.user @allocated_leafe.user.name
    json.total_leaves @allocated_leafe.total_leave
    json.used_leaves @allocated_leafe.used_leave
    json.remaining_leaves @allocated_leafe.total_leave - @allocated_leafe.used_leave
    json.personal_leave  @allocated_leaves[:personal]
    json.training_leave @allocated_leaves[:training]
    json.vacation_leave @allocated_leaves[:vacation]
    json.medical_leave @allocated_leaves[:medical]
end
