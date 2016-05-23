Rails.application.routes.draw do
  resources :error_reports

    devise_for :users,  controllers: { registrations: "registrations"  }
  #, omniauth_callbacks: 'omniauth_callbacks'
  resources :questions

  resources :quiniela_users do
	collection do
		get 'winners'
	end
   end

  resources :quiniela_questions
	
	resources :quinielas do
		collection do
			get 'get_quinielas', to: "quinielas#get_quinielas"
			get 'close_quiniela'
			get 'toclose', to: "quinielas#toclose"
			get 'get_quinielas_no_winner', to: "quinielas#get_quinielas_no_winner"
			post 'buy_random_quinielas', to: "quinielas#buy_random_quinielas"
			get "/quiniela_details/:quiniela_id", to: "quinielas#quiniela_details"
		end
	end
    
    resources :games do
        collection do
            get 'next_game'
            get 'future_games'
            get 'finish_games'
            get 'today_games'
            get 'today_games_view'
            get '/lottery_name/:id', to: "games#lottery_name"
            get 'games_by_category'
        end
    end
        
    
    resources :webhooks do
        match '/webhooks', to: 'webhooks#receive', via: :post
    end
    
    resources :partials  do
        collection do
            match "/credit_card_form" => "partials#credit_card_pay", :via => :post
            get "/partials/:user", to: "partials#get_customer_credit_cars"
            get "complete_buy"
            get "buy_error"
			get "invite"
            get "/history", to: "partials#history"
            get "checkout"
            match "/checkout" => "partials#dispersion", :via => :post
            match "/credit_card_form/delete_card/:card/:customer" => "partials#delete_card", :via => :post
			post 'buy_much_tickets', to: "partials#buy_much_tickets"
        end
    end
  
  resources :teams
  resources :sport_categories

	resources :categories do
		collection do
			match "/invite" => "categories#invite", :via => :post
		end
	end

  resources :users do
      collection do
          get "/lotteries/:id", to: "users#lotteries"
		  get "/quinielas/:id", to: "users#quinielas"
          get "tickets_history"
		  match "/update_reference" => "users#search_reference", :via => :post
		  get "/client_details/:id_client", to: "users#client_details"
      end
  end

  resources :user_lotteries do
    collection do
        get 'winners'
        get 'winners_total'
        get 'winners_view'
		get "tickets_by_lottery"
		get "/tickets", to: "user_lotteries#search_ticket_by_lottery"
    end
  end
        

  resources :lotteries do
        collection do
            get "/team_logos/:id", to: "lotteries#team_logos"
			get "/all_lotteries", to: "lotteries#all_lotteries"
      end
    end
    

  resources :sports

  resources :roles

  get 'welcome/index'
  get 'welcome/index_client'  
  get 'language/i18n/:locale' => 'language#i18n'
  get 'partials/credit_card_form' 
  get 'welcome/terms'
  get 'welcome/about'	
  get 'welcome/contact'
  get 'welcome/privacy'
  get 'welcome/faq'	
  
  

	
	



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

    
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
