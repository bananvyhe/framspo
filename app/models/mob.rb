class Mob < ApplicationRecord
	has_many :dropitems
	has_many :listitems, :through => :dropitems
end
