require 'uri'
require 'net/https'
require 'json'

require 'pushpop'
require 'pushpop-keen'

job 'record bitcoin prices' do

  every 1.minute

  step 'call bitcoinaverage API' do
    uri = URI.parse("https://api.bitcoinaverage.com/all")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.body
  end

  step 'parse body' do |http_response|
    JSON.parse(http_response)
  end

  step 'log to keen' do |hash|
    Keen.publish('bitcoin-prices', hash)
  end

end
