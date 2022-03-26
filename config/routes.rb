Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  root 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users, only:[:index,:show, :edit, :update]do
    collection do
      get '/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      # 論理削除用のルーティング
      patch '/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
      get '/:id/recipes' => 'users#recipes', as: 'recipes' # ユーザごとのレシピ一覧表示
      get '/:id/favorites' => 'favorites#favorites', as: 'favorites'
    end
    resource :relationships, only: [:create, :destroy]do
      collection do
      	get 'followings' => 'relationships#followings', as: 'followings' #フォロー一覧表示
      	get 'followers' => 'relationships#followers', as: 'followers' #フォロワー一覧表示
      end
    end
    resources :menus, only:[:index, :new, :show, :create, :destroy]
    resources :lists, only:[:index, :create, :destroy]
  end

  resources :recipes do
    resource :favorites, only:[:create, :destroy]
    resources :comments, only:[:index, :create, :destroy]
  end

  resources :foods, only:[:index, :create, :destroy]




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
