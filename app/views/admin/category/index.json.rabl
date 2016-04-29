node(:draw){@draw}
node(:recordsTotal){ Category.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data", :object_root => false  do  |it|
  attributes :_id, :name, :order
  
  node(:updated_at) {|item| item.u_at.to_hms}  
end

node(:data ){[]} if @items.count == 0

