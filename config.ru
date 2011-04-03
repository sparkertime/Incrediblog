require 'bundler/setup'
require 'rack/jekyll'
require './lib/email'

use Emailer
run Rack::Jekyll.new
