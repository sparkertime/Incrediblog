require 'sinatra'
require 'pony'
require File.join(File.dirname(__FILE__),'my_email')


class Emailer < Sinatra::Base

  post '/contact' do
    return error if params[:email].nil? || params[:name].nil? || params[:message].nil?
    redirect '/contact.html?success=true'
  end

  def error
    redirect '/contact.html?errors=true'
  end
end
