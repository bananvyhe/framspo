class User < ApplicationRecord
	has_secure_password
	has_many :todos
	has_one :myItem, :dependent => :destroy
	has_many :listitems, :through => :myItem
	enum role: %i[user manager admin].freeze

	validates :email,
	          format: { with: URI::MailTo::EMAIL_REGEXP },
	          presence: true,
	          uniqueness: { case_sensitive: false }	 
end
