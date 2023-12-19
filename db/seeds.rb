# db/seeds.rb

# Clear existing data
Todo.delete_all
User.delete_all

# Seed user
kevin = User.create!(email: 'kevin@example.com', password: 'password')

# Seed todos
seed_todos = [
  { title: 'Decorate Christmas Tree', repeat: 'never', date: Date.new(2023, 12, 24), user: kevin },
  # ... other todos ...
]

seed_todos.each do |todo_attrs|
  Todo.create!(todo_attrs)
end

puts 'Database seeded!'
