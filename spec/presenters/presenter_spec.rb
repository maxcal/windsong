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

  describe "#path" do

    before do
      context.stub(:mock_path).and_return('/foo')
    end

    it "calls url_for" do
      context.should_receive(:url_for).with(foo: 'bar').once
      presenter.path(foo: 'bar')
    end

  end

  describe "#link" do

    let(:context) { view }

    before do
      context.stub(:url_for).and_return('/foo')
      presenter.stub(:to_s).and_return('Bar')
    end

    def link options = {}
      Capybara::Node::Simple.new(presenter.link(options))
    end

    it "creates a link to resource" do
      expect( link ).to have_link 'Bar', href: '/foo'
    end

    it "creates an link to edit resource" do
      expect( link(action: :edit) ).to have_link 'Edit', href: '/foo'
    end

    it "creates an link to destroy resource" do
      actual = link(action: :destroy)
      a_tag = actual.find('a').native

      expect( actual ).to have_link 'Delete this mock', href: '/foo'
      expect( a_tag.attributes["data-confirm"].value ).to eq "Are you sure you want to destroy this mock?"
    end

    it "creates an link to create a new resource" do
      expect( link(action: :new) ).to have_link 'Create a new mock', href: '/foo'
    end

  end

  describe "#button" do

    let(:context) { view }

    before do
      context.stub(:url_for).and_return('/foo')
      presenter.stub(:to_s).and_return('Bar')
    end

    it "creates a button linking to resource" do
      expect( Capybara::Node::Simple.new(presenter.button) ).to have_selector 'a.button[href="/foo"]'
    end

  end


end