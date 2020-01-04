require 'active_model/serializable'

module ActiveModel
  # DefaultSerializer
  #
  # Provides a constant interface for all items
  class DefaultSerializer
    include ActiveModel::Serializable

    attr_reader :object

    def initialize(object, options={})
      @object = object
      @wrap_in_array = options[:_wrap_in_array]
    end

    def as_json(options={})
      instrument do
        return [] if @object.nil? && @wrap_in_array
        hash = @object.as_json
        @wrap_in_array ? [hash] : hash
      end
    end

    def self._descriptor
      # TODO: handle dynamics
      descriptor = Panko::SerializationDescriptor.new

      # TODO: create intiailizer in panko for this
      descriptor.attributes = []
      descriptor.aliases = {}

      descriptor.method_fields = []

      descriptor.has_many_associations = []
      descriptor.has_one_associations = []

      descriptor
    end

    alias serializable_hash as_json
    alias serializable_object as_json
  end
end
