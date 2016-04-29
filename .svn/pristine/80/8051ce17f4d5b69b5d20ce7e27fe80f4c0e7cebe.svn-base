node(:draw){@draw}
node(:recordsTotal){ IndexBanner.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data", :object_root => false  do  
  attributes '_id','name', 'desc', 'position'  
  node(:updated_at) {|item| item.u_at.localtime.to_s}  
end

node(:data ){[]} if @items.count == 0

