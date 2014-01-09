require 'rubygems'
require 'spork'


Spork.prefork do

  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end
  
  require 'rails/application'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'
  require 'rspec/autorun'
  require 'factory_girl_rails'
  require 'mocha/setup'
  require 'capybara/rspec'
  require 'capybara/rails'
  require 'capybara/dsl'
  require 'database_cleaner'
  require File.dirname(__FILE__) + '/sequences.rb'
  require 'simplecov'
  require "paperclip/matchers"
end

Spork.each_run do

  if ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
    FileNavigator::Application.initialize!

  end

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    config.before(:each) { GC.disable }
    config.after(:each) { GC.enable }
    
    config.include Devise::TestHelpers, :type => :controller
    config.include Capybara::DSL, :type =>:request
    config.include Capybara::RSpecMatchers, :type =>:request
    config.extend ControllerMacros, :type => :controller
    config.include Warden::Test::Helpers, :type =>:request
    config.extend RequestMacros, :type => :request

    RSpec.configure do |config|
      config.include Paperclip::Shoulda::Matchers
    end

    # config.before(:suite) do
    #   DatabaseCleaner.strategy = :transaction
    #   DatabaseCleaner.clean_with :truncation
    # end

    # config.before(:each) do
    #   DatabaseCleaner.start
    # end

    # config.after(:each) do
    #   DatabaseCleaner.clean
    # end


  end
end