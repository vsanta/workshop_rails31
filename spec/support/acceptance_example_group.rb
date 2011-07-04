module AcceptanceExempleGroup
  extend ActiveSupport::Concern

  include Capybara::DSL
  include Capybara::RSpecMatchers
  include Rails.application.routes.url_helpers

  included do
    metadata[:type] = :acceptance
  end
end