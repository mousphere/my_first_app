# frozen_string_literal: true

module ApplicationHelper
  def use_turbolinks_cache?
    if @use_turbolinks_cache == false
      "reload"
    else
      ""
      # "no-cache"
    end
  end
end
