Rails.application.routes.draw do

  get 'hello_world', to: 'hello_world#index'


  mount Ckeditor::Engine => '/ckeditor'   
  mount ActionCable.server => '/cable'
  
  root to: 'wap/home#index'
  
  devise_for :admin_users, path:'admin', controllers:{
    sessions: :'admin/sessions'
  }

  namespace :admin do
    resources :product
    resources :shop
    resources :order
    resources :express
    resources :pay_config
    resources :timed_promotion
    resources :promotion_rule
    resources :alipay_config
    resources :wxpay_config
    resources :dash_board
    resources :index_banner
    resources :notice
    resources :validate_code    
    
    resources :category do
      post 'batch_action', on: :collection
    end

    resources :user
    resources :admin_user
    resources :photo
    resources :property_type_prototype
    resources :option_type_prototype
    resources :option_type
    resources :property_type
    resources :variant
    resources :shipping_rule
    resources :article
    resources :sales_man
    resources :appointment
    resources :option_value
    resources :prize
    resources :prize_activity
    # resources :lottery
    resources :lottery_order
    resources :lottery_order_item
  end


  namespace :api do
    resources :product do
      get 'get_variant', on: :member
    end   
    resources :favorite_product    
    resources :order do
      get 'webpay', on: :member
      get 'cancel' , on: :member
      post 'confirm' , on: :member
      post 'on_refund', on: :member
    end

    resources :category

    # resources :session
    resources :cart do
      post 'clear', on: :collection
    end

    resources :user do
      post 'upload_avatar', on: :collection
    end
   
     resources :user_address
     resources :temp_order
  end

  namespace :wap do
    resources :session  do
      get 'code_login', on: :collection
    end

    resources :user
    resources :cart
    resources :product
    resources :home
    resources :order do
      get 'pay', on: :member
    end

    resources :user_profile do
      get 'edit_phone', on: :collection
      get 'edit_password', on: :collection
    end

    resources :user_address do
      get 'select', on: :collection
    end
    
    resources :category
    resources :favorite_product
    resources :article
    resources :misc do
      get 'weizhang', on: :collection
    end

    resources :appointment
    resources :express
    resources :prize_activity do
        get "count_result", on: :member
        get "prev_activity", on: :member
        get "participator", on: :member
        get "mywin_record", on: :collection
        get "award_share", on: :member
        get 'evaluate_page', on: :member
        post 'evaluate',on: :member
    end
    resources :lottery_cart
    resources :lottery_order do
        get 'pay', on: :member
        get "web_pay", on: :member
        post "notify", on: :collection
    end
  end

  resources :china_city do
    get 'list', on: :collection
    get 'neighbourList', on: :collection
    get 'get_item_by_name', on: :collection
    post 'grouped_list', on: :collection
  end

  match 'api/sign_up' => 'api/session#register',:via => [:post, :get]
  match 'api/sign_in' => 'api/session#login',:via => [:post, :get]
  match 'api/logout' => 'api/session#logout',:via => [:post, :get]
  match 'api/get_sms' => 'api/session#get_sms',:via => [:post, :get]
  
  match 'upload_pic' => 'upload_pic#index', :via => [:get]
  # match 'banner_index' => 'upload_pic#banner_index',:via=>[:get]
  match 'upload_pic' => 'upload_pic#create', :via => [:post]
  # match 'banner_create' => 'upload_pic#banner_create',:via=>[:post]
  match 'upload_pic/delete' => 'upload_pic#destroy', :via => [:post, :get]
  resources :upload_pic, only: [:destroy]

  match 'api/return_url', to: 'api/pay#alipay_callback', via: [:post, :get]  # callback
  match 'api/notify_url', to: 'api/pay#web_pay_notify', via: [:post, :get]    # 异步通知
  

  get 'api/tree', to: "api/category#index_tree"

  get 'admin', to: 'admin/dash_board#index'

  match '*path', via: :all, to: 'site#no_found'
 
end
