require 'sinatra'
require 'pony'


class Emailer < Sinatra::Base

  post '/contact' do
    return error if params[:email].nil? || params[:name].nil? || params[:message].nil?
    Pony.mail(
      :to =>ENV['EMAIL_TO'],
      :from =>ENV['EMAIL_FROM'],
      :subject =>"[spparker.com] Message from #{params[:email]}", 
      :body => params[:message],
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name => ENV['EMAIL_USERNAME'],
        :password => ENV['EMAIL_PASSWORD'],
        :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
        #:domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
        :domain => 'spparker.com',
      }
    )

    redirect '/contact.html?success=true'
  end

  def error
    redirect '/contact.html?errors=true'
  end
end
