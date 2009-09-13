ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'baptizer', :action => 'index'
  map.connect '/:action', :controller => 'baptizer'
end
