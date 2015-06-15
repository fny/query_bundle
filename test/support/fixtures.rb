apples = [
  # Old Apples
  { name: 'Curie', age: 100 },
  { name: 'Tubman', age: 100 },
  { name: 'Keller', age: 100 },
  { name: 'Nightingale', age: 100 },
  { name: 'Teresa', age: 100 },

  # Young Apples
  { name: 'Sally', age: 10 },
  { name: 'Sherry', age: 10 },
  { name: 'Rachel', age: 10 },
  { name: 'Abby', age: 10 }
]

bananas = [
  # Old Bananas
  { name: 'Ghandi', age: 100 },
  { name: 'Einstein', age: 100 },
  { name: 'Turing', age: 100 },
  { name: 'Frued', age: 100 },
  { name: 'Laozi', age: 100 },

  # Young Bananas
  { name: 'Bob', age: 10 },
  { name: 'Mike', age: 10 },
  { name: 'Jim', age: 10 },
  { name: 'John', age: 10 }
]

apples.each do |apple|
  Apple.find_or_create_by(name: apple[:name]) do |a|
    a.age = apple[:age]
  end
end

bananas.each do |banana|
  Banana.find_or_create_by(name: banana[:name]) do |b|
    b.age = banana[:age]
  end
end
