Rails.application.routes.draw do
  namespace :admin do
    resources :sites do
      resources :sections do
        resource :article
      end
    end
  end
  
  resources :sections, :only => [:index, :show] do # TODO remove index, gotta fix resource_awareness
    resource :article, :only => [:show]
  end

  resources :installations, :only => [:new, :create]

  root :to => redirect(lambda { Site.first ? "/sections/#{Site.first.sections.first.id}" : '/installations/new' })
end