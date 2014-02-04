module FileManager
  module ApiHelpers
    def current_user
      @current_user ||= User.find_by_token(params[:token])
      error! "token is invalid" if @current_user.nil?
      error!("token is expired", 401) if @current_user.expired?
      @current_user
    end
  end
end