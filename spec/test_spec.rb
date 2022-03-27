#frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
      it "有効な投稿内容の場合は保存されるか" do
        expect(FactoryBot.build(:user)).to be_valid
       end
  end
  context "空白のバリデーションチェック" do
	    it "名前が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      user = User.new(name: '', password: '111111', email: 'aaa@aaa.com')
	      expect(user).to be_invalid
	      expect(user.errors[:name]).to include("を入力してください")
	    end
	    it "メールアドレスが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      user = User.new(name: 'hoge', password: '111111', email: '')
	      expect(user).to be_invalid
	      expect(user.errors[:email]).to include("を入力してください")
	    end
	    it "パスワードが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      user = User.new(name: 'hoge', password: '', email: 'aaa@aaa.com')
	      expect(user).to be_invalid
	      expect(user.errors[:password]).to include("を入力してください")
	    end
	end
end

RSpec.describe Recipe, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
      it "有効な投稿内容の場合は保存されるか" do
        expect(FactoryBot.build(:recipe)).to be_valid
       end
  end
  context "空白のバリデーションチェック" do
	    it "レシピ名が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      recipe = Recipe.new(recipe_name: '', user_id: '1', man_count: '1', point: 'hoge', status: 0, background: 'hoge' )
	      expect(recipe).to be_invalid
	      expect(recipe.errors[:recipe_name]).to include("を入力してください")
	    end
	    it "ポイントが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      recipe = Recipe.new(recipe_name: 'hoge', user_id: '1', man_count: '1', point: '', status: 0, background: 'hoge' )
	      expect(recipe).to be_invalid
	      expect(recipe.errors[:recipe_name]).to include("を入力してください")
	    end
	    it "レシピ名が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      recipe = Recipe.new(recipe_name: '', user_id: '1', man_count: '1', point: 'hoge', status: 0, background: 'hoge' )
	      expect(recipe).to be_invalid
	      expect(recipe.errors[:recipe_name]).to include("を入力してください")
	    end
	end
end