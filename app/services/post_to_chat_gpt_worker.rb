class PostToChatGptWorker
    require 'json'

    def initialize(reserve_event, client)
        @reserve_event = reserve_event
        @client = client
    end

    def post_to_chat_gpt
        text = generate_request_text(@reserve_event.input_text)
        response = @client.chat(
            parameters: {
                model: "gpt-3.5-turbo",
                messages: [{ role: "user", content: text }],
            }
        )
        puts text
        answer = response.dig("choices", 0, "message", "content")
        puts "API文章:\n#{answer}"
        json_text = JSON.parse(answer, symbolize_names: true)
        angry_level = ((json_text[:score]).to_i || 1) - 1
        @reserve_event.assign_attributes({
            execution_type: angry_level,
            output_text: json_text[:supplement]
        })
    end

    private
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