class Post < ActiveRecord::Base

  validates :title, :presence => true
  validates :body, :presence => true
  
  FORMATS = [:textile, :html]

  def formatted_body
    return ::RedCloth.new(body).to_html if format == :textile
    body
  end

  def format
    (self['format'] || :html).to_sym
  end
end
