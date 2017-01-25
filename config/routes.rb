Rails.application.routes.draw do


  namespace :api do
     scope :v1  do
       resources :users
         mount_devise_token_auth_for 'User', at: 'auth'
         get "login", to: "/api/v1/login#login"
         get 'next_game', to: "/api/v1/user_login#next_game"
         get 'enrachate_25', to: "/api/v1/user_login#enrachate_25"
         get "enrachate_25_questions", to: "/api/v1/user_login#enrachate_25_questions"
         post "buy_lottery_ticket", to: "/api/v1/user_login#buy_lottery"
         post "create_enrachate_25_ticket", to: "/api/v1/user_login#create_enrachate_25_ticket"
         
     end
   end

  resources :gift_cards do
    collection do
      get "create_massive"
      get "generate_massive_cards", to: "gift_cards#generate_massive_cards"
    end
  end

  resources :relation_tira_questions

  resources :relation_enrachate_tiras do
      collection do
          get "close_tira_question"
          get "tiras_for_enrachate", to: "relation_enrachate_tiras#tiras_for_enrachate"
          get "close_question", to: "relation_enrachate_tiras#close_question"
      end
  end

  resources :enrachate_users

  resources :question_enrachates

  resources :tira_enrachates

  resources :enrachates do
    collection do
      get "enrachate_stats"
    end
  end

  resources :pick_user_games

  resources :pick_users

  resources :pick_survivor_weeks

  resources :picks do
	  collection do
		  get 'close_pick'
	  end
  end


  resources :survivor_week_survivors

  resources :survivor_games

  resources :survivor_users

  resources :survivor_week_games do
  	collection do
  		get 'close_games'
  		get '/get_games',to: "survivor_week_games#get_games"
		get '/get_weeks',to: "survivor_week_games#get_weeks"
      get 'can_close/:id', to: "survivor_week_games#can_close"
  	end
  end

  resources :survivors do
    collection do
      put 'close'
  	end
  end

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


    constraints subdomain: :webhooks do
        post '/:integration_name' => 'webhooks#receive', as: :receive_webhooks
    end


    resources :partials  do
        collection do
            get "check_gift_card", to: "partials#check_gift_card"
            get "gift_card"
            get "my_enrachate_create/:id", to: "partials#my_enrachate_create"
            get "lottery_rules"
            get "answer_register", to: "partials#answer_register"
            get "my_enrachate_tickets", to: "partials#my_enrachate_tickets"
            get "my_enrachate_leagues", to: "partials#my_enrachate_leagues"
            get "enrachate_survivor_history/:id", to: "partials#enrachate_survivor_history"
            get "my_ticket_history", to: "partials#my_ticket_history"
            get "my_ticket_history_special", to: "partials#my_ticket_history_special"
            get "enrachates_survivor", to: "partials#enrachates_survivor"
            get "top_100_enrachate", to: "partials#top_100_enrachate"
            get "top_100_enrachate_special", to: "partials#top_100_enrachate_special"
            get "tira_banner"
            get "enrachate_history", to: "partials#enrachate_history"
            get "enrachate_history_special", to: "partials#enrachate_history_special"
            get "enrachate_survivor/:id", to: "partials#enrachate_survivor"
            get "enrachate", to: "partials#enrachate"
            get "enrachate_special", to: "partials#enrachate_special"
            get "tiras_rules"
            get "_bank_tranfer"
            get "pay_in_store"
            get "pay_methods"
            post "change_score", to: "partials#change_score"
            post "change_pick_team", to: "partials#change_pick_team"
            get "select_pick_1/:id", to: "partials#select_pick_1"
            get 'tiras', to: "partials#tiras"
            get "pay_store", to: "partials#pay_store"
            get 'survivor_rules'
            get 'pickem_rules'
            get 'pickem_week_games_history/:id', to: 'partials#pickem_week_games_history'
			      get 'pickem_game'
            get "select_week_1/:id", to: "partials#select_week_1"
            get 'games_result'
            get 'response_access_pick/:id_request/:id_owner/:survivor/:response', to: "partials#response_access_pick"
            get 'response_request/:id_request/:id_owner/:survivor/:response', to: "partials#response_request"
			      get 'pickem_leagues', to: "partials#pickem_leagues"
            get 'pick_history/:id', to: "partials#pick_history"
            get 'get_weeks', to: "partials#get_weeks"
			      get 'pickem/:id', to: "partials#pickem"
			      post "invite_survivor", to: "partials#invite_survivor"
            post "invite_pick", to: "partials#invite_pick"
			      match "/inviting" => "partials#inviting", :via => :post
			      get 'invite_friends_survivor/:id', to: "partials#invite_friends_survivor"
            get 'invite_friends_pick/:id', to: "partials#invite_friends_pick"
			      get 'access_mail', to: "partials#access_request_mail"
            get 'access_mail_pick', to: "partials#access_request_mail_pick"
			      get 'my_leagues', to: "partials#my_leagues"
			      get 'my_pickem_leagues', to: "partials#my_pickem_leagues"
			      get 'next_game'
			      get 'finish_games'
			      get 'future_games'
			      get 'set_survivor_page/:id', to: "partials#set_survivor_page"
			      get 'survivor_history/:id', to: "partials#survivor_history"
			      get 'survivor_game'
			      get 'survivor_search', to: "partials#set_survivor_page"
      			get 'survivor_leagues', to: "partials#survivor_leagues"
      			get "/current_survivors", to: "partials#get_survivor"
      			get "/team_logos/:id", to: "partials#team_logos"
      			post 'buy_random_quinielas', to: "partials#buy_random_quinielas"
      			get 'get_quinielas_no_winner', to: "partials#get_quinielas_no_winner"
            post "credit_card_form", to: "partials#credit_card_pay"
            post "pay_methods", to: "partials#credit_card_pay"
            get "/partials/:user", to: "partials#get_customer_credit_cars"
            get "complete_buy"
            get "buy_error"
      			get "tickets_history"
      			get "client_details"
            post "delete_ticket", to: 'partials#delete_ticket'
            get 'lottery', to: "partials#lottery"
            get 'get_quinielas_mainpage', to: "partials#get_quinielas_mainpage"
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

		end
	end


  resources :users do
      collection do
      get "day_activity"
      get "activity_of_day/:date" , to: "users#activity_of_day"
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
  get 'welcome/terms', to: "welcome#no_sign_in"
  get 'welcome/about', to: "welcome#ho_we_are"
  get 'welcome/contact', to: "welcome#contact"
  get 'welcome/privacy', to: "welcome#privacy"
  get 'welcome/faq', to: "welcome#faq"
  post "/webhooks", to: "webhooks#receive"
  post "/", to: "webhooks#receive"

  get '/landing', :to => redirect('/index2.html')
  get '/error', :to => redirect('/404.html')


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
