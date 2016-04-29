node(:draw){@draw}
node(:recordsTotal){ Notice.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data", :object_root => false  do  
  attributes '_id', 'event_count'
  node(:event_type) {|item| item.get_display :event_type}    
  node(:updated_at) {|item| item.u_at.localtime.to_s}  
end

node(:data ){[]} if @items.count == 0

