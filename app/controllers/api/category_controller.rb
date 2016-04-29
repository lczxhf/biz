class Api::CategoryController < Api::ApplicationController
  
  def get_category
    result_code = Settings.success
    records = Category.all.asc(:position)
    category = records.map { |r| { id: r.id, code: r.code, name: r.name } }
    G.t("CategoryController_get_category=>#{{ result_code: result_code, category: category }.to_json}")
    render json: { result_code: result_code, category: category }.to_json
  end

  def show_product  # 根据类别展示商品
    G.t "CategoryController_get_product_params=>#{params}"
    total_page, result = get_product
    render json: { result_code: 1, total_page: total_page, products: result }
  end

  def index
    parent = Category.where(id: params[:pid]).first
    if parent
      render json:{result_code: 1, list: parent.children.desc(:position), level: parent.level}
    else
      render json:{result_code: 1, list: Category.all.desc(:position)}
    end
  end  

  def index_product
    parent = Category.where(code: :product).first
    @items =  parent.children.desc(:position)

    render "index.json"    
  end

  def index_service
    parent = Category.where(code: :service).first

    @items  = parent.children#.map{|c|c.children}.flatten.sort{|x,y|x.order}
    # @items =  parent.children.desc(:order)
    # render "index_service.json"    
    render json: {list:@items.map(&:as_api_json), result_code:1}
  end

  def index_tree

    if params[:root] == 'product'
      parent = Category.where(code: :product).first  
      render json: parent.get_tree and return
    end

    if params[:root] == 'service'
      parent = Category.where(code: :service).first  
      render json: parent.get_tree and return
    end


    if params[:id] != "#"
      parent = Category.find_by_id(params[:id])
      return render json: {children: parent.products.map{|i| {text: i.name, id: i.id }} } unless  parent.products.empty?

      render json: parent.get_tree  and return
    end

    parent = Category.where(code: :service).first 
    parent ||= Category.where(code: :product).first
    # @items =  parent.children.asc(:order)
    render json: parent.get_tree
  end

end
