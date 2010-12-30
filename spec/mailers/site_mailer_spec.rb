require "spec_helper"

describe SiteMailer do
  describe "#contact_email" do
    it "should queue the email for delivery" do
      SiteMailer.contact_email({}).deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "should have the appropriate attributes" do
      email = SiteMailer.contact_email(:sender_name => 'Phil',
        :sender_email => 'phil@phil.com',
        :message => 'Hello, how are you?')

      email.from.should == ['no-reply@citizenparker.com']
      email.to.should == [AppConfig.owner_email]
      email.subject.should == "[#{AppConfig.web_host}] Message from Phil"
      email.body.should =~ /Hello, how are you\?/
    end
  end
end
