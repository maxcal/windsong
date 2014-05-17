require 'spec_helper'

describe Presenter do
  let(:model) { double() }
  let(:context) { double() }
  let(:presenter) { Presenter.new(model, context) }

  it "assigns class name as a instance variable" do
    expect(presenter.mock).to eq model
  end

  it "assigns model to @object" do
    expect(presenter.object).to eq model
  end

  it "assigns context to @context" do
    expect(presenter.context).to eq context
  end

end