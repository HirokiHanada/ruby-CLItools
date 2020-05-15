class User 
  def initialize (id)
    @name = HEALTH_DATA[id][0]
    @weight = HEALTH_DATA[id][1]
    @height = HEALTH_DATA[id][2]
    @password = HEALTH_DATA[id][3]
    @bmi = HEALTH_DATA[id][4].to_i
    @standard_weight = HEALTH_DATA[id][5]
    @diff = HEALTH_DATA[id][6]
    @date = HEALTH_DATA[id][7]
  end
  def bmi_input(zero_argv, first_argv, second_argv, third_argv)
    @zero_argv = zero_argv
    @first_argv = first_argv
    @second_argv = second_argv
    @third_argv = third_argv
    @first_bmi = first_argv.to_i * 10000 / @second_argv.to_i ** 2
    @first_standard_weight = 22 * @second_argv.to_i ** 2 / 10000
    @first_diff = @first_standard_weight - @first_argv.to_i
    @first_date = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    @values = [@zero_argv, @first_argv, @second_argv, @third_argv, @first_bmi, @first_standard_weight, @first_diff, @first_date]
    @header_title = []
    i = 0
    @header_title[i] = @values
    CSV.open("data.csv", "a") do |csv| #csvにデータ保存
      @header_title.count.times do |i|
      csv.add_row(@header_title[i])
      end
    end
  end
  def bmi_output(id) #BMI出力
    if @bmi < 18.5 
      puts "・痩せすぎです。体重を落とさないよう食事をしっかりと取り、バランスのよいカラダを目指しましょう。"
      puts "・日々の食事におけるアドバイス：3食しっかりと、決まった時間に食べましょう。"
      puts "・日々の運動におけるアドバイス：有酸素運動で体調をしっかり整えましょう。"
      puts "・#{@name}さんの健康体重：#{@standard_weight}kg"
      puts "・健康体重まで残り#{@diff}kg"
      puts "・#{@date}時点"
    elsif 18.5 <= @bmi && @bmi < 25
      puts "・普通体重です。この数値を維持しつつ、カラダを引き締めるようにしましょう。"
      puts "・日々の食事におけるアドバイス：3食をバランスよく、決まった時間に食べましょう。"
      puts "・日々の運動におけるアドバイス：腹筋運動やスクワットなど、引き締めたい部分の筋力トレーニングを行いましょう。"
      puts "・#{@name}さんの健康体重：#{@standard_weight}kg"
      puts "・健康体重まで残り#{@diff}kg"
      puts "・#{@date}時点"
    elsif 25 <= @bmi && @bmi < 30
      puts "・肥満レベル1です。軽度の有酸素運動と、食事で体重管理をしていきましょう。"
      puts "・日々の食事におけるアドバイス：3食のうち1食を、ローカロリー食に置き換えましょう。"
      puts "・日々の運動におけるアドバイス：軽度の有酸素運動を行いましょう。"
      puts "・#{@name}さんの健康体重：#{@standard_weight}kg"
      puts "・健康体重まで残り#{@diff}kg"
      puts "・#{@date}時点"
    elsif 30 <= @bmi && @bmi < 35
      puts "・肥満レベル2です。食事と運動の両面から、バランスよくカラダを整えていきましょう。"
      puts "・日々の食事におけるアドバイス：3食のうち1食を、ローカロリー食に置き換えましょう。"
      puts "・日々の運動におけるアドバイス：ウォーキングなどの有酸素運動を20分と、筋力トレーニングをそれぞれ行いましょう。"
      puts "・#{@name}さんの健康体重：#{@standard_weight}kg"
      puts "・健康体重まで残り#{@diff}kg"
      puts "・#{@date}時点"
    elsif 35 <= @bmi
      puts "・肥満レベル3です。食事制限と運動療法の両面からダイエットを行いましょう。また生活習慣病の原因ともなりますので、一度医師の診察を受けることをオススメします。"
      puts "・日々の食事におけるアドバイス：3食のうち1～2食を、ローカロリー食に置き換え、一日の総摂取カロリーをコントロールしましょう。"
      puts "・日々の運動におけるアドバイス：ウォーキングなどの有酸素運動を20分と、筋力トレーニングをそれぞれ行い、また、日常生活でも運動習慣を身につけましょう。"
      puts "・#{@name}さんの健康体重：#{@standard_weight}kg"
      puts "・健康体重まで残り#{@diff}kg"
      puts "・#{@date}時点"
    else
      puts "入力ミスです。"
    end
  end
  def student_status(id)
    puts "名前：#{@name}さん, 体重：#{@weight}kg, 身長：#{@height}cm BMI：#{@bmi}"
  end
  def student_name
    return "#{@name}"
  end
  def student_password
    return "#{@password}"
  end
  def student_weight
    return "#{@weight}"
  end
end

require "csv"
HEALTH_DATA = CSV.read('./data.csv') 
count = HEALTH_DATA.count
hairetu = []
(1..(count - 1)).each do |i|#csvの数分ループするようにする。
  hairetu[i] = User.new(i)
end
if ARGV[2] == nil #ニ回目以降
  (1..count - 1).each do |i|#csvの数分ループするようにする。
    if ARGV[0] == hairetu[i].student_name
      if ARGV[1].to_i == hairetu[i].student_password.to_i
        hairetu[i].student_status(i)
        hairetu[i].bmi_output(i)
      else
        puts "入力ミスです。"
      end
    end
  end
else #初回
  hairetu[count - 1].bmi_input(ARGV[0], ARGV[1].to_i, ARGV[2].to_i, ARGV[3].to_i)
  hairetu[count - 1].bmi_output(count - 1)
end
