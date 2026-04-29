# spec/requests/api/test_results_spec.rb
require 'rails_helper'

RSpec.describe "Api::TestResults", type: :request do
  describe "POST /api/test_results" do
    let(:valid_params) do
      {
        student_name: "John Doe",
        subject: "Math",
        marks: 85,
        timestamp: Time.current
      }
    end

    context "with valid params" do
      it "creates a test result and returns success response" do
        expect {
          post "/api/test_results", params: valid_params
        }.to change(TestResult, :count).by(1)

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)

        expect(json["status"]).to eq("success")
        expect(json["message"]).to eq("Test result recorded successfully")
        expect(json["data"]["id"]).to be_present
      end
    end

    context "with invalid params" do
      it "returns validation errors" do
        invalid_params = valid_params.merge(marks: nil)

        expect {
          post "/api/test_results", params: invalid_params
        }.not_to change(TestResult, :count)

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)

        expect(json["status"]).to eq("error")
        expect(json["message"]).to eq("Failed to record test result")
        expect(json["errors"]).to be_present
      end
    end

    context "when an unexpected error occurs" do
      it "returns internal server error" do
        allow(TestResult).to receive(:new).and_raise(StandardError.new("Boom"))

        post "/api/test_results", params: valid_params

        expect(response).to have_http_status(:internal_server_error)

        json = JSON.parse(response.body)

        expect(json["status"]).to eq("error")
        expect(json["message"]).to eq("Something went wrong")
        expect(json["error"]).to eq("Boom")
      end
    end
  end
end
