FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user"+Time.now.hash.to_s+"#{n}@example.com"}
    password               "password"
    password_confirmation  "password"
  end

  factory :admin, :parent => :user do
    admin	true
  end

  factory :competition do
    sequence(:name)  {|n| "competition#{n}" }
    association  :organizer, :factory => :user
  end

  factory :judge_membership do
    association :competition
    association :judge, :factory => :user
  end

  factory :guardian_membership do
    association :problem_membership, :factory => :problem_membership
    association :guardian, :factory => :user
  end

  factory :problem do
    sequence(:name)  {|n| "problem#{n}" }
    sequence(:description)  {|n| "desc#{n}" }
    sequence(:points) {|n| n }
    association :author, :factory => :admin
  end

  factory :problem_membership do
    association :competition, :factory => :competition
    association :problem, :factory => :problem
    start_time (DateTime.now - 10.days)
    end_time (DateTime.now + 10.days)
  end

  factory :team do
    association :leader, :factory => :user
    sequence(:name)  {|n| "team#{n}" }
  end

  factory :team_membership do
    association :team
    association :competition
  end

  factory :solution do
    include ActionDispatch::TestProcess
    description "Solution description"
    association :team_membership
    association :problem_membership
    # Something is wrong with that in 1.9.2-head but I can't figure it out now
    # code fixture_file_upload("#{Rails.root}/spec/factories/test.txt", 'text/plain')
  end

  factory :invitation do
    association :team, :factory => :team
    association :user, :factory => :user
  end
end
