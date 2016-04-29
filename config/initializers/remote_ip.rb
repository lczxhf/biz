module ActionDispatch
  class Request

    def remote_ip
      @remote_ip ||= ( @env["HTTP_X_REAL_IP"] || @env["action_dispatch.remote_ip"] || ip || request.env['REMOTE_ADDR']).to_s
    end

  end
end
