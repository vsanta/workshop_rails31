module AcceptanceExempleGroup
  include Capybara::DSL
  include Capybara::RSpecMatchers
  include Rails.application.routes.url_helpers

  def self.included(base)
    base.metadata[:type] = :acceptance
  end
end