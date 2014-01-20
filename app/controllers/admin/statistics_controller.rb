class Admin::StatisticsController < ApplicationController

  def index
    images = Item.where("file_content_type in (?)", Item::IMAGE_TYPES)
    @images_sum = images.sum(:file_file_size)
    @images_count = images.count

    video = Item.where("file_content_type in (?)", Item::VIDEO_TYPES)
    @video_sum = video.sum(:file_file_size)
    @video_count = video.count

    music = Item.where("file_content_type in (?)", Item::MUSIC_TYPES)
    @music_sum = music.sum(:file_file_size)
    @music_count = music.count

    texts = Item.where("file_content_type in (?)", Item::TEXT_TYPES)
    @texts_sum = texts.sum(:file_file_size)
    @texts_count = texts.count

    maps = Item.where("file_content_type in (?)", Item::MAP_TYPES)
    @maps_sum = maps.sum(:file_file_size)
    @maps_count = maps.count

    @total_count = Item.pluck(:file_file_name).count
    @total_sum = Item.pluck(:file_file_size).sum
  end
end
