# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# ==
require 'capybara/rspec'
require 'database_cleaner'
require "email_spec"
require 'webmock/rspec'
require 'ffaker'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# == Load core factories and other testing support libreries from Spree core
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/factories'
require 'spree/testing_support/preferences'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/flash'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/order_walkthrough'
require 'spree/testing_support/capybara_ext'

# == Load API helpers
require 'spree/api/testing_support/helpers'
require 'spree/api/testing_support/setup'

require 'paperclip/matchers'


RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"


  # ==
  config.backtrace_exclusion_patterns = [/gems\/activesupport/, /gems\/actionpack/, /gems\/rspec/]
  config.color = true

  # == 

  config.before :suite do
    Capybara.match = :prefer_exact
  end

  config.before(:each) do
    Timecop.return # == for time and date testing
    WebMock.disable!
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end

    DatabaseCleaner.start
    reset_spree_preferences
  end

  config.after(:each) do
    DatabaseCleaner.clean
    # == Set back the currency to USD
    Spree::Config[:currency] = "USD"
  end

  config.include Spree::TestingSupport::Preferences
  config.include Spree::TestingSupport::UrlHelpers
  config.include Spree::TestingSupport::Flash


  config.include Paperclip::Shoulda::Matchers

  config.include Devise::TestHelpers, :type => :controller

  # == Api
  config.include Spree::Api::TestingSupport::Helpers, :type => :controller
  config.extend Spree::Api::TestingSupport::Setup, :type => :controller
  config.include ControllerHacks, :type => :controller
  
  config.before do
    Spree::Api::Config[:requires_authentication] = true
  end

  # config.include Spree::Core::TestingSupport::ControllerRequests, :type => :controller # rails cannot find this, but it can find the following:
  config.include Spree::TestingSupport::ControllerRequests, :type => :controller

  config.include FactoryGirl::Syntax::Methods

  # ==
  config.extend Spree::TestingSupport::AuthorizationHelpers::Request, type: :feature

end
