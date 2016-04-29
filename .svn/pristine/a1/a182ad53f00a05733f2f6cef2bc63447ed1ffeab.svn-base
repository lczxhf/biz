node(:draw){@draw}
node(:recordsTotal){ OptionType.count }
node(:recordsFiltered){ @items.count }

child @items, :root => "data",:object_root => false  do  
  attributes :_id, :name
  node(:option_values) {|item| item.option_values.map(&:name)}
  node(:u_at) {|item| item.u_at.localtime.to_s}
end

node(:data ){[]} if @items.count == 0

