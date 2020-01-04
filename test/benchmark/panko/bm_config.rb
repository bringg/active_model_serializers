# frozen_string_literal: true
require_relative "./benchmarking_support"
require_relative "./app"


Benchmark.run("config_get") do
  ActiveModel::Serializer::CONFIG.key_format
end
