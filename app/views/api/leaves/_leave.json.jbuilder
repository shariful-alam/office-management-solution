json.extract! leave, :id, :start_date, :end_date, :reason, :leave_type, :status
json.user leave.user ,:id, :name
json.url api_leafe_url(leave, format: :json)