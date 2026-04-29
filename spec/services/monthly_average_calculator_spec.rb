RSpec.describe MonthlyAverageCalculator do
  it "accumulates until minimum count" do
    create(:daily_statistic, subject: "Math", result_count: 150, daily_low: 40, daily_high: 80, date: Date.today)
    create(:daily_statistic, subject: "Math", result_count: 100, daily_low: 50, daily_high: 90, date: Date.yesterday)

    allow_any_instance_of(described_class).to receive(:eligible_monday?).and_return(true)

    described_class.new(Date.today).call

    avg = MonthlyAverage.last

    expect(avg.result_count).to eq(250)
  end
end
