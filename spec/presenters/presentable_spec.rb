require 'spec_helper'

# Fixtures
class Foo; end

class FooPresenter
  def initialize(*args)
  end
end


describe Presentable do

  describe "#presenter" do

    let(:obj) do
      Foo.new.extend(Presentable)
    end

    it "returns a presenter instance" do
      expect(obj.presenter).to be_a FooPresenter
    end

    it "memoizes presenter" do
      expect(FooPresenter).to receive(:new).once.with(obj, nil).and_call_original
      obj.presenter
      obj.presenter
    end
  end
end