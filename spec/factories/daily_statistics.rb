FactoryBot.define do
  factory :daily_statistic do
    date { Date.current }
    subject { "Math" }
    daily_low { 40 }
    daily_high { 90 }
    result_count { 10 }
  end
end
