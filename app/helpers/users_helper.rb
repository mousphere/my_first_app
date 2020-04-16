# frozen_string_literal: true

module UsersHelper
  def number_of_notice(user)
    # 自分の記事がいいねされていて、かつそのcreated_atがlast_access_time より前であること
    number_of_notice = Like.where(liked_article_id: Article.where(user_id: user.id))
                           .where('created_at > ?', user.last_access_time)
                           .count.to_s.tr('0-9', '０-９')
    number_of_notice = '' if number_of_notice == '０'
    number_of_notice
  end

  def image(user)
    image = user.remote_image_url.presence || user.image.presence || 'images.png'
    image
  end
end
