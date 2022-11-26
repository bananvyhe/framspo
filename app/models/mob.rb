class Mob < ApplicationRecord
	has_many :dropitem
	has_many :listitems, :through => :dropitem
end
