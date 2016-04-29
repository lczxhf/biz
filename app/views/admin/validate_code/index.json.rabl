node(:draw){@draw}
node(:recordsTotal){ ValidateCode.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data", :object_root => false  do  |it|
  attributes '_id','dest', 'code', 'is_verify'
  
  node(:template) {|item| item.getTemplateName}   
  node(:updated_at) {|item| item.u_at.localtime.to_s}  
end

node(:data ){[]} if @items.count == 0
