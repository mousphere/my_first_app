# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def no_use_turbolinks_cache
    @use_turbolinks_cache = false
  end
end
