class Listitem < ApplicationRecord
	has_many :myItems
	has_many :users, :through => :myItems
	has_many :mobs, :through => :dropitems
end
