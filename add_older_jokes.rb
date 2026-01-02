# Add jokes with older timestamps
Joke.create!(
  quote: 'Why do Java developers wear glasses? Because they cannot C#!',
  author_name: 'Test Author',
  category: 'Programming',
  created_at: 2.months.ago
)

Joke.create!(
  quote: 'A programmer is told to go to hell. He finds the worst part of that statement is the goto.',
  author_name: 'Test Author',
  category: 'Programming',
  created_at: 3.weeks.ago
)

puts "Added jokes with older timestamps"
puts "2 months ago: #{2.months.ago}"
puts "3 weeks ago: #{3.weeks.ago}"