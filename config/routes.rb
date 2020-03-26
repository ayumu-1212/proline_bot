Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  namespace 'api' do
    namespace 'v1' do
      resources :messages
    end
  end
end
