json.extract! user, :id, :name, :email, :phone, :role, :designation, :target_amount, :bonus_percentage
json.url api_manage_user_url(user, format: :json)