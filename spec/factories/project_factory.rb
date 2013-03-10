FactoryGirl.define do
  sequence :project_name do |n|
    "project_name#{n}"
  end

  factory :project do
    tracker_id       { generate(:tracker_id) }
    name             { generate(:project_name) }
    all_labels       'all_labels'
    enabled_labels   'enabled_labels'
    enabled          true
    current_velocity 4
  end
end
