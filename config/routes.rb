Rails.application.routes.draw do

  get 'search/search'
  devise_for :users
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :items, only: [:index, :show, :edit, :create, :destroy, :update]do
    resource :favorites, only: [:create, :destroy]
    resources :item_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show] do
  	resource :relationships, only: [:create, :destroy]
  # 	get 'followings' => 'relationships#followings', as: 'followings' #余裕があれば
  # 	get 'followers' => 'relationships#followers', as: 'followers' # 余裕があれば
  end

  get 'user/mypage' => 'users#mypage', as: 'mypage'
  get 'user/mypage/edit' => 'users#edit', as: 'edit'
  patch 'user' => 'users#update', as: 'update'
  get 'user/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'user/withdraw' => 'users#withdraw', as: 'withdraw'

  get '/search', to: 'search#search'

end
