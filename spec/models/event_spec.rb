require 'spec_helper'

describe Event do
  it { should respond_to :created_at }
  it { should respond_to(:key) }
  it { should respond_to(:meta) }

  specify "key should be read-only" do
    event = Event.create(key: :foo)
    expect {
      event.update_attribute(:key, :bar)
    }.to raise_error(Mongoid::Errors::ReadonlyAttribute)
  end
end
