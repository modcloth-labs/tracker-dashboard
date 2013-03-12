require 'spec_helper'

describe Labeling do
  it 'has a valid factory' do
    build(:labeling).should be_valid
  end
end
