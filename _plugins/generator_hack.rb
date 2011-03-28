# required to switch cleanup and generate in order to generate files
# see https://github.com/mojombo/jekyll/issues/268
module Jekyll
  class Site
    def process
      self.reset
      self.read
      self.cleanup
      self.generate
      self.render
      self.write
    end
  end
end
