require 'spec_helper'

describe Post do
  describe "#title" do
    it { should validate_presence_of :title }
  end

  describe "body" do
    it { should validate_presence_of :body }
  end

  describe "#formatted_body" do
    it "should return body by default" do
      post = Factory.build(:post)
      post.formatted_body.should == post.body
    end

    it "should return textile-ized text when set to textile" do
      post = Factory.build(:post, :format => :textile, :body => 'hello')
      post.formatted_body.should == '<p>hello</p>'
    end
  end
end
