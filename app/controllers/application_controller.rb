class ApplicationController < ActionController::API


  def render_json_success(data)
    render json: {
        code:         0,
        errorMessage: '',
        data:         data
    }
  end

  def render_json_error(message)
    render json: {
        code:         500,
        errorMessage: message
    }
  end

  private

  def authenticate_user!
    token = request.headers['access-token']
    raise JWT::VerificationError if token.empty? || token.nil?
    @user_uuid = User.find_by_jwt(token)
  rescue JWT::ExpiredSignature
    return render_json_error('expire')
  rescue JWT::VerificationError
    return render_json_error('error')
  end

end
