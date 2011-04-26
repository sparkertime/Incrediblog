module Jekyll
  class InlineSyntaxTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "<span class='inline-syntax'>#{@text}</span>"
    end
  end
end

Liquid::Template.register_tag('inline_syntax', Jekyll::InlineSyntaxTag)
