# frozen_string_literal: true
# ! 合并多个账单 CSV 文件为一个 CSV & JSON
# require 'csv'
#
# data_dir = Dir.open('/home/yuchi/data/bills')
# data = []
#
# data_dir.map do |file_name|
#   next if %w(. ..).include? file_name
#   file_data = CSV.read("/home/yuchi/data/bills/#{file_name}", encoding: 'gbk')
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
#
# afile = File.new('/home/yuchi/codes/bubuyu/harvest_server/result.csv', 'w+')
# afile.syswrite("日期,收支类型,类别,金额,备注\n")
# data.each_with_index do |row|
#   afile.syswrite("#{row['日期']},#{row['收支类型']},#{row['类别']},#{row['金额']},#{row['备注']}\n")
# end
# afile.close
#
# afile = File.new('/home/yuchi/codes/bubuyu/harvest_server/data.json', 'w+')
# afile.syswrite(data.to_json)
# afile.close
# puts '数据合并完成'

# ! 将 JSON 文件导入数据库
# data     = JSON.parse(File.open(Rails.root.join('data.json')).read)
# category = data.map { |record| record['类别'] }.uniq
# b = User.first.bills
# data.map do |record|
#   b.create!(
#       recorded_at: Date.parse(record['日期']),
#       in_or_out:   record['收支类型'] == '支出' ? 1 : 2,
#       category:    category.find_index(record['类别']),
#       amount:      record['金额'],
#       description: record['备注'],
#       user_id:     '6c2f47a0-4aae-4cc9-86ff-77e590d0b28b'
#   )
# end

# ! 将 CSV 文件导入数据库
# require 'roo'
#
# xls = Roo::Spreadsheet.open('./bills.xls')
#
# data_source = CSV.parse(xls.to_csv)
# u = User.first
#
# data     = JSON.parse(File.open(Rails.root.join('data.json')).read)
# category = data.map { |record| record['类别'] }.uniq
#
# data_source.each_with_index do |data, index|
#   next if index.zero?
#
#   u.bills.create!(
#       recorded_at: Date.parse(data[1]),
#       in_or_out:   data[2] == '支出' ? 1 : 2,
#       category:    category.find_index(data[4]) || category.size + 1,
#       amount:      data[3],
#       description: data[5],
#       user_id:     '6c2f47a0-4aae-4cc9-86ff-77e590d0b28b'
#   )
# end
