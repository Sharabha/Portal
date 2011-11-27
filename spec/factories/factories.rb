Factory.define :user do |u|
  u.sequence(:email) {|n| "user"+Time.now.hash.to_s+"#{n}@example.com"}
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

Factory.define :problem do |p|
  p.sequence(:name)  {|n| "problem#{n}" }
  p.sequence(:description)  {|n| "desc#{n}" }
  p.association :author, :factory => :admin
end

Factory.define :problem_membership do |pm|
  pm.association :competition
  pm.association :problem
end
