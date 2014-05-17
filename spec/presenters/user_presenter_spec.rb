require 'rspec'

describe UserPresenter do

  let(:user) { build_stubbed(:user, username: 'joe') }
  let(:context) { view }
  let(:presenter) { UserPresenter.new(user, context) }

  describe '#to_s' do
    it "capitalizes username" do
      expect(presenter.to_s).to eq 'Joe'
    end
  end

  describe '#path' do
    it "returns path to user" do
      expect(presenter.path).to eq context.user_path(user)
    end
  end

  describe '#url' do
    it "returns user url" do
      expect(presenter.url).to eq context.user_url(user)
    end
  end

  describe '#link' do
    let(:link) { Capybara::Node::Simple.new(presenter.link(class: 'foo')) }

    it "returns a link to user" do
      expect(link).to have_link 'Joe', href: context.user_path(user)
    end

    it "accepts the same options as link_to" do
      expect(link).to have_selector 'a.foo'
    end

  end

end