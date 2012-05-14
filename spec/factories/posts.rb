# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
      title "MyString"
      content "MyText"
      publication_date "2012-05-11 18:36:49"
      active false
      user_id 1
      competition_id 1
    end
end