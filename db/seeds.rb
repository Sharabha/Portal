# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
["admin", "organizer", "guardian"].each do |role|
  Role.create(:name => role)
end

admin = User.new(:email => "admin@a.com", :password => "123456")
admin.roles << Role.all

(1..10).each do |i|
  User.create!(:email => "user#{i}@a.com", :password => "123456")
end

