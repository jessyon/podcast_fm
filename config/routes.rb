Rails.application.routes.draw do
  
  	devise_for :podcasts
  	
  	resources :podcasts do 
  	resources :episodes
  end

    
	authenticated :podcast do 
		root 'podcasts#dashboard', as: 'authenticated_root'
	end
  	root 'welcome#index'



end
