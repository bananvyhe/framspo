class MyItem < ApplicationRecord
	# acts_as_list
  belongs_to :user
  belongs_to :listitem
  # scope :sorted, ->{ order(position: :asc) }
end
