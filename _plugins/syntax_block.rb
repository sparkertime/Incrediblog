require 'httparty'

module Jekyll
  class SyntaxBlock < Liquid::Block
    def initialize(tag_name, arguments, tokens)
      super
      @language, @source = arguments.split
    end

    def render(context)
      contents = super.join.strip
      render_code(contents)
    end

    def render_code(contents)
      contents = download_code if contents.blank?
      code_to_html(contents, @language)
    end

    def download_code
      raise "No source or HTML link found" if @source.blank?
      HTTParty.get(@source).body
    end

    def code_to_html(code, language)
      response = HTTParty.post('http://pygments.appspot.com/', :body => {'lang'=>language.strip, 'code'=>code})
      puts "An error occured while processing this #{language} code: #{code}" unless response.success?
      #still need to gsub for '%' so liquid doesn't freak out
      response.body.gsub(/%/, '&#37;')
    end


  end
end

Liquid::Template.register_tag('syntax', Jekyll::SyntaxBlock)
