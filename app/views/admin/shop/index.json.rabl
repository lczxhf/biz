node(:draw){@draw}
node(:recordsTotal){ Shop.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data",:object_root => false  do  
  attributes :_id, :name, :contactor
  node(:address) {|item| item.full_address }
  node(:state) {|item| item.get_display :state}  
  node(:updated_at) {|item| item.u_at.localtime.to_s}  
end

node(:data ){[]} if @items.count == 0

