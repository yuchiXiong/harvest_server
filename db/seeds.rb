# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'csv'
#
# data_dir = Dir.open('/home/yuchi/data')
# data = []
#
# data_dir.map do |file_name|
#   next if %w(. ..).include? file_name
#   file_data = CSV.read("/home/yuchi/data/#{file_name}", encoding: 'gbk')
#   col_names = file_data[0]
#
#   file_data.each_with_index do |row, index|
#     next if index.zero?
#     next if row[0].nil?
#     current = {}
#     row.each_with_index do |val, index|
#       if index.zero?
#         current[col_names[index]] = val.gsub(/年/, '/').gsub(/月/, '/').gsub(/日/, '')
#       else
#         current[col_names[index]] = val;
#       end
#     end
#     data.push(current)
#   end
# end
#
# data.sort! { |item1, item2| Time.parse(item2['日期']) <=> Time.parse(item1['日期']) }

# afile = File.new('/home/yuchi/bubuyu/harvest_server/result.csv', 'w+')
# afile.syswrite("日期,收支类型,类别,金额,备注\n")
# data.each_with_index do |row|
#   afile.syswrite("#{row['日期']},#{row['收支类型']},#{row['类别']},#{row['金额']},#{row['备注']}\n")
# end
# afile.close

# afile = File.new('/home/yuchi/bubuyu/harvest_server/data.json', 'w+')
# afile.syswrite(data.to_json)
# afile.close
# puts '数据合并完成'

data     = JSON.parse(File.open(Rails.root.join('data.json')).read)
category = data.map { |record| record['类别'] }.uniq
b = User.first.bills
data.map do |record|
  b.create!(
      recorded_at: Date.parse(record['日期']),
      in_or_out:   record['收支类型'] == '支出' ? 1 : 2,
      category:    category.find_index(record['类别']),
      amount:      record['金额'],
      description: record['备注'],
      user_id:     '6c2f47a0-4aae-4cc9-86ff-77e590d0b28b'
  )
end
