# encoding: utf-8
class Bills < Thor

  desc "count", "查看当前所有账目总数"
  def count
    puts "当前共有账目 #{Bill.count} 条"
  end

  desc "my_count", "查看指定用户-u的账目总数"
  option :u, :required => true
  def my_count
    u = User.find(options.u)
    puts "用户(id=#{options.u})当前共有账目 #{u.bills.count} 条"
  end

  desc "record", "用户{id=-id}于{-t}{-d}[-o/-i]了账目，金额{-a}"
  option :u, :required => true
  option :t, :required => true
  option :o
  option :i
  option :a, :required => true
  option :d, :default => "recorded by terminal"
  def record
    if options.o && options.i
      puts '类型错误，只能同时为-o/-i中的一个!'
      return
    end

    in_or_out = 2 if options.i
    in_or_out = 1 if options.o

    u = User.find(options.u)

    b = u.bills.create!(
      recorded_at: Time.parse(options.t),
      in_or_out: in_or_out,
      category: 99,
      amount: options.a, 
      description: options.d
    )
    puts "[#{b.created_at}]       #{b.recorded_at.strftime('%Y-%m-%d %H:%M:%S')}#{b.description} #{b.in_or_out === 1 ? '支出' : '收入'}了#{b.amount}元"
  end
end