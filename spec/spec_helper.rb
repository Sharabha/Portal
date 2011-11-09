require 'rubygems'
require 'spork'
require 'capybara/rspec'

# Silence STDOUT is somehow bugged in 1.9.2
# $stdout can't be reopen
# so it doesn't do anything on at the moment
module SporkHelper
  def self.silence_streams(*streams)
      streams = [STDOUT, STDERR] if streams.empty?
      on_hold = streams.collect{ |stream| stream.dup }
      streams.each do |stream|
        stream.reopen(RUBY_PLATFORM =~ /mswin/ ? 'NUL:' : '/dev/null')
        stream.sync = true
      end
      yield
      true
    ensure
      streams.each_with_index do |stream, i|
        stream.reopen(on_hold[i])
      end
  end
end

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'

  require "rails/application"
  #Spork.trap_method(Rails::Application, :reload_routes!)
  require File.expand_path("../../config/environment", __FILE__)

  # bug in spork disallows to dynamic includes
  Dir[Rails.root.join("spec/support/*.rb")].each{|f| require f}

  require 'rspec/rails'
  require 'shoulda/integrations/rspec2'
  require 'rspec/core/expecting/with_rspec'
  require 'rspec/core/formatters/documentation_formatter'
  require 'rspec/core/formatters/base_text_formatter'
  require 'rspec/core/mocking/with_rspec'
  require 'rspec/core/expecting/with_rspec'
  require 'rspec/expectations'
  require 'rspec/matchers'
  require 'active_support/secure_random'


  # hack of active record threads, so we can use fast transactions in
  # selenium/webkit instead of truncation
  ActiveRecord::ConnectionAdapters::ConnectionPool.class_eval do
    def current_connection_id
      # Thread.current.object_id
      Thread.main.object_id
    end
  end

    Capybara.default_selector = :css

    # NOTE: to use selenium driver simply add :driver => :selenium to your spec
    Capybara.server_port = 7171

    # NOTE: if you don't have enough RAM some specs are most likely to timeout cause of swapping,
    # increase sky
    Capybara.default_wait_time = 5
    Capybara.ignore_hidden_elements = false
    Capybara.default_host = "http://localhost:7171"
    Capybara.app_host = "http://localhost:7171"

  counter = -1
  RSpec.configure do |config|
    config.include Warden::Test::Helpers
    config.use_transactional_fixtures = true

    config.before(:each) do
      config.include Rails.application.routes.url_helpers
      Capybara.reset_sessions!
    end

    config.after(:each) do
      counter += 1
      if counter > 9
        GC.enable
        GC.start
        GC.disable
        counter = 0
      end
    end

    config.after(:suite) do
      counter = 0
    end

  end

  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
end

Spork.each_run do
  GC.disable

  # loading schema and seeds to in-memory storage
  SporkHelper.silence_streams do
    load "#{Rails.root.to_s}/db/schema.rb" # use db agnostic schema by default
    load "#{Rails.root}/db/seeds.rb" # use db seeds as preloaded
  end
end

if Spork.using_spork?
   # reload models in faster way, than turning off class cache:
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
end

