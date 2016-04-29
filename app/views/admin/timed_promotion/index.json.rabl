object(false)
node(:draw){@draw}
node(:recordsTotal){ TimedPromotion.count }
node(:recordsFiltered){ @items.count }

child @items, :root => 'data', :object_root => false  do
  attributes  '_id','name', 'limit_num_per_user', 'limit_period'
  node (:product) {|item| item.products.map(&:name).join ',' if item.products}
  node (:updated_at) {|item|   item.u_at.strftime("%y-%m-%d %H:%m:%S") if item.u_at }
end

node(:data ){[]} if @items.count == 0