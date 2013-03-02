FactoryGirl.define do
  sequence :label_name do |n|
    "my_label_name#{n}"
  end
end

FactoryGirl.define do
  factory :label do
    name { generate(:label_name) }
  end
end
