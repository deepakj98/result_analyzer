class Api::TestResultsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    result = TestResult.new(test_result_params)

    if result.save
      render json: {
        status: "success",
        message: "Test result recorded successfully",
        data: {
          id: result.id
        }
      }, status: :created
    else
      render json: {
        status: "error",
        message: "Failed to record test result",
        errors: result.errors.full_messages
      }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: {
      status: "error",
      message: "Something went wrong",
      error: e.message
    }, status: :internal_server_error
  end

  private

  def test_result_params
    params.permit(:student_name, :subject, :marks, :timestamp)
  end
end
