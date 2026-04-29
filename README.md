# README
The application processes student test results and performs End-of-Day (EOD) and monthly calculations.

# clone url
`git clone https://github.com/deepakj98/result_analyzer`
####
`cd result_analyzer`

# install dependencies
`bundle install`

# setup database
`rails db:create`
####
`rails db:migrate`

# start redis-server
`redis-server`

# start sidekiq
`bundle exec sidekiq`

# start rails server
`rails s`

# Endpoint
`POST /api/test_results`

# Request exampl
`curl -X POST http://localhost:3000/api/test_results \
  -H "Content-Type: application/json" \
  -d '{
    "student_name": "John Doe",
    "subject": "Math",
    "marks": 85,
    "timestamp": "2026-04-29T10:00:00Z"
  }'`

# Daily Stats Job
Runs every day at 6:00 PM
Groups results by subject
  Calculates:
    daily_low
    daily_high
    result_count

# Monthly average job
executes only if:

It is the Monday of the week that contains the third Wednesday of the month
