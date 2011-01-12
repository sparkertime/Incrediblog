class PagesController < ApplicationController
  def archives
    @posts = Post.all(:order => 'created_at DESC').group_by {|p| p.created_at.beginning_of_month}
  end
end
