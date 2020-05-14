class Tweet < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments
  mount_uploader :image, ImageUploader

  def self.search(search)
    return Tweet.all unless search
    Tweet.where('text LIKE(?)', "%#{search}%")
  end

  def self.search_calender(search_date)
    return Tweet.all unless search_calender
    Tweet.where('created_at LIKE(?)', "%#{search_date}%")
  end


end
