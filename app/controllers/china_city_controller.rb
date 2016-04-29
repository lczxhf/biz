class ChinaCityController < ApplicationController
    def index

    end

    def list
        data  = ChinaCity.list params[:code]
        render json: data
    end

    def neighbourList
        code = '000000'
        if params[:code] =~ /(\d[1-9]|[1-9]\d)0000/
            code = nil
        elsif params[:code] =~ /(\d[1-9]|[1-9]\d)(\d[1-9]|[1-9]\d)00/
            code = params[:code][0, 2] + '0000'
        elsif params[:code] =~ /(\d[1-9]|[1-9]\d)(\d[1-9]|[1-9]\d)(\d[1-9]|[1-9]\d)/
            code = params[:code][0, 4] + '00'
        end
        data  = ChinaCity.list code
        render json: data
    end


    def get_item_by_name
        search = ChinaCity.where(name:Regexp.new(params[:name]))
        if params[:parent_code].present?
            search = search.where(code:params[:parent_code])
        end
        render json: search.first
    end

    def grouped_list
        provinces = ChinaCity.where(code:/\d\d0000/)
        province = provinces.where(name:params[:province]).first || provinces.where(name:'广东省').first

        cities = nil
        if ['110000', '120000', '310000', '500000'].index(province.code.to_s).present?
            cities = ChinaCity.where(code:province.code)
        else
            cities = ChinaCity.where(code:Regexp.new(province.code[0, 2] + '(([1-9]\d)|(\d[1-9]))00') )
        end
        city = cities.where(name:params[:city]).first || cities.where(name:'深圳市').first || cities.first

        districts = nil
        if ['110000', '120000', '310000', '500000'].index(city.code.to_s).present?
            districts = ChinaCity.where(code:Regexp.new(city.code[0, 2] + '\d\d(([1-9]\d)|(\d[1-9]))'), :name.ne => '市辖区')
        else
            districts = ChinaCity.where(code:Regexp.new(city.code[0, 4] + '(([1-9]\d)|(\d[1-9]))'), :name.ne => '市辖区')
        end
        district = districts.where(name:params[:district]).first || districts.first

        render json:{province:province.name, provinces:provinces.map{|x| x.name},
                    city:city.name, cities:cities.map{|x| x.name},
                    district:district.name, districts:districts.map{|x| x.name}}
    end

end
