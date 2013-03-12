FactoryGirl.define do
  factory :credentials do
    auth_password 'password'
    auth_user 'auth user'
    token 'credentials_auth_token'
  end
end
