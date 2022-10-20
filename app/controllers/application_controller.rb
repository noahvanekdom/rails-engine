class ApplicationController < ActionController::API
  # rescue_from ActiveRecord::RecordNotFound, with: :no_record

  # def no_record(error)
  #   output = { message: "We could not complete your query", errors: [error.message] }
  #   render json: output
  # end
end
