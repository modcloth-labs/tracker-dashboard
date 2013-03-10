require 'spec_helper'

describe Iteration do
  it "has a valid factory" do
    build(:iteration).should be_valid
  end
end
