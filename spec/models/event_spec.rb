require 'spec_helper'

describe Event do

  subject { create(:event) }

  it { should respond_to :created_at }
  it { should respond_to(:key) }
  it { should respond_to(:meta) }

  specify "key should be read-only" do
    expect(subject.attribute_writable?(:key)).to be_false
  end

  specify "meta should be read-only" do
    expect(subject.attribute_writable?(:meta)).to be_false
  end
end
