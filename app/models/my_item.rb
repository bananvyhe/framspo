class MyItem < ApplicationRecord
	acts_as_list scope: :listitem

  belongs_to :user
  belongs_to :listitem
  acts_as_list scope: :listitem
 
end
