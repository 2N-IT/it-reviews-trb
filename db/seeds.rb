CATEGORIES = %w(
  'General Programming Principles', 'Design Patterns, Basic of programming',
  '.net', 'c', 'c++', 'c#', 'java', 'javascript', 'php', 'python', 'ruby', 'r', 'scala', 'haskel',
  'elixir', 'erlang'
)

CATEGORIES.each { |category| Category.create!(name: category) }
