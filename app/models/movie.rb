class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  # validates :poster_image_url,
  #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  validates_processing_of :image
  
  # validate :image_size_validation
 
  # private
  
  # def image_size_validation
  #   errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  # end

  def self.search(search)
    where("title LIKE ? OR director LIKE ?", "%#{search}%", "%#{search}%") 
  end

  def review_average
    if reviews.count > 0
      reviews.sum(:rating_out_of_ten)/reviews.size
    else 
      0
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
