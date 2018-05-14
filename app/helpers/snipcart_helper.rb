module SnipcartHelper

  require 'net/http'

  def snipcart_request(req, params = {}, met = 'GET')

    ## HOW TO USE IT
    # snipcart_request('URL', PARAMS IN A HASH, METHOD)
    #
    # example : snipcart_request('orders/1', {status: 'Cancelled'}, 'PUT')
    # this will set status Cancelled to order with ID 1 using PUT method
    #
    # /!\ If you're using GET method, you can just set your request
    # example : snipcart_request('orders') will use GET method without params, it'll display all your orders

    url = URI("https://app.snipcart.com/api/" + req)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP.const_get(met.capitalize).new(url)
    request["accept"] = 'application/json'
    request["authorization"] = 'Basic ' + ENV['SNIPCART_API_KEY']
    request["content-type"] = 'application/json; charset=UTF-8'
    request["cache-control"] = 'no-cache'
    request.set_form_data(params)

    response = http.request(request)

    print "==========="
    print response.read_body.to_yaml
    print "==========="

    JSON.parse(
      response
        .read_body
        .to_s
      )
  end
end
