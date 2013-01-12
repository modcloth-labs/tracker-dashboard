module Tracker
  class Base < ActiveResource::Base
    cattr_accessor :site_base
    self.site_base = "https://www.pivotaltracker.com/services/v3"
    self.format = ActiveResource::Formats::XmlFormat
    self.logger = Logger.new(STDOUT)
    self.timeout = 30

    def self.headers
      creds = Credentials.first
      creds ? {"X-TrackerToken" => creds.token} : {}
    end
  end
end
