class MyItem < ApplicationRecord
	acts_as_list
  belongs_to :user
  scope :sorted, ->{ order(position: :asc) }
end
