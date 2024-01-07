require "rails_helper"

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'ユーザーの入力が正しい場合の検証' do
      user = User.new(username: 'John Doe', email: 'john@example.com', password: "password", password_confirmation: "password")
      expect(user).to be_valid
    end

    it '名前が入力されていない場合の検証' do
      user = User.new(username: nil, email: 'john@example.com', password: "password", password_confirmation: "password")
      expect(user).not_to be_valid
    end

    it 'メールアドレスが入力されていない場合の検証' do
      user = User.new(username: "John Doe", email: '', password: "password", password_confirmation: "password")
      expect(user).not_to be_valid
    end

    it 'パスワードが入力されていない場合の検証' do
      user = User.new(username: "John Doe", email: 'john@example.com', password: "", password_confirmation: "password")
      expect(user).not_to be_valid
    end
  end
end