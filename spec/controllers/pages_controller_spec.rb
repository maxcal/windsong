require 'spec_helper'

describe PagesController do

  describe "GET 'home'" do
    before { get 'home' }
    subject { response }

    it { should be_successful }
    it { should render_template :home }
  end
end
