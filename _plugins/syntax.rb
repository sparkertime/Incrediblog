require 'haml'
require 'haml/html'
require 'httparty'

module Jekyll
  class SyntaxBlock < Liquid::Block
    def initialize(tag_name, language, tokens)
      super
      @language = language
    end

    def render(context)
      code_to_html(super.join,@language)
    end

    def code_to_html(code, language)
      response = HTTParty.post('http://pygments.appspot.com/', :body => {'lang'=>language.strip, 'code'=>code})
      puts "An error occured while processing this #{language} code: #{code}" unless response.success?
      response.body
    end

    def indent(html)
      indented = html.gsub(/\n/, "\n  ")
      "  #{indented}"
    end
  end
end

Liquid::Template.register_tag('syntax', Jekyll::SyntaxBlock)
