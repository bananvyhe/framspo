class Listitem < ApplicationRecord
	# has_many :myItems
	has_many :my_items 
	has_many :users, :through => :myItems
	has_many :mobs, :through => :dropitems
	# belongs_to :myItems, ->{ order(position: :asc) }
	acts_as_list scope: :myItems
end
