require 'spec_helper'

describe Credentials do
  it "has a valid factory" do
    build(:credentials).should be_valid
  end

  describe "validations" do
    it "is not valid without a token" do
      build(:credentials, :token => nil).should_not be_valid
    end
  end
end
