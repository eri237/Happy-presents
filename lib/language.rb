require 'base64'
require 'json'
require 'net/https'

module Language
  class << self
    def get_data(text)
      #byebug
      # APIのURL作成
      api_url = "https://language.googleapis.com/v1beta1/documents:analyzeEntities?key=#{ENV['GOOGLE_API_KEY']}"
      # APIリクエスト用のJSONパラメータ
      params = {
        document: {
          type: 'PLAIN_TEXT',
          language: 'ja',
          content: text
        }
      }.to_json
      # Google Cloud Natural Language APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      # APIレスポンス出力
      #"{ \"key\": \"value\" }"
      #{
      #  key: "value"
      #}
      response_body = JSON.parse(response.body)
      {
        "entities"=>[
          {
            "name"=>"LEGO",
            "type"=>"OTHER",
            "metadata"=>{"wikipedia_url"=>"https://en.wikipedia.org/wiki/Lego", "mid"=>"/m/04ndr"},
            "salience"=>1,
            "mentions"=>[
              {"text"=>{"content"=>"LEGO", "beginOffset"=>-1}, "type"=>"PROPER"}
            ]
          }
        ],
        "language"=>"ja"
      }
      #byebug
      if (error = response_body['error']).present?
        raise error['message']
      else
        #response_body['entities'].each do |entity|
        #  p entity['type']
        #end
        return {
          type: response_body['entities'][0]['type'],
          entities_name: response_body['entities'][0]['name'],
          metadata: response_body['entities'][0]['metadata']
        }
      end
    end
  end
end