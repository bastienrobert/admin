module ApplicationHelper
  def cp(p, c)
    if current_page?(p)
      "active " + c
    else
      c
    end
  end
  def tracking_url
    return [
      ['Aucun', ''],
      ['La Poste', 'https://www.laposte.fr/particulier/outils/suivre-vos-envois?code=@']
    ]
  end
  def publicAPI(order)
    products = []
    order['items'].each do |item|
      custom = []
      item['customFields'].each do |c|
        custom.push({
          c['name'].to_sym => c['displayValue']
        })
      end
      products.push({
        id: item['id'],
        name: item['name'],
        price: item['price'],
        total: item['totalPrice'],
        custom: custom
      })
    end
    render json: {
      id: order['invoiceNumber'],
      status: order['status'],
      date: DateTime.parse(order['creationDate']).strftime("%d/%m/%Y"),
      tracking: {
        url: order['trackingUrl'],
        number: order['trackingNumber']
      },
      user: {
        name: order['user']['billingAddressName']
      },
      products: products
    }.to_json
  end
end
