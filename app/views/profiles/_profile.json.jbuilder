json.extract! profile, :id, :user_id, :gender, :age, :date_of_birth, :city, :country, :subscribe, :created_at, :updated_at
json.url profile_url(profile, format: :json)
