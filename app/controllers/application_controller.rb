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

end
