require 'rspec'

describe AuthenticationPresenter do

  let(:user) { create(:user, username: 'foo' )}
  let(:auth) { create(:authentication, user: user) }


  let(:presenter) { AuthenticationPresenter.new(auth, view) }

  describe '#path' do
    it "returns user_authentication_path" do
     presenter.context = view
     expect(presenter.path).to eq user_authentication_path(user_id: user.to_param, id: auth.to_param)
    end
  end

end