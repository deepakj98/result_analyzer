class DailyStatsCalculator
  def initialize(date)
    @date = date
  end

  def call
    results = TestResult.where(timestamp: @date.all_day)

    results.group_by(&:subject).each do |subject, records|
      DailyStatistic.upsert(
        {
          date: @date,
          subject: subject,
          daily_low: records.min_by(&:marks).marks,
          daily_high: records.max_by(&:marks).marks,
          result_count: records.count,
          created_at: Time.current,
          updated_at: Time.current
        },
        unique_by: [:date, :subject]
      )
    end
  end
end
