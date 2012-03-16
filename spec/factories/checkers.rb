FactoryGirl.define do
  factory :checker do
    association :problem
  end

  factory :checker_data do
    association :checker
    sequence(:input)  {|n| "#{n} #{n+1} #{n+2}"}
    sequence(:output) {|m| "#{m*7}"}
  end
end

