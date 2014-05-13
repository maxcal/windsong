require 'spec_helper'

describe 'application/flash' do

  let(:flash) {{
      notice: 'Hello world!',
      alert: 'Oh Noes!'
  }}

  before do
    render partial: 'application/flash', locals: { flash: flash }
  end

  subject { rendered }
  it { should have_selector 'ul li.flash', exact: 2 }
  it { should have_selector 'ul li.flash.notice', text: 'Hello world!' }
  it { should have_selector 'ul li.flash.alert', text: 'Oh Noes!' }
end