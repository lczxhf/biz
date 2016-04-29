object(false)
node(:draw){@draw}
node(:recordsTotal){ TimedPromotion.count }
node(:recordsFiltered){ @items.count }

child @items, :root => 'data', :object_root => false  do
  attributes  '_id','name', 'threshold', 'value'
  node (:type) {|item| item.get_display :type}
  
  node (:online) {|item| item.online? }
  node (:updated_at) {|item|   item.u_at.strftime("%y-%m-%d %H:%m:%S") if item.u_at }
end

node(:data ){[]} if @items.count == 0