object(false)
node(:draw){@draw}
node(:recordsTotal){ AdminUser.count }
node(:recordsFiltered){ @items.count }

child @items, :root => 'data', :object_root => false  do
  attributes  '_id','username', 'role', 'sign_in_count', 'name'
end

node(:data ){[]} if @items.count == 0