#encoding:utf-8
module Qrcode
    class << self

        def draw title,text, scaling=1
            locals = {size:5, level: :l, title:title,text:text, scaling:scaling}
            view = ActionView::Base.new(Rails.configuration.paths['app/views'])
            view.render partial: '//common/qrcode', locals:locals
        end

        # options
        # => :width, in px, default: 512
        # => :heght, in px, default: 512
        # => :title, image title in info, default: "深圳市灵墨视界科技有限公司"
        # => :dir, file directory, option
        # => :name, image file name, default: "#{Time.now.strftime '%Y%m%d%H%M%S'}#{rand(1000)}"
        # return image file url path
        def img text, options={}
            Rails.logger.info("Qrcode_png_name =>#{options}")
            options[:width] = 512 if options[:width].blank?
            options[:height] = 512 if options[:height].blank?
            options[:title] = "深圳市灵墨视界科技有限公司" if options[:title].blank?

            options['name'] = "#{Time.now.strftime '%Y%m%d%H%M%S'}#{rand(1000)}" if options['name'].blank?

            qr = RQRCode::QRCode.new(text, size:5, level: :l )
            png = qr.to_img         # returns an instance of ChunkyPNG
            png.metadata['Title'] = options[:title]
            png.metadata['Author'] = '深圳市灵墨视界科技有限公司'

            dir = "public/qrcode/#{Time.now.strftime('%Y%m%d')}"
            dir << "/#{options[:dir]}" if options[:dir].present?
            FileUtils.mkpath dir
            Rails.logger.info("create_png_name=>#{options['name']}")
            png_name = Digest::MD5.hexdigest(options['name'])

            # file = png.resize(options[:width], options[:height]).save("#{dir}/#{options[:name]}.png")
            file = png.resize(options[:width], options[:height]).save("#{dir}/#{png_name}.png")
            file.path.sub 'public', ''
        end

    end
end