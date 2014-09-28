class StatisticSerializer < ActiveModel::Serializer
  attributes :positive_count, :negative_count, :count
end
