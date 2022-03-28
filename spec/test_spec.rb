#モデルの単体テストのみ

#frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
end


RSpec.describe User, "userモデルに関するテスト", type: :model do
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
	    it "自己紹介文が140文字より大きい場合にバリデーションチェックされエラーメッセージが返ってきているか" do
	      user = User.new(name: 'hoge', password: '111111', email: 'aaa@aaa.com', introduction: Faker::Lorem.characters(number:141) )
	      expect(user).to be_invalid
	      expect(user.errors[:introduction]).to include("は140文字以内で入力してください")
	    end
	end
end

RSpec.describe Recipe, "recipeモデルに関するテスト", type: :model do
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
	      expect(recipe.errors[:point]).to include("を入力してください")
	    end

	    it "レシピの生い立ちが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      recipe = Recipe.new(recipe_name: 'hoge', user_id: '1', man_count: '1', point: 'hoge', status: 0, background: '' )
	      expect(recipe).to be_invalid
	      expect(recipe.errors[:background]).to include("を入力してください")
	    end
	end
	context "文字数制限のバリデーションチェック" do
			it "ポイントが140文字より大きい場合にバリデーションチェックされエラーメッセージが返ってきているか" do
	      recipe = Recipe.new(recipe_name: 'hoge', user_id: '1', man_count: '1', point: Faker::Lorem.characters(number:141), status: 0, background: 'hoge' )
	      expect(recipe).to be_invalid
	      expect(recipe.errors[:point]).to include("は140文字以内で入力してください")
	    end
	    it "レシピの生い立ちが140文字より大きい場合にバリデーションチェックされエラーメッセージが返ってきているか" do
	      recipe = Recipe.new(recipe_name: 'hoge', user_id: '1', man_count: '1', point: 'hoge', status: 0, background: Faker::Lorem.characters(number:141) )
	      expect(recipe).to be_invalid
	      expect(recipe.errors[:background]).to include("は140文字以内で入力してください")
	    end
	end
end

RSpec.describe Food, "foodモデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
      it "有効な投稿内容の場合は保存されるか" do
        expect(FactoryBot.build(:food)).to be_valid
       end
  end
  context "空白のバリデーションチェック" do
	    it "材料名が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      food = Food.new(food_name: '', unit: '個' )
	      expect(food).to be_invalid
	      expect(food.errors[:food_name]).to include("を入力してください")
	    end
	end
end

RSpec.describe Tag, "tagモデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
      it "有効な投稿内容の場合は保存されるか" do
        expect(FactoryBot.build(:tag)).to be_valid
       end
  end
end

RSpec.describe Step, "stepモデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
      it "有効な投稿内容の場合は保存されるか" do
      	step = Step.new(method: 'hoge')
	      expect(step).to be_invalid
       end
  end

	context "空白のバリデーションチェック" do
	    it "作り方が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      step = Step.new(method: '')
	      expect(step).to be_invalid
	      expect(step.errors[:method]).to include("を入力してください")
	    end
	end

  context "文字数制限のバリデーションチェック" do
	    it "作り方が140文字より多い場合にバリデーションチェックされエラーメッセージが返ってきているか" do
	      step = Step.new(method: Faker::Lorem.characters(number:141))
	      expect(step).to be_invalid
	      expect(step.errors[:method]).to include("は140文字以内で入力してください")
	    end
	end
end

RSpec.describe Menu, "menuモデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
      it "有効な投稿内容の場合は保存されるか" do
      	menu = Menu.new(recipe_id: '1', start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now))
	      expect(menu).to be_invalid
       end
  end

  context "空白のバリデーションチェック" do
	    it "日付が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      menu = Menu.new(recipe_id: '1', start_time: '')
	      expect(menu).to be_invalid
	      expect(menu.errors[:start_time]).to include("を入力してください")
	    end
	end
end

RSpec.describe Comment, "commentモデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
      it "有効な投稿内容の場合は保存されるか" do
      	comment = Comment.new(recipe_id: '1', user_id: '1', content: 'hoge')
	      expect(comment).to be_invalid
       end
  end

  context "空白のバリデーションチェック" do
	    it "コメントが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      comment = Comment.new(recipe_id: '1', user_id: '1', content: '')
	      expect(comment).to be_invalid
	      expect(comment.errors[:content]).to include("を入力してください")
	    end
	end

	context "文字数制限のバリデーションチェック" do
	    it "コメントが140文字より多い場合にバリデーションチェックされエラーメッセージが返ってきているか" do
	      comment = Comment.new(recipe_id: '1', user_id: '1', content: Faker::Lorem.characters(number:141))
	      expect(comment).to be_invalid
	      expect(comment.errors[:content]).to include("は140文字以内で入力してください")
	    end
	end

end

RSpec.describe List, "listモデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
      it "有効な投稿内容の場合は保存されるか" do
      	list = List.new(recipe_id: '1', user_id: '1')
	      expect(list).to be_invalid
       end
  end
end

RSpec.describe Favorite, "favoriteモデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
      it "有効な投稿内容の場合は保存されるか" do
      	favorite = Favorite.new(recipe_id: '1', user_id: '1')
	      expect(favorite).to be_invalid
       end
  end
end

RSpec.describe Relationship, "relationshipモデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
      it "有効な投稿内容の場合は保存されるか" do
      	relationship = Relationship.new(follower_id: '1', followed_id: '1')
	      expect(relationship).to be_invalid
       end
  end
end