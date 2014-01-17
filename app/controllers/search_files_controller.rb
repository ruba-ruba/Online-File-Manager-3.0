class SearchFilesController < ApplicationController
  def index
    @q = Item.search(params[:q])
    @items = @q.result(distinct: true)
  end
end
