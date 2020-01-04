# frozen_string_literal: true

require 'active_model'
require 'active_model/serializer'
require 'active_model/serializer_support'
require 'active_model/serializer/version'
require 'active_model/serializer/railtie' if defined?(Rails)

begin
  require 'action_controller'
  require 'action_controller/serialization'

  ActiveSupport.on_load(:action_controller) do
    if ::ActionController::Serialization.enabled
      ActionController::Base.include ::ActionController::Serialization

      if defined?(Rails) && Rails.respond_to?(:env) && Rails.env.test?
        require 'action_controller/serialization_test_case'
        ActionController::TestCase.include ::ActionController::SerializationAssertions
      end
    end
  end
rescue LoadError
  # rails not installed, continuing
end
