FactoryGirl.define do
  sequence :story_name do |n|
    "story_#{n}"
  end

  factory :story do
    project
    iteration
    estimate              2
    name                  { generate(:story_name) }
    tracker_id            { generate(:tracker_id) }
    url                   'http://example.com'
    current_state         'active'
    story_type            'story'
    requested_by          'Frank Zappa'
    owned_by              'Dweezil Zappa'
    tracker_labels        'release 13.001'
    tracker_created_at    { Time.now - 1.day }
  end
end
