module LayoutHelper

  def status_translate(s)
    status = {
      InProgress: 'En cours',
      Processed: 'Traitée',
      Disputed: 'Contestée',
      Shipped: 'Expédiée',
      Delivered: 'Livrée',
      Pending: 'En attente',
      Cancelled: 'Annulée'
    }.with_indifferent_access
    return status[s] ||= ''
  end

  def actions_status(s, id)
    conditions = {
      InProgress: 'Processed',
      Processed: 'Shipped',
      Disputed: 'Cancelled',
      Shipped: 'Delivered',
      Delivered: '',
      Pending: 'InProgress',
      Cancelled: 'InProgress'
    }
    conditions.each do |k, v|
      if s.downcase == k.to_s.downcase
        return button_to status_translate(v), {controller: 'periods', action: 'order_status', token: id, status: v}, method: :post, remote: true
      end
    end
    return ''
  end

end
