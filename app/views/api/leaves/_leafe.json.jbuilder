json.id           leafe.id
json.user         leafe.user ,:id, :name
json.start_date   full_date(leafe.start_date)
json.end_date     full_date(leafe.end_date)
json.leave_type   leafe.leave_type
json.url          api_leafe_url(leafe, format: :json)