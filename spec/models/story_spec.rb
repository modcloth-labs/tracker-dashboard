require 'spec_helper'

describe Story do
  let(:story) { build(:story) }
  subject { story }

  it 'has a valid factory' do
    subject.should be_valid
  end
end
