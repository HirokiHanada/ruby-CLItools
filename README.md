## 【dormitoru_inout-toolについて】  
「他の寮生の部屋状況（いるかいないか）の確認」と「寮生が部屋状況の変更」ができるツール  

### 【これを作ろうと思った理由】  
現在寮生活4年目で、この機能があると特定の寮生が寮にいるか確認したいとき、わざわざ部屋まで行き確認する手間が省けるから。  

### 【今回実装する寮の概要】  
・寮生は100名  
・西棟(W)、東棟(E)に分かれており、それぞれ五階まである。  
・各階10名の寮生が生活している。  
→W101からW110, W201からW210, W301からW310, W401からW410, W501からW510  
→E101からE110, E201からW210, E301からW310, E401からE410, E501からE510  

### 【コマンドラインでの使用方法】  
#### ➀他人の部屋状況を確認したいとき  
→「ruby dormitory_inout.rb 1 部屋番号」という風に入力して実行するとそこに住んでいる寮生が現在いる(in)かいない(out)かわかる。  
コマンドライン第一引数 → 1  
コマンドライン第二引数 → 部屋番号（例: E201）  
「出力例（1 E201の場合）」  
名前：Leroy, 部屋番号：E201, 状況：in  
#### ➁自分の状況を変更したいとき  
→「ruby dormitory_inout.rb 2 部屋番号」という風に入力して実行すると部屋状況の変更ができる。  
コマンドライン第一引数 → 2  
コマンドライン第二引数 → 部屋番号（例: E201）  
「出力例（2 E201の場合）」  
inからoutに変更しました。（実際に書き換わっている。）  
  
  
## 【shape_management-toolについて】  
【体系管理ツール】  

### 【これを作ろうと思った理由】  
コロナウイルスの影響で、外出の機会が減り、運動不足も相まって体型管理がおろそかになってきている人が、周りに増えてきていると感じたから。  

### 【コマンドラインでの使用方法】  
#### ➀自身の状態を知りたいとき（初回時）  
→「ruby health.rb 名前 身長 体重 登録するパスワード（数字のみ）」と入力してEnterキーを押す。  
「出力内容」  
・体系種（痩せすぎ、普通、肥満レベル1、肥満レベル3、肥満レベル3）  
・入力したデータに基づいた、日々の食事面と運動面におけるアドバイス。  
・入力された身長に対する健康体重（BMI22）  
・現状の体重から、健康体重まで残りどのくらいか。  
・入力時の日時  
#### ➁自身の状態を知りたいとき（二回目以降）  
→「ruby health.rb 初回時入力した名前 初回時入力したパスワード」と入力してEnterキーを押す。  
名前とパスワードがcsvファイルの中にあれば、入力者のデータと診断結果を出力。  
「出力内容」  
・入力者の「名前」、「身長」、「体重」、「BMI」  
・➀で出力した内容  
  
  
## 【scraping-toolについて】  
【価格比較ツール】  

## 【これを作ろうと思った理由と詳細】  
・花田家がフリマアプリをよく使うので商品キーワードを入力するだけで、一度に複数サイトの価格比較ができると便利だろうと思ったから。  
・このツールはヤフオクとメルカリで商品キーワードに沿った価格の比較ができるようになっている。  
・このツールは質の高い（ユーザーからの評価が高い）商品という条件を設定した上で、その中で一番価格の安いものを表示する。  

## 【コマンドラインでの使用方法】  
「ruby scraping.rb 商品キーワード1 商品キーワード2」と入力してEnterキーを押す。  
例「ruby scraping.rb どうぶつのもり switch」（商品キーワードは2つまで。1つでも可）。  

## 【出力内容】  
・ヤフオクの方の商品名  
・その価格  
・メルカリの方の商品名  
・その価格  
・どちらの方がいくら安いか  
例（「ruby scraping.rb どうぶつのもり switch」と入力した場合）  
・ヤフオク商品名：★☆【新品 未開封】送料無料 Nintendo Switch Lite 本体 + あつまれどうぶつの森 ソフト /サシアンマゼンタ　☆★  
・価格：40500  
・メルカリ商品名：新品！　任天堂　スイッチ　SWITCH　あつまれ どうぶつの森セット  
・価格：61280  
・ヤフオクの方が20780円安いです。  

