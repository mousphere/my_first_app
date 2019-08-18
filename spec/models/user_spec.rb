require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)  { User.new(params) }
  let(:params) { { name: 'hogehoge', email: 'test@test.com',
                   password: 'a' * 8, password_confirmation: 'a' * 8 } }
                   
  context '有効なユーザー情報' do
    example 'テストケースの有効性確認' do
      expect(user).to be_valid
    end
  end
  
  context '無効なユーザー情報' do
    context '1. ユーザー名が無効' do
      
      example 'ユーザー名が入力されていない' do
        user.name = ''
        expect(user).not_to be_valid
      end
      
      example 'ユーザー名が20文字超え' do
        user.name = 'hoge' * 6
        expect(user).not_to be_valid
      end
    end
    
    context '2. メールアドレスが無効' do
      
      example 'メールアドレスが入力されていない' do
        user.email = ''
        expect(user).not_to be_valid
      end
      
      example 'メールアドレスが255文字超え' do
        user.email = 'a' * 247 + '@test.com'
        expect(user).not_to be_valid
      end
      
      example 'ドメインに.以下が記述されていない' do
        user.email = 'test@test'
        expect(user).not_to be_valid
      end
      
      example 'ドメイン名で.が重複している' do
        user.email = 'test@test..com'
        expect(user).not_to be_valid
      end
      
      example '大文字、小文字の区別をしない' do
        user.save
        other_user = user.dup
        other_user.email = 'TesT@tESt.coM'
        expect(other_user).not_to be_valid
      end
    end
    
    context '3. パスワードが無効' do
      
      example 'パスワードが入力されていない' do
        user.password = user.password_confirmation = ''
        expect(user).not_to be_valid
      end
      
      example 'スペースは無効' do
        user.password = user.password_confirmation = ' ' * 10
        expect(user).not_to be_valid
      end
      
      example 'パスワードが８文字未満' do
        user.password = user.password_confirmation = 'a' * 7
        expect(user).not_to be_valid
      end
    end
  end
end
