# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }

  example '有効なフォローリレーション' do
    relationship = Relationship.new(follower_id: user1.id, followed_id: user2.id)
    expect(relationship).to be_valid
  end

  context '無効なフォローリレーション' do
    example 'follower_idのみ' do
      relationship = Relationship.new(follower_id: user1.id)
      expect(relationship).not_to be_valid
    end
    example 'followed_idのみ' do
      relationship = Relationship.new(followed_id: user1.id)
      expect(relationship).not_to be_valid
    end
  end

  context 'ユーザーとの依存性チェック' do
    subject { user1.active_relationships.create(followed_id: user2.id) }

    example 'ユーザー削除でフォローリレーションも削除' do
      subject
      expect { user1.destroy }.to change { Relationship.count }.by(-1)
    end

    example 'フォローユーザー削除でフォローリレーションも削除' do
      subject
      expect { user2.destroy }.to change { Relationship.count }.by(-1)
    end
  end
end
