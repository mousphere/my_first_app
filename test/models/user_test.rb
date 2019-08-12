require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "hogehoge", email: "test@test.com",
                    password: "a"*8, password_confirmation: "a"*8)
  end
  
  test "valid user entry" do
    assert @user.valid?
  end
  
  # nameに関するテスト
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  test "name length should be larger than 8" do
    @user.name = "hoge"
    assert_not @user.valid?
  end
  
  test "name length should be smaller than 20" do
    @user.name = "hoge"*6
    assert_not @user.valid?
  end
  
  # emailに関するテスト
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
  test "email length should be smaller than 255" do
    @user.email = "a" * 247 + "@test.com"
    assert_not @user.valid?
  end
  
  test "wrong email address" do
    @user.email = "test@test"
    assert_not @user.valid?
    @user.email = "test@test..com"
    assert_not @user.valid?
  end
  
  test "email address should be unique" do
    @user.save
    @other_user = @user.dup
    assert_not @other_user.valid?
  end
  
  # passwordに関するテスト
  test "password should have a minimum length" do
    @user.password = "a"*7
    assert_not @user.valid?
  end
  
  test "password should be nonbrank" do
    @user.password = " "*8
    assert_not @user.valid?
  end
end
