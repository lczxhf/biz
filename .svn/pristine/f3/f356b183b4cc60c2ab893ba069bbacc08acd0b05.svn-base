node(:draw){@draw}
node(:recordsTotal){ ShippingRule.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data",:object_root => false  do  
  attributes '_id', 'name', 'post_first_fee', 'express_first_fee'
  node(:updated_at) {|item| item.u_at.localtime.to_s} 
end

node(:data ){[]} if @items.count == 0

