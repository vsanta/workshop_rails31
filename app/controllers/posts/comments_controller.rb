class Posts::CommentsController < ApplicationController
  respond_to :html, :js
  before_filter :find_post
  def create
    @comment = @post.comments.build(params[:comment])
    respond_with(@post, @comment, :location => @post) do |format|
      format.html {render "posts/show"} unless @comment.save
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end