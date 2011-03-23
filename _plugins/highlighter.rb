require 'haml'
require 'haml/html'
require 'net/http'
require 'uri'

module Jekyll
  class SyntaxHighlightTag < Liquid::Block
    def initialize(tag_name, language, tokens)
      super
      @language = language
    end

    def render(context)
      Haml::HTML.new(highlight(super.join,@language)).render
    end

    def highlight(code, language)
      request = Net::HTTP.post_form(URI.parse('http://pygments.appspot.com/'), {'lang'=>language.strip, 'code'=>code})
      puts "An error occured while processing this code: #{code}" if request.code.to_i != 200
      request.body
    end
  end
end

Liquid::Template.register_tag('syntax', Jekyll::SyntaxHighlightTag)
