child @items, :root => "list",:object_root => false  do  
  attributes :_id, :name, :price
  
  node(:thumb){|item| item.get_photos.first.url_for :app unless item.get_photos.empty?}
  
  node(:category) {|item| item.category.name  if item.category}    
end

node(:list){[]} if @items.count == 0