class ApplicationController < ActionController::API
  include ActionController::Caching
  before_action :authenticate_user!

  class UnauthorizedError < StandardError; end

  rescue_from(UnauthorizedError) do |e|
    render_json_error(e, 401)
  end

  def render_json_success(data)
    render json: {
        errorMessage: '',
        data:         data
    }
  end

  def render_json_error(message, code = 500)
    render json: {
        errorMessage: message
    }, status:   code
  end

  private

  def authenticate_user!
    token = request.headers['access-token']
    raise JWT::VerificationError if token.nil? || token.empty?
    @user_uuid = User.find_by_jwt(token)
  rescue JWT::ExpiredSignature
    raise UnauthorizedError.new '当前身份信息已过期'
  rescue JWT::VerificationError
    raise UnauthorizedError.new '当前身份信息无效'
  end

end
