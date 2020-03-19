json.partial! "api/leaves/leafe", leafe: @leafe
json.status           @leafe.status
json.approve_time     full_date_with_time(@leafe.updated_at) if @leafe.approved?