module SnipcartHelper
  require 'uri'
  require 'net/http'
  def snipcart_request()
    url = URI("https://app.snipcart.com/api/orders/")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["authorization"] = 'Basic ' + ENV['SNIPCART_API_KEY']
    request["content-type"] = 'application/x-www-form-urlencoded'
    request["cache-control"] = 'no-cache'

    response = http.request(request)

    return JSON.parse(response.read_body.to_s.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?'))
  end
end
