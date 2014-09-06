class Status < ActiveRecord::Base
	belongs_to :user, :foreign_key => "user_id"

	validates :content, presence: true, 
							length: { minimum: 2 }

	validates :user_id, presence: true
end
