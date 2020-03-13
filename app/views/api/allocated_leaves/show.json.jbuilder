json.allocated_leaves do
    json.partial! "api/allocated_leaves/allocated_leafe", allocated_leafe: @allocated_leafe
    json.leafe_for_year      @allocated_leafe.year
    json.personal_leave      @allocated_leaves[:personal]
    json.training_leave      @allocated_leaves[:training]
    json.vacation_leave      @allocated_leaves[:vacation]
    json.medical_leave       @allocated_leaves[:medical]
end
