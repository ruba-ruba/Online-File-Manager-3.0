class Admin::StatisticsController < ApplicationController

  def index
    @data = Item.statistics
  end
end
