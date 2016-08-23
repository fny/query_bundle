ActiveRecord::Schema.define do
  self.verbose = false

  create_table :apples, force: true do |t|
    t.string  :name, unique: true
    t.integer :age
  end

  create_table :bananas, force: true do |t|
    t.string  :name, unique: true
    t.integer :age
  end

  create_table :watermelons, force: true do |t|
    t.string  :name, unique: true
    t.integer :age
    t.timestamps
  end
end
