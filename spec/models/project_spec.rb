require 'spec_helper'

describe Project do
  it "has a valid factory" do
    build(:project).should be_valid
  end
end
