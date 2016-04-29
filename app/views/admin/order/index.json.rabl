node(:draw){@draw}
node(:recordsTotal){ Order.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data", :object_root => false  do  
  attributes :_id, :sn, :cash_amount, :consignee, :mobile
  node(:state) {|item| item.get_display :state}    
  node(:created_at) {|item| item.c_at.localtime.to_s}  
end

node(:data ){[]} if @items.count == 0

