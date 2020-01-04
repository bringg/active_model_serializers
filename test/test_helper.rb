# frozen_string_literal: true
require 'bundler/setup'
require 'minitest/autorun'

require 'active_model_serializers'
require 'action_controller/serialization_test_case'
require 'fixtures/poro'

# Ensure backward compatibility with Minitest 4
Minitest::Test = MiniTest::Unit::TestCase unless defined?(Minitest::Test)

require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'rails-controller-testing'
Rails::Controller::Testing.install

# handle tests with-out rails, quite a patch ;)
module Rails
  class Env
    def test?; true; end
  end

  def self.env
    Env.new
  end
end


module TestHelper
  Routes = ActionDispatch::Routing::RouteSet.new
  Routes.draw do
    get ':controller(/:action(/:id))'
    get ':controller(/:action)'
  end

  ActionController::Base.send :include, Routes.url_helpers
  ActionController::Base.send :include, ActionController::Serialization
end

ActionController::TestCase.class_eval do
  def setup
    @routes = TestHelper::Routes
  end
end
