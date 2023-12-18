json.array! @todos do |todo|
  json.extract! todo, :id, :title, :date, :repeat, :day_of_week, :created_at, :updated_at
  json.url api_v1_todo_url(todo, format: :json)
end
