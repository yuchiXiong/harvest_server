# frozen_string_literal: true

module WeChat
  include RestClient

  APP_ID     = Rails.application.credentials[:wechat][:app_id]
  APP_SECRET = Rails.application.credentials[:wechat][:app_secret]

  class WeChatError < StandardError; end

  def self.code2session(code)
    response = RestClient.get("https://api.weixin.qq.com/sns/jscode2session?appid=#{APP_ID}&secret=#{APP_SECRET}&js_code=#{code}&grant_type=authorization_code")
    result   = JSON.parse(response)

    raise WeChatError, result['errmsg'] if result['errmsg']

    [result['session_key'], result['openid']]
  end
end
