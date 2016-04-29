
child @items, :root => "list",:object_root => false  do  
  attributes :_id, :cash_amount, :sn, :state_name, :ori_amount, :c_at, :pay_state,:shipping_state,:state, :comment_state, :express_sn

  node(:products){ |item| item.order_products.map(&:api_json) }
end

node(:list){[]} if @items.empty?

