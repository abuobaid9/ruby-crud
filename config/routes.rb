Rails.application.routes.draw do
  get 'archives/index'
  resources :entries do
    collection do
      get 'weights'
    end
  end

  root to: 'entries#index'
  get 'search', to: 'entries#search'
end
