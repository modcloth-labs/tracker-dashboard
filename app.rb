require 'rubygems'
require 'sinatra'
require 'dalli'
require File.expand_path('../lib/tracker_dashboard', __FILE__)

# ---------------------------------------------------------------------------
# Routes
# ---------------------------------------------------------------------------

get "/data/projects.json" do
  content_type :json

  cache.fetch('data.projects.json') do
    TrackerDashboard::DataLoad.fetch
  end
end

get "/update" do
  cache.set( 'data.projects.json', TrackerDashboard::DataLoad.fetch )
  redirect to('/')
end

get "/" do
  html :index
end

def html(view)
  File.read(File.join('public', "#{view.to_s}.html"))
end

def cache
  @cache ||= Dalli::Client.new
end
