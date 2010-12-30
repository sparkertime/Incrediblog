class SiteMailer < ActionMailer::Base
  default :from => "no-reply@citizenparker.com", :to => AppConfig.owner_email

  def contact_email(contact_options)
    mail(
         :subject => "[#{AppConfig.web_host}] Message from #{contact_options[:sender_name]}"
        )
  end
end
