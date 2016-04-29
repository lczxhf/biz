class ActionDispatch::Request
  def real_ip  
    !@env['HTTP_X_REAL_FORWARDED_FOR'].blank? ? @env['HTTP_X_REAL_FORWARDED_FOR'] : remote_ip  
  end  
end  