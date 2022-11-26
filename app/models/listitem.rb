class Listitem < ApplicationRecord
	has_many :myItems
	has_many :users, :through => :myItem
	has_many :mobs, :through => :dropitem
end
