class Admin::StatisticsController < ApplicationController

  def index
    images = Item.where("file_file_name like (?)", "%.jpg")
    @images_sum = images.pluck(:file_file_size).inject{|sum, x| sum + x }
    @images_count = images.count

    video = Item.where("file_file_name like (?)", "%.mp4")
    @video_sum = video.pluck(:file_file_size).inject{|sum, x| sum + x }
    @video_count = video.count

    music = Item.where("file_file_name like (?)", "%.mp3")
    @music_sum = music.pluck(:file_file_size).inject{|sum, x| sum + x}
    @music_count = music.count

    texts = Item.where("file_file_name like (?)", "%.txt")
    @texts_sum = texts.pluck(:file_file_size).inject{|sum, x| sum + x}
    @texts_count = texts.count

    maps = Item.where("file_file_name like (?)", "%.csv")
    @maps_sum = maps.pluck(:file_file_size).inject{|sum, x| sum + x}
    @maps_count = maps.count
  end
end