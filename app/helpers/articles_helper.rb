# frozen_string_literal: true

module ArticlesHelper
  def google_map_api_src
    google_map_api_key = ENV['GOOGLE_MAP_API_KEY']
    src = "https://maps.googleapis.com/maps/api/js?key=#{google_map_api_key}&callback=showMap"
    src
  end

  def genre_list
    [%w[チョコレート chocolate],
     %w[クッキー cookie],
     %w[アイス ice_cream],
     %w[ケーキ cake],
     %w[その他 etc]]
  end

  def prefecture_list
    [%w[北海道 hokkaido],
     %w[青森県 aomori],
     %w[岩手県 iwate],
     %w[宮城県 miyagi],
     %w[秋田県 akita],
     %w[山形県 yamagata],
     %w[福島県 fukushima],
     %w[茨城県 ibaraki],
     %w[栃木県 tochigi],
     %w[群馬県 gunma],
     %w[埼玉県 saitama],
     %w[千葉県 chiba],
     %w[東京都 tokyo],
     %w[神奈川県 kanagwa],
     %w[新潟県 niigata],
     %w[富山県 toyama],
     %w[石川県 ishikawa],
     %w[福井県 fukui],
     %w[山梨県 yamanashi],
     %w[長野県 nagano],
     %w[岐阜県 gifu],
     %w[静岡県 shizuoka],
     %w[愛知県 aichi],
     %w[三重県 mie],
     %w[滋賀県 siga],
     %w[京都府 kyoto],
     %w[大阪府 osaka],
     %w[兵庫県 hyogo],
     %w[奈良県 nara],
     %w[和歌山県 wakayama],
     %w[鳥取県 tottori],
     %w[島根県 tottori],
     %w[岡山県 okayama],
     %w[広島県 hiroshima],
     %w[山口県 yamaguchi],
     %w[徳島県 tokushima],
     %w[香川県 kagawa],
     %w[愛媛県 ehime],
     %w[高知県 kouchi],
     %w[福岡県 fukuoka],
     %w[佐賀県 saga],
     %w[長崎県 nagasaki],
     %w[熊本県 kumamoto],
     %w[大分県 oita],
     %w[宮崎県 miyazaki],
     %w[鹿児島県 kagoshima],
     %w[沖縄県 okinawa]]
  end
end
