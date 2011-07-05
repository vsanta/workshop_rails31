module AcceptanceExempleGroup
  extend ActiveSupport::Concern

  include Capybara::DSL
  include Capybara::RSpecMatchers
  include Rails.application.routes.url_helpers
  #changes capybara within to work with Active record objects
  include Hermes::Scopes
  #adds select_datetime, select_time and friends
  include Hermes::Actions


  included do
    metadata[:type] = :acceptance
  end
end