#encoding:utf-8
require 'byebug'
A = ['r','g', 'b']
B = ['s','m','l']
C = [1,2,3]
def combine_arrays(*arrays)
  if arrays.empty?
    yield
  else
    first, *rest = arrays
    first.map do |x|
      combine_arrays(*rest) do |*args|
         # puts "x:#{x}"
         # puts "args:#{args}"
         yield x, *args 
      end
    end.flatten
  end
end
puts combine_arrays(A,B){|*args|  args.join(":")}.inspect

# combines = [""]


# # p A.product combines
# p A[1..A.length]

# # p A.product B .product C
# # p combine_arrays(combines, A){|*args|  args.join(":")}
# # require 'whenever'
# require 'digest/md5'

# params = {"payment_type"=>"1", "subject"=>"奥迪A4L定金", "trade_no"=>"2016040521001004100218809908", 
#    "buyer_email"=>"tang.kefu@hotmail.com", "gmt_create"=>"2016-04-05 16:28:00", "notify_type"=>"trade_status_sync", 
#    "quantity"=>"1", "out_trade_no"=>"57037705e56d743772a4a784", 
#    "notify_time"=>"2016-04-05 16:28:01", "seller_id"=>"2088911359320476", "trade_status"=>"TRADE_SUCCESS", "is_total_fee_adjust"=>"N", "total_fee"=>"0.01", "gmt_payment"=>"2016-04-05 16:28:01", "seller_email"=>"lingmoar@163.com", "price"=>"0.01", "buyer_id"=>"2088202278665101", "notify_id"=>"596dad5310e9ff7e383bb501e1b3621gru", "use_coupon"=>"N", "sign_type"=>"MD5", "sign"=>"7922b9828f147a79ea49a921bbc4849c", 
#    "pay"=>{"payment_type"=>"1", "subject"=>"奥迪A4L定金", "trade_no"=>"2016040521001004100218809908", "buyer_email"=>"tang.kefu@hotmail.com", "gmt_create"=>"2016-04-05 16:28:00", "notify_type"=>"trade_status_sync", "quantity"=>"1", "out_trade_no"=>"57037705e56d743772a4a784", "notify_time"=>"2016-04-05 16:28:01", "seller_id"=>"2088911359320476", "trade_status"=>"TRADE_SUCCESS", "is_total_fee_adjust"=>"N", "total_fee"=>"0.01", "gmt_payment"=>"2016-04-05 16:28:01", "seller_email"=>"lingmoar@163.com", "price"=>"0.01", "buyer_id"=>"2088202278665101", 
#    "notify_id"=>"596dad5310e9ff7e383bb501e1b3621gru", "use_coupon"=>"N", "sign_type"=>"MD5", "sign"=>"7922b9828f147a79ea49a921bbc4849c"}}


# params.delete('controller')
# params.delete('action')
# params.delete('sign_type')
# params.delete('pay')

# sign = params.delete('sign')

# string = params.sort.map { |k, v| "#{k}=#{v}" }.join('&')

# p string.gsub!('=>', ':')
# p Digest::MD5.hexdigest(string + 'c3ar4vabkylykx7skxjm6cldarico14w')