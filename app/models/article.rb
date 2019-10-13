# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  default_scope { order(created_at: :desc) }

  # ----- バリデーション -----
  validates :sweet_name, presence: true
  validates :genre, presence: true
  validates :content, presence: true

  mount_uploader :image, ImagesUploader

  def to_param
    genre
  end
end
