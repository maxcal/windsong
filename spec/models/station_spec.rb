require 'spec_helper'

describe Station do

  it { should respond_to :created_at }
  it { should respond_to :updated_at }
  it { should respond_to :location }
  it { should respond_to :slug }
  it { should validate_uniqueness_of :hardware_uid }
  it { should respond_to :presenter }
  it { should respond_to :observations }
  it { should respond_to :events }

end
