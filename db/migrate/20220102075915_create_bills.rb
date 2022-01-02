class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.datetime :recorded_at, comment: '记录时间'
      t.integer :in_or_out, comment: '支出还是收入', default: 1
      t.integer :category, comment: '类别'
      t.string :amount, comment: '金额'
      t.text :description, comment: '账目描述'
      t.integer :user_id, comment: "用户id", null: false

      t.timestamps
    end
  end
end
