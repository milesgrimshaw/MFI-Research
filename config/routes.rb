TrustOrBust::Application.routes.draw do
  
  root :to => "main#index"
  
  match "/games/new" => "main#generate_players"
  match "/games/:id/winner/:winner_id" => "main#decide_game"
  match "/count" => "main#count"
  
end
