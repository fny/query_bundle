Apple = Class.new(ActiveRecord::Base)
Apple.belongs_to :tree

Banana = Class.new(ActiveRecord::Base)
Banana.belongs_to :tree


Tree = Class.new(ActiveRecord::Base)
Tree.has_many :apples
Tree.has_many :bananas
