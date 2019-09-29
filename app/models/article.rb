class Article < ApplicationRecord
  belongs_to :user
  default_scope { order(created_at: :desc) }
  
  # ----- バリデーション -----
  validates :tourist_attraction, presence: true
  validates :content, presence: true
end
