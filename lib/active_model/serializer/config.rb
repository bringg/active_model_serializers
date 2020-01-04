# frozen_string_literal: true
module ActiveModel
  class Serializer
    class Config
      def initialize(data = {})
        @data = data
        reset(@data)
      end


      attr_accessor :embed, :key_format, :embed_in_root, :embed_in_root_key, :embed_namespace, :default_key_type

      def each(&block)
        @data.each(&block)
      end

      def clear
        @data.clear
        reset(@data)
      end

      def method_missing(name, *args)
        name = name.to_s

        return @data[name] if @data.include?(name)
        match = name.match(/\A(.*?)([?=]?)\Z/)
        case match[2]
        when "="
          @data[match[1]] = args.first
        when "?"
          !!@data[match[1]]
        end
      end

      private

      def reset(data)
        @embed = data.fetch('embed', :objects)
        @key_format = data.fetch('key_format', nil)

        @embed_in_root = data.fetch('embed_in_root', nil)
        @embed_in_root_key = data.fetch('embed_in_root_key', nil)
        @embed_namespace = data.fetch('embed_namespace', nil)
        @default_key_type = data.fetch('default_key_type', nil)
      end
    end

    CONFIG = Config.new # :nodoc:
  end
end
