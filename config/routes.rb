Rails.application.routes.draw do
  resources :survivor_games

  resources :survivor_users

  resources :survivor_week_games do
	collection do
		get 'close_games'
		get '/get_games',to: "survivor_week_games#get_games"	
	end
  end
	

  resources :survivors

  resources :error_reports

    devise_for :users,  controllers: { registrations: "registrations"  }
  #, omniauth_callbacks: 'omniauth_callbacks'
  resources :questions

  resources :quiniela_users do
	collection do
		get 'winners'
		get '/today_sales',to: "quiniela_users#today_sales"	
		get '/sales_by_month',to: "quiniela_users#sales_by_month"
	end
   end

  resources :quiniela_questions

	resources :quinielas do
		collection do
			get 'last_quinielas', to: "quinielas#last_quinielas"
			get 'get_quinielas', to: "quinielas#get_quinielas"
			get 'close_quiniela'
			get 'toclose', to: "quinielas#toclose"
			get 'get_quinielas_no_winner', to: "quinielas#get_quinielas_no_winner"
			post 'buy_random_quinielas', to: "quinielas#buy_random_quinielas"
			get "/quiniela_details/:quiniela_id", to: "quinielas#quiniela_details"
			post "save_result", to: "quinielas#save_result"
		end
	end

    resources :games do
        collection do
			get '/future_games_programed', to: "games#future_games_programed"
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
			get 'next_game'
			get 'finish_games'
			get 'future_games'
			get "/team_logos/:id", to: "partials#team_logos"
			post 'buy_random_quinielas', to: "partials#buy_random_quinielas"
			get 'get_quinielas_no_winner', to: "partials#get_quinielas_no_winner"
            post "credit_card_form", to: "partials#credit_card_pay"
            get "/partials/:user", to: "partials#get_customer_credit_cars"
            get "complete_buy"
            get "buy_error"
			get "tickets_history"
			get "client_details"
		    get "/lotteries/:id", to: "partials#lotteries"
		    get "/quinielas/:id", to: "partials#quinielas"
			get "invite"
            get "/history", to: "partials#history"
            get "checkout"
            match "/checkout" => "partials#dispersion", :via => :post
            match "/credit_card_form/delete_card/:card/:customer" => "partials#delete_card", :via => :post
			post 'buy_much_tickets', to: "partials#buy_much_tickets"
           # get ":name", to: "partials#show_category"
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
		  get "send_mails"
          get "tickets_history"
		  match "/update_reference" => "users#search_reference", :via => :post
		  get "/client_details/:id_client", to: "users#client_details"
		  post "/send_mails_all", to: "users#send_mails_all"
      end
  end


  resources :user_lotteries do
    collection do
        get 'winners'
        get 'winners_total'
		get '/today_sales',to: "user_lotteries#today_sales"
        get 'winners_view'
		get "tickets_by_lottery"
		get "/tickets", to: "user_lotteries#search_ticket_by_lottery"
		get '/sales_by_month',to: "user_lotteries#sales_by_month"
    end
  end


  resources :lotteries do
        collection do
           get "/team_logos/:id", to: "lotteries#team_logos"
			get "/all_lotteries", to: "lotteries#all_lotteries"
			get 'last_lotteries', to: "lotteries#last_lotteries"
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

  get '/landing', :to => redirect('/index.html')



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
