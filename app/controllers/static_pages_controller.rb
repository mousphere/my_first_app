# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @articles = Article.all
  end
end
