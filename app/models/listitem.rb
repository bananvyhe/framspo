class Listitem < ApplicationRecord
	# has_many :myItems
	has_many :my_items, -> { order(position: :asc) }
	has_many :users, :through => :myItems
	has_many :mobs, :through => :dropitems
end
