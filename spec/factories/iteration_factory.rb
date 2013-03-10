FactoryGirl.define do
  factory :iteration do
    project
    number '7'
    start { Time.now }
    finish { Time.now + 1.day }
    kind 'thing'
  end
end
