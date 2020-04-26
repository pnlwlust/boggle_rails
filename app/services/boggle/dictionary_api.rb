require 'net/https'
# require 'httparty'

module Boggle::DictionaryApi
  # class DictionaryApi

    APP_ID = '7b763070'
    APP_KEY = '04055d832bf5c175164596a57f58ce3a'

    def self.validateWord(searchWord)

      word = searchWord.downcase
      puts "calling api to validate word: ", word
      url = 'https://od-api.oxforddictionaries.com:443/api/v2/lemmas/en/' + word #Callinf oxford dicitonary api
      response = nil
      uri = URI(url)
      use_ssl = true
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = use_ssl
      http.start do |http|
        req = Net::HTTP::Get.new(uri)
        req['app_id'] = APP_ID
        req['app_key'] = APP_KEY
        req['Accept'] = 'application/json'
        response = http.request(req)
        resp = response.body
        puts response.code
        if response.code == '200' && response.message == 'OK'
          return true
        end
        return false
      end
    end
  # end
end