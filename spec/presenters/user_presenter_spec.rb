# require 'spec_helper'
#
# describe UserPresenter do
#
#
#   let(:controller) do
#
#     ctr = ApplicationController.new
#     ctr.request = view.request
#     ctr
#
#
#   end
#
#   let(:user) { build_stubbed(:user, username: 'joe') }
#   let(:presenter) do
#     UserPresenter.new(user, controller.view_context)
#   end
#
#   describe '#to_s' do
#     it "capitalizes username" do
#       expect(presenter.to_s).to eq 'Joe'
#     end
#   end
#
#   describe '#path' do
#     it "returns path to user" do
#       expect(presenter.path).to eq view.user_path(user)
#     end
#   end
#
#   describe '#url' do
#     it "returns user url" do
#       expect(presenter.url).to eq view.user_url(user)
#     end
#   end
#
#   describe '#link' do
#     let(:link) { Capybara::Node::Simple.new(presenter.link(class: 'foo')) }
#
#     it "returns a link to user" do
#       expect(link).to have_link 'Joe', href: view.user_path(user)
#     end
#
#     it "accepts the same options as link_to" do
#       expect(link).to have_selector 'a.foo'
#     end
#
#   end
#
# end