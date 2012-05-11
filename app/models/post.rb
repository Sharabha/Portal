class Post < ActiveRecord::Base
	attr_accessible :title, :content, :competition_id, :publication_date, :active
	attr_protected :user_id
	
	belongs_to :user
	belongs_to :competition
	
	validates_presence_of :title, :content, :user_id, :publication_date, :active
end
