# frozen_string_literal: true

require 'wechat/wechat'

module User
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user!
    include RestClient

    def create
      result = WeChat.code2session(params[:code])

      u = User.find_by_wechat_open_id(result[1])

      if u
        u.update(session_key: result[0])
      else
        u = User.create!(
          account: "微信用户#{SecureRandom.hex(3)}",
          nick_name: "微信用户#{SecureRandom.hex(3)}",
          password: SecureRandom.hex(32),
          session_key: result[0],
          wechat_open_id: result[1]
        )
      end

      render_json_success({ jwt: u.jwt })
    rescue WeChat::WeChatError => e
      render_json_error(e.message)
    end
  end
end
