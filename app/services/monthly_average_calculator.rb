class MonthlyAverageCalculator
  MIN_COUNT = 200

  def initialize(date)
    @date = date
  end

  def call
    return unless eligible_monday?

    subjects.each do |subject|
      compute(subject)
    end
  end

  private

  def eligible_monday?
    third_wed = @date.beginning_of_month.to_date.all_month.select(&:wednesday?)[2]
    range = third_wed.beginning_of_week..third_wed.end_of_week

    @date.monday? && range.cover?(@date)
  end

  def subjects
    DailyStatistic.distinct.pluck(:subject)
  end

  def compute(subject)
    stats = []
    total = 0
    days_back = 0

    while total < MIN_COUNT
      stat = DailyStatistic.find_by(date: @date - days_back, subject: subject)
      break unless stat

      stats << stat
      total += stat.result_count
      days_back += 1
    end

    return if stats.empty?

    MonthlyAverage.create!(
      month: @date.beginning_of_month,
      subject: subject,
      avg_low: stats.sum(&:daily_low).to_f / stats.size,
      avg_high: stats.sum(&:daily_high).to_f / stats.size,
      result_count: total
    )
  end
end
