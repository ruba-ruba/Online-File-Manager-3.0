class PusherController < ApplicationController
  def auth
    if params[:user_id]
      user = User.find(params[:user_id])
      auth = Pusher[params[:channel_name]].authenticate(params[:socket_id],
        :user_id => user.id,
      )
      render :json => auth
    else
      render :text => "Not authorized", :status => '403'
    end
  end
end