FactoryGirl.define do
  sequence :parameter_name do |n|
    "my_parameter_name#{n}"
  end
end

FactoryGirl.define do
  sequence :parameter_value do |n|
    "my_parameter_value#{n}"
  end
end

FactoryGirl.define do
  factory :parameter do
    name { generate(:parameter_name) }
    value { generate(:parameter_value) }
  end
end
