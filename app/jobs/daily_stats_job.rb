class DailyStatsJob < ApplicationJob
  queue_as :stats

  def perform(date = Date.current)
    DailyStatsCalculator.new(date).call
  end
end
