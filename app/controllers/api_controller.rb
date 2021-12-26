class ApiController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_error_handler
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error_hanlder

  protected

  def invalid_error_handler(ex)
    render json: { error: ex.message, code: ex.class.name }, status: :unprocessable_entity
  end

  def not_found_error_hanlder(ex)
    render json: { error: ex.message, code: ex.class.name }, status: :not_found
  end
end
