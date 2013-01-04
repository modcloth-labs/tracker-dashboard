require File.expand_path('../app', __FILE__)

use Rack::Auth::Basic, "Restricted" do |username, password|
  { 'winston' => 'we<3bluetoo!' }[username] == password
end

run Sinatra::Application
