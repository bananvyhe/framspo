class MyItem < ApplicationRecord
	
	scope :sorted, ->{ order(position: :asc) }
  belongs_to :user
  belongs_to :listitem
  acts_as_list 
end
