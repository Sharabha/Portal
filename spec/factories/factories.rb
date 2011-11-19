Factory.define :user do |u|
  u.sequence(:email) {|n| "user#{n}@example.com"}
  u.password               "password"
  u.password_confirmation  "password"
end

Factory.define :admin, :parent => :user do |a|
  a.admin	true
end

Factory.define :competition do |c|
  c.sequence(:name)  {|n| "competition#{n}" }
  c.association  :organizer, :factory => :user
end

Factory.define :judge_membership do |j|
  j.association :competition
  j.association :judge, :factory => :user
end
