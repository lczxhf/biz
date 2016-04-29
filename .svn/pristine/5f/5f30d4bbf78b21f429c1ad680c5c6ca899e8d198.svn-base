node(:draw){@draw}
node(:recordsTotal){ Express.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data",:object_root => false  do  
  attributes :_id, :name, :code
end

node(:data ){[]} if @items.count == 0

