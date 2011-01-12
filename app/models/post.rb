class Post < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :max_length => 50  

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
