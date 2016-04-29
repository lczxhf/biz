node(:draw){@draw}
node(:recordsTotal){ Product.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data",:object_root => false  do  
  attributes :_id, :name
  node(:category) {|item| item.category.name  if item.category}    
  node(:state) {|item| item.get_display :state}    
  node(:u_at) {|item| item.u_at.localtime.to_s}
end

node(:data ){[]} if @items.count == 0

