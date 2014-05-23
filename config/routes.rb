Rails.application.routes.draw do
  root :to => "main#index"
  
  resource :strip, only: :show do
    get 'first',  action: 'first'
    get 'last',   action: 'last'
    get 'ids',    action: 'ids'
    get 'thumbs', action: 'thumbs'
    get ':id',    action: 'show', id: Strip::FILENAME_PATTERN
  end
end
