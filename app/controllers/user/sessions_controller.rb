require 'wechat/wechat'

class User::SessionsController < ApplicationController
  include RestClient

  def create
    result = WeChat::code2session(params[:code])

    u = User.find_by_wechat_open_id(result[1])

    if u
      render_json_success('afasdfa,反正登录成功了')
    else
      render_json_success('新用户，创建用户')

      # User.create!(account)
    end


  rescue WeChat::WeChatError => e
    render_json_error(e.message)
  end

end
