require 'spec_helper'

describe Post do
  it "should require a title" do
    p = Factory.build(:post, :title => nil)
    p.valid?
    p.errors[:title].any?.should be_true
  end
end
