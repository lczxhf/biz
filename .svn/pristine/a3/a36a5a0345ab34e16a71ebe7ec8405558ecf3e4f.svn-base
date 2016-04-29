module Api::BaseHelper

  def json_error error_code
    {result_code: error_code, error_message: Settings.send("info_#{error_code}")}.as_json
  end
end
