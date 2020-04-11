Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
    	match 'accounts/balance', :to => 'accounts#balance', :via => 'post'

    	match 'accounts/statement', :to => 'accounts#statement', :via => 'post'
    	
    	match 'accounts/deposit', :to => 'accounts#deposit', :via => 'put'
    	
    	match 'accounts/transfer', :to => 'accounts#transfer', :via => 'post'
    end
  end
end
