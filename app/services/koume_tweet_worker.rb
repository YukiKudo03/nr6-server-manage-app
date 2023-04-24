class KoumeTweetWorker
    require 'json'
    require 'open-uri'
    require 'nokogiri'

    def initialize(text)
        @tweet = text
    end

    def self.get_koume_tweet
        f = URI.open("https://twitter.com/dayukoume?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor")
        body = f.read
        charset = f.charset
        html = Nokogiri::HTML.parse(body, nil, charset)
        puts html
        text = html.css('span').css("css-901oao css-16my406 r-1tl8opc r-bcqeeo r-qvutc0").first.text
        KoumeTweetWorker.new(text)           
end

    private
        def koume_tweet_url
            "https://twitter.com/dayukoume?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor"
        end

        def generate_request_text(text)
            return "あなたは[プロの感情分析官]です。\n" +
            "以下の制約条件をもとに[入力文を書いた人がどの程度怒っているのか、5段階で]出力してください。\n" +
            "\n" +
            "# 制約条件:\n" +
            "• 出力は次の1、2、3、4、5のうちのいずれかで出力する\n" +
            "  1: 全く怒っていない、あるいはほとんど怒っていない。\n" +
            "  2: 少し怒っている。\n" +
            "  3: 中くらいの怒りを感じている。\n" +
            "  4: かなり怒っている。\n" +
            "  5: 非常に怒っている。\n" +
            "• 以下の形式のJSONで出力する\n" +
            "  {\n" + 
            "    \"score\": 怒り度数（1 ~ 5）,\n" + 
            "    \"supplement\": 補足説明,\n"+
            "  }\n"+
            "\n"+
            "# 入力文：\n" +
            "#{text}\n" +
            "\n" +
            "# 出力文："
        end
end