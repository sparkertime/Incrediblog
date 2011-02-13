require 'spec_helper'

describe "Authentication" do
  describe "authenticate" do
    before :each do
      AppConfig.stub!(:hashed_password).and_return(BCrypt::Password.create('mypassword'))
    end

    it "should return false when the password doesn't match" do
      Authentication.authenticate('incorrect').should be_false
    end

    it "should return true when the password does match" do
      Authentication.authenticate('mypassword').should be_true
    end
  end
end
