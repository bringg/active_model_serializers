# frozen_string_literal: true
require_relative "./benchmarking_support"
require_relative "./app"
require_relative "./setup"

class AmsAuthorFastSerializer < ActiveModel::Serializer
  attributes :id, :name
end

class AmsPostFastSerializer < ActiveModel::Serializer
  attributes :id, :body, :title, :author_id, :created_at
end

class AmsPostWithHasOneFastSerializer < ActiveModel::Serializer
  attributes :id, :body, :title, :author_id

  has_one :author, serializer: AmsAuthorFastSerializer
end


data = Benchmark.data
posts = data[:all]

MemoryProfiler.report {
  ActiveModel::ArraySerializer.new(posts, each_serializer: AmsPostWithHasOneFastSerializer).serializable_object
}.pretty_print
