# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    day "2014-10-13 18:19:23"
    group "MyString"
    duration 1
    distance 1
    steps 1
    calories 1
  end
end
