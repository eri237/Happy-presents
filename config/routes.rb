Rails.application.routes.draw do

  root to: 'homes#top'
  get "home/about" => "homes#about"

  resources :items, only: [:index, :show, :edit, :create, :destroy, :update]do
    resource :favorites, only: [:create, :destroy]
    resources :item_comments, only: [:create, :destroy]
  end


  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get 'user/mypage' => 'users#mypage', as: 'mypage', format: false
  get 'user/mypage/edit' => 'users#edit', as: 'edit', format: false
  patch 'user/mypage/update' => 'users#update', as: 'update', format: false
  get 'user/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'user/withdraw' => 'users#withdraw', as: 'withdraw'

  resources :users, only: [:index, :show] do
  	resource :relationships, only: [:create, :destroy]
   	get 'followings' => 'relationships#followings', as: 'followings' #余裕があれば
   	get 'followers' => 'relationships#followers', as: 'followers' # 余裕があれば
  end



  get '/search', to: 'search#search'

end
