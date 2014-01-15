class DuplicatesController < ApplicationController
  # GET /duplicates
  # GET /duplicates.json
  def index
     @items = Item.duplicates
  end
end
