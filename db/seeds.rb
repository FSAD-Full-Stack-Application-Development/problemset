
sample_jokes = [
  {
    author_name: "Anonymous",
    category: "Programming", 
    quote: "There are 10 types of people in the world: those who understand binary and those who don't.",
    created_at: 3.months.ago
  },
  {
    author_name: "Anonymous",
    category: "Programming",
    quote: "Why do programmers prefer dark mode? Because light attracts bugs.",
    created_at: 2.months.ago
  },
  {
    author_name: "Not a Random Guy", 
    category: "AI",
    quote: "I told my computer I needed a break, and it said: 'No problem, I'll go to sleep.'",
    created_at: 6.weeks.ago
  },
  {
    author_name: "Tech Comedian",
    category: "Hardware",
    quote: "My computer's got the Miley Virus. It has stopped twerking.",
    created_at: 3.weeks.ago
  },
  {
    author_name: "Code Ninja",
    category: "Programming", 
    quote: "Programming is like sex: one mistake and you have to support it for the rest of your life.",
    created_at: 2.weeks.ago
  },
  {
    author_name: "Anonymous",
    category: "AI",
    quote: "Machine learning is like teenage sex: everyone talks about it, nobody really knows how to do it, everyone thinks everyone else is doing it, so everyone claims they are doing it.",
    created_at: 1.week.ago
  },
  {
    author_name: "Dev Humor",
    category: "Programming",
    quote: "99 little bugs in the code, 99 little bugs. Take one down, patch it around, 117 little bugs in the code.",
    created_at: 5.days.ago
  },
  {
    author_name: "Sysadmin Joe",
    category: "Hardware", 
    quote: "The problem with troubleshooting is that trouble shoots back.",
    created_at: 2.days.ago
  },
  {
    author_name: "Anonymous",
    category: "Programming",
    quote: "Why do Java developers wear glasses? Because they cannot C#!",
    created_at: 1.day.ago
  },
  {
    author_name: "Code Master",
    category: "Programming",
    quote: "A programmer is told to go to hell. He finds the worst part of that statement is the goto.",
    created_at: 6.hours.ago
  }
]

sample_jokes.each do |joke_attrs|
  Joke.find_or_create_by(quote: joke_attrs[:quote]) do |joke|
    joke.author_name = joke_attrs[:author_name]
    joke.category = joke_attrs[:category]
    joke.created_at = joke_attrs[:created_at]
  end
end

puts "Seeded #{Joke.count} tech jokes!"


