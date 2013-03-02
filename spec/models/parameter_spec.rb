require 'spec_helper'

describe Parameter do
  it 'has a valid factory' do
    build(:parameter).should be_valid
  end
end
