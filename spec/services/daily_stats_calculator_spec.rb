RSpec.describe DailyStatsCalculator do
  it "calculates daily stats correctly" do
    create(:test_result, subject: "Math", marks: 40)
    create(:test_result, subject: "Math", marks: 90)

    described_class.new(Date.today).call

    stat = DailyStatistic.find_by(subject: "Math")

    expect(stat.daily_low).to eq(40)
    expect(stat.daily_high).to eq(90)
    expect(stat.result_count).to eq(2)
  end
end
