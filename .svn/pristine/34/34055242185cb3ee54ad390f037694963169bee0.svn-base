node(:draw){@draw}
node(:recordsTotal){ Appointment.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data",:object_root => false  do  
  attributes '_id'
  node(:user) {|item| item.name}  
  node(:sales_man) {|item| item.sales_man.name }  
  node(:product) {|item| item.product.name  if item.product}  
  node(:state) {|item| item.get_display :state}  
  node(:updated_at) {|item| item.u_at.localtime.to_s}  
end

node(:data ){[]} if @items.count == 0

