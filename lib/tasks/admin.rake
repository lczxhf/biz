#encoding:utf-8

require "json"
namespace :biz do
    desc "init admin"
    task :init_admin => :environment do
        AdminUser.delete_all

        admin = AdminUser.new 
        admin.email = 'admin@lmoar.com'
        admin.password = '123123123'
        admin.username = '15817378124'
        admin.name = 'admin'
        admin.role = 'admin'

        if admin.save!
            p 'admin init ok.'
        end

        cat_product = Category.create name:'商品', code:'product'
        cat_service = Category.create name:'服务', code:'service'

        first_user = User.create mob:'15817378124', password: '123123123'
    end
end
