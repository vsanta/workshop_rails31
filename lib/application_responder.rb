class ApplicationResponder < ActionController::Responder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder

  # Uncomment this responder if you want your resources to redirect to the collection
  # path (index action) instead of the resource path for POST/PUT/DELETE requests.
  # include Responders::CollectionResponder

  #have javascript response to behave as to_html. Fix for 3.1 rc4
  #can be used for other formats like :to_iphone :to_html
  alias :to_js :to_html
end
