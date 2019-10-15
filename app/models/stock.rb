# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :stock_user, class_name: 'User'
  belongs_to :stocked_article, class_name: 'Article'
  validates :stock_user_id, presence: true
  validates :stocked_article_id, presence: true
end
