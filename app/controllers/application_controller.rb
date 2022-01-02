class ApplicationController < ActionController::API

  def render_json_success(data)
    render json: {
        code: 0,
        errorMessage: '',
        data: data
    }
  end

end
