class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: {
      message: "your query could not be completed",
      errors: exception.record.errors}, status: 400
  end

  def render_not_found_response(exception)
    render json: {
      message: "your query could not be completed",
      error: exception.message }, status: 404
  end
end
