# frozen_string_literal: true

class RelationshipsController < ApplicationController
  include Common

  before_action :logged_in_user

  def create
    @followed_user = User.find(params[:followed_user_id])
    current_user.follow(@followed_user)
    @follower_counts = Relationship.where(followed_id: @followed_user.id).count

    respond_to do |format|
      format.html { redirect_to @followed_user }
      format.json do
        render json:
                  { relationship: current_user.active_relationships.find_by(followed_id: @followed_user.id),
                    followers: @follower_counts }
      end
    end
  end

  def destroy
    @followed_user = Relationship.find(params[:id]).followed
    current_user.unfollow(@followed_user)
    @follower_counts = Relationship.where(followed_id: @followed_user.id).count

    respond_to do |format|
      format.html { redirect_to @followed_user }
      format.json { render json: { followers: @follower_counts } }
    end
  end
end
