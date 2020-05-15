class User
  require "csv"
  DORM_DATA = CSV.read('./data.csv')

  def initialize (id)
    @name = DORM_DATA[id][0]
    @number = DORM_DATA[id][1]
    @status = DORM_DATA[id][2]
  end
  def student(id)
    puts "名前：#{@name}, 部屋番号：#{@number}, 状況：#{@status}"
  end
  def check_status
    return "#{@number}"
  end
  def change_status(id)
    if @status == "in"
      DORM_DATA[id][2] = "out"
      CSV.open("data.csv","w") {|f| DORM_DATA.each{|x| f << x} }
      puts "inからoutに変更しました。"
    elsif @status == "out"
      DORM_DATA[id][2] = "in"
      CSV.open("data.csv","w") {|f| DORM_DATA.each{|x| f << x} }
      puts "outからinに変更しました。"
    end
  end
end

hairetu = []
for i in 1..100 do
  hairetu[i] = User.new(i)
end
for i in 1..100 do
  if ARGV[1] == hairetu[i].check_status
    if ARGV[0].to_i == 1 #データ参照
      hairetu[i].student(i)
    elsif ARGV[0].to_i == 2 #ステータス変更
      hairetu[i].change_status(i)
    else
      puts "error"
    end
  end
end
