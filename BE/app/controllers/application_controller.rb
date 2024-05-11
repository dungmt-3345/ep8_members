class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
  
  protected
  def render_unprocessable_entity_response error, status: :unprocessable_entity
    render json: Errors::ActiveRecordValidation.new(error.record).to_hash, status: status
  end
  
  def render_record_not_found_response error, status: :not_found
    render json: Errors::ActiveRecordNotFound.new(error).to_hash, status: status
  end
end
