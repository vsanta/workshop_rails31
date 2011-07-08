#class SlugsController
#  def call env
#    request = ActionDispatch::Request.new env
#    post = Post.find_by_slug!(request.params[:slug])
#    location = "/posts/#{post.id}"
#    [
#      301,
#      {"Location" => location, "Content-Type" => "text/plain"},
#      ["Redirecting to #{location}"]
#    ]
#
#  end
#end

#HTTP aware controller and lighter than ApplicationController
require "profiler"

class SlugsController < ActionController::Metal
  include ActionController::Redirecting
  #include Rails.application.routes.url_helpers
  #executes Profiler before action check
  use Profiler
  def check
    post = Post.find_by_slug!(params[:slug])
    redirect_to "/posts/#{post.id}"
  # redirect_to post_url post
  end


end