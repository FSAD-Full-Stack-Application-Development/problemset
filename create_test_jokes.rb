# Create test jokes with older timestamps
Joke.create!(
  quote: 'Why do programmers prefer dark mode? Because light attracts bugs!',
  author_name: 'Test Author',
  category: 'Programming',
  created_at: 5.days.ago
)

Joke.create!(
  quote: 'How many programmers does it take to change a light bulb? None, that is a hardware problem.',
  author_name: 'Test Author',
  category: 'Programming', 
  created_at: 1.week.ago
)

Joke.create!(
  quote: 'There are only 10 types of people in the world: those who understand binary and those who do not.',
  author_name: 'Test Author',
  category: 'Programming',
  created_at: 2.weeks.ago
)

Joke.create!(
  quote: 'A SQL query goes into a bar, walks up to two tables and asks: Can I join you?',
  author_name: 'Test Author', 
  category: 'Database',
  created_at: 1.month.ago
)

puts "Created test jokes with older timestamps"
puts "5 days ago: #{5.days.ago}"
puts "1 week ago: #{1.week.ago}"
puts "2 weeks ago: #{2.weeks.ago}"
puts "1 month ago: #{1.month.ago}"