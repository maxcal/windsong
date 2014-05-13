require 'spec_helper'

describe ApplicationHelper do
  describe "#title" do
    it "has the correct default" do
      expect(helper.title).to eq 'Windsong'
    end
    it "prepends @title" do
      @title = 'Foo'
      expect(helper.title).to eq 'Foo | Windsong'
    end
  end
end
