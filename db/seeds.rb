puts '‍☠️ Seeding data... ☠️'

pirates = [
  {name: "Blackbeard", age: 35},
  {name: "Bluebeard", age: 40},
  {name: "Long John Silver", age: 39},
  {name: "Dread Pirate Roberts", age: 26}
]

islands = [
  {name: "Ocracoke"},
  {name: "Tortuga"},
  {name: "Bellamy Cay"},
  {name: "Nosy Boraha"},
  {name: "Clare Island"}
]

treasures = ["Spanish gold", "Aztec jewels", "Cursed silver", "Smelly old socks", "Crown jewel", "Love, the greatest treasure of all"]

puts "Seeding pirates..."
pirates.each do |p|
  puts "#{p[:name]}..."
  Pirate.create!(p)
end

puts "Seeding islands..."
islands.each do |i|
  puts "#{i[:name]}..."
  Island.create!(i)
end

puts "Seeding buried treasures..."
treasures.each do |t|
  puts "#{t}..."
  Treasure.create(contents: t, pirate_id: Pirate.order('RANDOM()').first.id, island_id: Island.order('RANDOM()').first.id)
end

puts '☠️ Done seeding! ☠️'
