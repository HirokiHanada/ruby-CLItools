class User
  def initialize(zero_argv, first_argv)
    #ヤフオク
    @url_1 = URI.encode("https://auctions.yahoo.co.jp/search/search?p=#{zero_argv}+#{first_argv}&exflg=1&b=1&n=50&s1=featured&o1=d") 
    @xpath1 = [
      "//li[@class='Product'][1]/div[@class='Product__detail']/h3[@class='Product__title']/a[@class='Product__titleLink']", #商品名（ヤフオク）
      "//li[@class='Product'][1]/div[@class='Product__detail']/div[@class='Product__priceInfo']/span[@class='Product__price']/span[@class='Product__priceValue u-textRed']", #ヤフオクの最低価格
    ]
    #メルカリ
    @url_2 = URI.encode("https://www.mercari.com/jp/search/?sort_order=like_desc&keyword=#{zero_argv}+#{first_argv}&status_on_sale=1")
    @xpath2 = [
      "//section[@class='items-box'][1]/a/div[@class='items-box-body']/h3[@class='items-box-name font-2']", #商品名（メルカリ）
      "//section[@class='items-box'][1]/a/div[@class='items-box-body']/div[@class='items-box-num']/div[@class='items-box-price font-5']", #メルカリの最低価格
    ]
    @list = [[@url_1, @xpath1], [@url_2, @xpath2]]
  end
  def scraping
    require 'nokogiri'
    require 'open-uri'
    require 'csv'
    @hairetu = []
    @hairetu[0] = %w[商品名(ヤフオクが上)(メルカリが下) 価格(ヤフオクが上)(メルカリが下)]
    @charset = nil
    @values = []
    i = 1
    @list.each do |data1, data2|
      @values = []
      @html = open(data1) do |f| #URL読み込み
        @charset = f.charset #文字種別を取得
        f.read #htmlを読み込み
      end
      @doc = Nokogiri::HTML.parse(@html, nil, @charset) #取得したhtmlを解析(パース)し、nokogiriドキュメントにして変数docに格納
      for value in data2 do
        @identify = @doc.xpath(value) #取得したhtmlを、nokogiriドキュメントにパースしたdocの、xpathで抜き出したい箇所を、特定。
        @value = @identify.inner_text.delete("\n").delete("円").delete(",").delete("¥") #後に価格の比較がしやすいように余分なものは削除しておく。
        @values.push(@value)
      end
      @hairetu[i] = @values
      i = i + 1
    end
    CSV.open("data.csv", "w") do |csv| #csv出力
      @hairetu.count.times do |i|
      csv.add_row(@hairetu[i])
      end
    end
    @price_data = CSV.read('./data.csv') #価格比較
    @yahoku_name = @price_data[1][0] 
    @yahoku_price = @price_data[1][1]
    @mercari_name = @price_data[2][0]
    @mercari_price = @price_data[2][1]
    puts "・ヤフオク商品名：#{@yahoku_name}"
    puts "・価格：#{@yahoku_price}"
    puts "・メルカリ商品名：#{@mercari_name}"
    puts "・価格：#{@mercari_price}"
    @price_dif =  @yahoku_price.to_i - @mercari_price.to_i
    if @price_dif> 0
      puts "・メルカリの方が#{@price_dif}円安いです。"
    else
      puts "・ヤフオクの方が#{@price_dif.abs}円安いです。"
    end
  end
end

instance = User.new(ARGV[0], ARGV[1])
instance.scraping
