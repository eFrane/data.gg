DataGg::Application.routes.draw do
  namespace :api do
  namespace :v10 do
    get 'overseas_aid/contributions'
    end
  end

  namespace :api do
  namespace :v10 do
    get 'tourism/cruises'
    end
  end

  namespace :api do
  namespace :v10 do
    get 'fire_and_rescue/attendances'
    end
  end

  namespace :charts do
  get 'tourism/cruises'
  end

  namespace :charts do
  get 'overseas_aid/contributions'
  end

  namespace :charts do
  get 'fire_and_rescue/attendances'
  end

  namespace :developers do
  get 'tourism/index'
  end

  # You can have the root of your site routed with "root"
  root 'home#index'

  get 'about' => 'home#about', as: :about
  get 'apps' => 'home#apps', as: :apps
  get 'help' => 'home#help', as: :help
  get 'contact' => 'home#contact', as: :contact
  get 'contribute' => 'home#contribute', as: :contribute
  get 'donate' => 'home#donate', as: :donate

  get 'bespoke/gp_flights_arrivals' => 'bespoke#gp_flights_arrivals'
  get 'bespoke/gp_flights_departures' => 'bespoke#gp_flights_departures'

  # Charts section
  get 'charts' => 'charts#index', as: :charts

  namespace :charts do
    get 'buses' => 'buses#usage', as: :buses
    get 'buses/usage' => 'buses#usage', as: :buses_usage
    get 'buses/split' => 'buses#split', as: :buses_split

    # Housing
    get 'housing' => 'housing#mean_average', as: :housing
    get 'housing/mean_average' => 'housing#mean_average', as: :housing_mean_average
    get 'housing/transactions' => 'housing#transactions', as: :housing_transactions
    get 'housing/local_price_transactions' => 'housing#local_price_transactions', as: :housing_local_price_transactions
    get 'housing/bedrooms' => 'housing#bedrooms', as: :housing_bedrooms
    get 'housing/types' => 'housing#types', as: :housing_types
    get 'housing/units' => 'housing#units', as: :housing_units

    # Crime
    get 'crime' => 'crime#detected', as: :crime
    get 'crime/detected' => 'crime#detected', as: :crime_detected
    get 'crime/reported' => 'crime#reported', as: :crime_reported

    # Traffic
    get 'traffic' => 'traffic#classifications', as: :traffic
    get 'traffic/classifications' => 'traffic#classifications', as: :traffic_classifications
    get 'traffic/collisions' => 'traffic#collisions', as: :traffic_collisions
    get 'traffic/offences' => 'traffic#offences', as: :traffic_offences

    # Population
    get 'population' => 'population#male_vs_female', as: :population
    get 'population/male_vs_female' => 'population#male_vs_female', as: :population_male_vs_female
    get 'population/parish' => 'population#parish', as: :population_parish

    # Education
    get 'education' => 'education#post16results', as: :education
    get 'education/post16results', as: :education_post16results
    get 'education/post16results_btec', as: :education_post16results_btec
    get 'education/gcses_overall', as: :education_gcses_overall
    get 'education/gcses_by_school', as: :education_gcses_by_school

    get 'earnings' => 'earnings#nominal_sex', as: :earnings
    get 'earnings/nominal_sex' => 'earnings#nominal_sex', as: :earnings_nominal_sex
    get 'earnings/age_group' => 'earnings#age_group', as: :earnings_age_group
    get 'earnings/sector' => 'earnings#sector', as: :earnings_sector

    get 'inflation' => 'inflation#changes', as: :inflation
    get 'inflation/changes' => 'inflation#changes', as: :inflation_changes
    get 'inflation/rpi_group_changes' => 'inflation#rpi_group_changes', as: :inflation_rpi_group_changes

    # Water
    get 'water' => 'water#domestic_consumption'
    get 'water/domestic_consumption' => 'water#domestic_consumption'

    # Emissions
    get 'emissions' => 'emissions#types'
    get 'emissions/types' => 'emissions#types'

    # Employment
    get 'employment' => 'employment#totals'
    get 'employment/totals' => 'employment#totals'

    get 'sailings' => 'sailings#condor_punctuality'
    get 'sailings/condor_punctuality' => 'sailings#condor_punctuality'

    # Weather
    get 'weather' => 'weather#totals'
    get 'weather/totals' => 'weather#totals'

    get 'finance' => 'finance#deposits'
    get 'finance/deposits' => 'finance#deposits'
    get 'finance/licences' => 'finance#licences'

    get 'health' => 'health#concerns'
    get 'health/concerns' => 'health#concerns'
    get 'health/totals' => 'health#totals'
    get 'health/new' => 'health#new'

    get 'fire_and_rescue' => 'fire_and_rescue#attendances'
    get 'fire_and_rescue/attendances' => 'fire_and_rescue#attendances'

    get 'overseas_aid' => 'overseas_aid#contributions'
    get 'overseas_aid/contributions' => 'overseas_aid#contributions'

    get 'tourism' => 'tourism#cruises'
    get 'tourism/cruises' => 'tourism#cruises'

  end


  # Developer guides section

  get 'developers' => 'developers#index', as: :developers

  namespace :developers do
    get 'buses' => 'buses#index', as: :buses
    get 'housing' => 'housing#index', as: :housing
    get 'crime' => 'crime#index', as: :crime
    get 'traffic' => 'traffic#index', as: :traffic
    get 'population' => 'population#index', as: :population
    get 'education' => 'education#index', as: :education
    get 'earnings' => 'earnings#index', as: :earnings
    get 'flights' => 'flights#index', as: :flights
    get 'sailings' => 'sailings#index', as: :sailings
    get 'inflation' => 'inflation#index', as: :inflation
    get 'water' => 'water#index'
    get 'employment' => 'employment#index'
    get 'emissions' => 'emissions#index'
    get 'weather' => 'weather#index'
    get 'finance' => 'finance#index'
    get 'health' => 'health#index'
    get 'fire_and_rescue' => 'fire_and_rescue#index'
    get 'overseas_aid' => 'overseas_aid#index'
    get 'tourism' => 'tourism#index'
  end


  # API calls

  namespace :api do
    namespace "v10", path: "1.0" do

      get 'buses/usage' => 'buses#usage'

      get 'crime/crimes' => 'crime#crimes'

      get 'traffic/traffic' => 'traffic#traffic'
      get 'traffic/collisions' => 'traffic#collisions'
      get 'traffic/injuries' => 'traffic#injuries'
      get 'traffic/classifications' => 'traffic#classifications'

      get 'housing/prices' => 'housing#local_prices'
      get 'housing/local_prices' => 'housing#local_prices'
      get 'housing/open_prices' => 'housing#open_prices'
      get 'housing/bedrooms' => 'housing#bedrooms'
      get 'housing/types' => 'housing#types'
      get 'housing/units' => 'housing#units'

      get 'flights/arrivals' => 'flights#arrivals'
      get 'flights/departures' => 'flights#departures'

      get 'sailings/harbour' => 'sailings#harbour'
      get 'sailings/condor_punctuality' => 'sailings#condor_punctuality'
      get 'sailings/cruises' => 'sailings#cruises'

      get 'education/post16results' => 'education#post16results'
      get 'education/gcse_overall' => 'education#gcse_overall'
      get 'education/gcse_school' => 'education#gcse_school'

      get 'population/population' => 'population#population'
      get 'population/age' => 'population#age'
      get 'population/age_male' => 'population#age_male'
      get 'population/age_female' => 'population#age_female'
      get 'population/birthplace' => 'population#birthplace'
      get 'population/changes' => 'population#changes'
      get 'population/district' => 'population#district'
      get 'population/parish' => 'population#parish'

      get 'earnings/earnings_age_group' => 'earnings#earnings_age_group'
      get 'earnings/earnings_sector' => 'earnings#earnings_sector'
      get 'earnings/earnings_sex' => 'earnings#earnings_sex'

      get 'inflation/changes' => 'inflation#changes'
      get 'inflation/rpi_group_changes' => 'inflation#rpi_group_changes'
      get 'inflation/rpix_group_changes' => 'inflation#rpix_group_changes'

      get 'water/domestic_consumption' => 'water#domestic_consumption'

      get 'emissions/types' => 'emissions#types'

      get 'employment/totals' => 'employment#totals'

      get 'weather/annual' => 'weather#annual'
      get 'weather/monthly' => 'weather#monthly'

      get 'finance/banking' => 'finance#banking'

      get 'health/concerns' => 'health#concerns'
      get 'health/totals' => 'health#totals'

      get 'fire_and_rescue/attendances' => 'fire_and_rescue#attendances'

      get 'overseas_aid/contributions' => 'overseas_aid#contributions'

      get 'tourism/cruises' => 'tourism#cruises'
    end
  end

  # LEGACY CALLS

  get 'api/v1/flights/arrivals', to: 'api/v10/flights#arrivals'
  get 'api/v1/flights/departures', to: 'api/v10/flights#departures'

  get 'api/v1/education/', to: 'api/v1/education#index'
  get 'api/v1/education/post16results', to: 'api/v1/education#post16results'
  get 'api/v1/education/gcse_overall', to: 'api/v1/education#gcse_overall'
  get 'api/v1/education/gcse_school', to: 'api/v1/education#gcse_school'

  get 'api/v1/population/', to: 'api/v1/population#index'
  get 'api/v1/population/population', to: 'api/v1/population#population'

  get 'api/v1/police/', to: 'api/v1/police#index'
  get 'api/v1/police/crimes', to: 'api/v1/police#crimes'
  get 'api/v1/police/traffic', to: 'api/v1/police#traffic'
  get 'api/v1/police/traffic_classifications', to: 'api/v1/police#traffic_classifications'
  get 'api/v1/police/traffic_collisions', to: 'api/v1/police#traffic_collisions'
  get 'api/v1/police/traffic_injuries', to: 'api/v1/police#traffic_injuries'

  get 'api/v1/earnings/', to: 'api/v1/earnings#index'
  get 'api/v1/earnings/earnings_age_group', to: 'api/v1/earnings#earnings_age_group'
  get 'api/v1/earnings/earnings_sector', to: 'api/v1/earnings#earnings_sector'
  get 'api/v1/earnings/earnings_sex', to: 'api/v1/earnings#earnings_sex'

  get 'api/v1/sailings/', to: 'api/v1/sailings#index'
  get 'api/v1/sailings/herm_trident', to: 'api/v1/sailings#herm_trident'
  get 'api/v1/sailings/harbour', to: 'api/v1/sailings#harbour'





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


  #Buses
  #namespace :buses do
  #  get 'timetables/list' => 'timetables#list'
  #  get 'timetables/current_version' => 'timetables#current_version'
  #end



  # Note that the rails docs say this:
  #   "Resources should never be nested more than 1 level deep." (Section 2.7.1 'Limits to nesting' - http://guides.rubyonrails.org/routing.html)
  # In this case I think because of the complexity, it's justified, and easier to navigate to

#  get 'buses/' => 'buses#index'

#  namespace :buses do
 #   resources :timetables, param: :start_date do
#      post 'publish' => 'timetables#publish'

 #     resources :stops
#      resources :stop_time_exceptions

#      resources :routes do
        # Make believe. Always work from the origin point.
#        resources :stop_times, param: :id do
#          get 'edit_individual' => 'stop_times#edit_individual', as: :edit_individual

#          post 'atomic_stop_time' => 'stop_times#add_exception', as: :add_exception
 #         delete 'remove_exception' => 'stop_times#remove_exception', as: :remove_exception
#        end

 #       resources :route_stops do
  #        collection do
   #         post 'create_stop_links'
    #      end
     #
      #    post 'move_up'
       #   post 'move_down'
#        end
 #     end
  #  end
  #end
end
