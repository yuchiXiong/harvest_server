# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uuid, null: false
      t.string :account, comment: '用户账户名', null: false
      t.string :password_digest, comment: '密码', null: false
      t.string :nick_name, comment: '用户昵称', null: false
      t.string :avatar, comment: '用户头像'
      t.string :wechat_open_id, comment: '微信平台openid'
      t.string :session_key, comment: '微信会话key'

      t.timestamps
    end

    add_index :users, :uuid, unique: true
  end
end
