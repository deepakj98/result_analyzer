class MonthlyAverageJob < ApplicationJob
  queue_as :stats

  def perform(date = Date.current)
    MonthlyAverageCalculator.new(date).call
  end
end
