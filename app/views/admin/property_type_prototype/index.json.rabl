node(:draw){@draw}
node(:recordsTotal){ PropertyType.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data",:object_root => false  do  
  attributes :_id, :name
  node(:fields) { |item| item.property_types.map(&:name).join(",")}  
  node(:u_at) {|item| item.u_at.localtime.to_s}
end

node(:data ){[]} if @items.count == 0

