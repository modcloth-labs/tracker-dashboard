require 'spec_helper'

describe Label do
  it 'has a valid factory' do
    build(:label).should be_valid
  end

  context 'validations:' do
    it 'is not valid without a name' do
      build(:label, name: nil).should_not be_valid
    end

    it 'is not valid without a unique name' do
      label = create(:label)
      build(:label, name: label.name).should_not be_valid
    end
  end
end
