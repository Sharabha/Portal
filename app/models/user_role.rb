class UserRole < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => :role_id

  belongs_to :role
  belongs_to :user
end
