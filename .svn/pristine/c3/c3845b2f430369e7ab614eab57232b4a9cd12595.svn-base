object(false)
node(:draw){@draw}
node(:recordsTotal){ User.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data",:object_root => false  do  
  attributes :_id, :name, :mob, :score
  node(:updated_at) {|item| item.u_at.strftime("%y-%m-%d %H:%m:%S") if item.u_at}  
  node(:join_at) {|item| item.c_at.strftime("%y-%m-%d %H:%m:%S") if item.c_at}  
end

node(:data ){[]} if @items.count == 0
