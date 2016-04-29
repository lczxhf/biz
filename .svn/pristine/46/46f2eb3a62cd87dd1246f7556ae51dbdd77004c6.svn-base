class Api::ProductController < Api::ApplicationController
  def index

    params[:sort] ||= 'desc'
    params[:key] ||= 'u_at'

    if  params[:keyword]
      @items = Product.full_text_search(params[:keyword]).page(@page)
      render "index.json" and return
    end

    if params[:category] and params[:category] != 'undefined'
      category = Category.find_by_id params[:category]
      descendant_ids = category.descendant.map(&:id)

      @items = Product.where(:category_id.in => descendant_ids).send(params[:sort], params[:key]).page(@page)
      render "index.json" and return
    end

    @items = Product.all.send(params[:sort], params[:key]).page(@page)
    
  end

  def show
  end

  def get_variant
    product = Product.find params[:id]
    option_value_ids = OptionValue.where(:id.in =>params[:ids]).map(&:id)

    product.variants.each do |v|
      options = v.option_values.map(&:id)
      if options.sort == option_value_ids.sort
        G.t  v.option_values.map(&:name)
        render json:{result_code: 1, variant: v} and return    
      end
      
    end
    render json:{result_code: 0}
  end

end
