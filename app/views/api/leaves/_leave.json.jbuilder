json.extract! leave, :id, :start_date, :end_date, :reason, :leave_type, :user_id, :status
json.url leafe_url(leave, format: :json)