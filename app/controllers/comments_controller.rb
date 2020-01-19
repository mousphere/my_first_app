# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
end
