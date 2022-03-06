Rails.application.routes.draw do

  devise_for :users

  root 'homes#top'
  get 'home/about' => 'homes#about'

  get '/search' => 'searches#search'

  resources :users, only:[:index,:show, :edit, :update, :destroy]do
    collection do
      post 'confirm' => 'users#confirm' #退会確認画面
      get 'complete' => 'users#complete' #退会完了画面
    end
    resources :calenders, except:[:new, :update]
    resource :relationships, only: [:create, :destroy]do
      collection do
      	get 'followings' => 'relationships#followings', as: 'followings' #フォロー一覧表示
      	get 'followers' => 'relationships#followers', as: 'followers' #フォロワー一覧表示
      end
    end
  end

  resources :recipes do
    collection do
      post 'confirm' => 'recipes#confirm' #レシピ登録確認画面
    end

    resource :favorites, only:[:create, :destroy]
    resources :comments, only:[:create, :destroy]
  end

  resources :recipe_foods, only:[:index, :create, :update, :destroy]do
    collection do
      delete 'destroy_all' => 'recipe_foods#destroy_all' #レシピに使用する材料を全て無くす
    end
  end

  resources :foods, only:[:index, :create, :edit, :update]

  resources :lists, only:[:index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
