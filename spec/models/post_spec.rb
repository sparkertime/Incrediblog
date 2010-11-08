require 'spec_helper'

describe Post do
  describe "#title" do
    it { should validate_presence_of :title }
  end

  describe "body" do
    it { should validate_presence_of :body }
  end
end
