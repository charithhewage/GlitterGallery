Glitter::Application.routes.draw do

  devise_for :users,:controllers => { :registrations => 'registrations' }
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  match 'auth/:provider/callback' => "identities#create", :via => [:get,:post]
  match 'auth/failure' => "identities#failed_to_authenticate", :via => [:get,:post]
  

  #resources :projects
  resources :identities, only: [:destroy,:index]
  resources :comments, only: [:new, :create, :destroy]
  resources :glitterposts
  resources :notifications, only: [:index,:show]


  scope '/:username/:projects', to: "projects" do
    resources :projects
    get :commits, to: 'projects#commits'
    get :pulls,   to: 'projects#pulls'

    scope ':xid/' do
      get '/commits/:tree_id',  to: 'projects#commits'
      get 'commit/:tree_id',    to: 'projects#projectcommit'
      get '/master/:image_name',to: 'projects#masterbranch', image_name: /[^\/]*/
      get '/master/:image_name/history', to: 'projects#file_history', image_name:  /[^\/]*/
      get '/createsvg',                  to: 'projects#new_svg'
      get '/newfile',                    to: 'projects#newfile'
      get '/master/:image_name/edit',    to: 'projects#edit_svg', :image_name => /[^\/]*/
      get '/master/:image_name/update',  to: 'projects#update', :image_name => /[^\/]*/
      delete '/master/:image_name/delete',to: 'projects#file_delete', :image_name => /[^\/]*/
      post '/follow',             to: 'projects#follow'
      get '/fork',                to: 'projects#fork'
      get '/forkyou',             to: 'projects#forkyou'
      get '/pull',                to: 'projects#pull_request'
      get '/pull/:pull_id',       to: 'projects#pull'
      get '/pull/:pull_id/merge', to: 'projects#merge'
      get '/pull/:pull_id/close', to: 'projects#close'
      get '/pull/:pull_id/open',  to: 'projects#open'
      get '/pulls',               to: redirect('projects#pulls', status: 301)
      get '/settings',            to: 'projects#settings'
      get '/issues',              to: 'issues#index'
      get '/issue/:sub_id',       to: 'issues#show'
      get '/issues/new',          to: 'issues#new'
      post '/issues/new',         to: 'issues#create'
      post '/issue/:id/close',    to: 'issues#close'

    end

    get '/commits' => 'projects#commits'
    get '/commit/:tree_id' => 'projects#projectcommit'
    get '/tree/:branch/' => 'projects#show_tree_content'
    get '/tree/:branch/*destination' => 'projects#show_tree_content'
    get '/blob/:branch/*destination' => 'projects#show_blob_content', :destination => /.*/
    get '/master/:image_name' => 'projects#masterbranch', :image_name => /[^\/]*/
    get '/master/:image_name/history' => 'projects#file_history', :image_name => /[^\/]*/
    get '/createsvg' => 'projects#new_svg'
    get '/newfile' => 'projects#newfile'
    get '/master/:image_name/edit' => 'projects#edit_svg', :image_name => /[^\/]*/
    get '/master/:image_name/update' => 'projects#update', :image_name => /[^\/]*/
    delete '/master/:image_name/delete' => 'projects#file_delete', :image_name => /[^\/]*/
    post '/follow' => 'projects#follow'
    get '/fork' => 'projects#fork'
    get '/forkyou' => 'projects#forkyou'
    get '/pull' => 'projects#pull_request'
    get '/pull/:pull_id' => 'projects#pull'
    get '/pull/:pull_id/merge' => 'projects#merge'
    get '/pull/:pull_id/close' => 'projects#close'
    get '/pull/:pull_id/open' => 'projects#open'
    get '/pulls' => 'projects#pulls'
    get '/settings' => 'projects#settings'
    get '/issues/new' => 'issues#new'
    get '/issues' => 'issues#index'
    post '/issues/new' => 'issues#create'
    get  '/issue/:sub_id' => 'issues#show'
    post '/issue/:sub_id/close' => 'issues#close'


  end




  post 'glitterposts/:id/edit' => 'glitterposts#update'
  get '/inspire' => 'projects#index'
  get '/dashboard' => 'dashboard#index', :as => :dashboard\

  get '/:username/follow' => 'relationships#follow'
  get '/:username/unfollow' => 'relationships#unfollow'
  get '/:username' => 'users#show'
  
  get '/:username/projects' => 'projects#user_show'
  get '/:username/projects/following' => 'users#list_followed_projects', :as => :followed_projects
  get '/:username/:project' => 'projects#show'

=begin  
  -post 'glitterposts/:id/edit' => 'glitterposts#update'
  -get '/inspire' => 'projects#index'
  -get '/dashboard' => 'dashboard#index', :as => :dashboard
  get '/:username/follow' => 'relationships#follow'
  get '/:username/unfollow' => 'relationships#unfollow'
  get '/:username' => 'users#show'
  
  get '/:username/projects' => 'projects#user_show'
  get '/:username/projects/following' => 'users#list_followed_projects', :as => :followed_projects
  get '/:username/:project' => 'projects#show'
  get '/:username/:project/commits' => 'projects#commits'
  get '/:username/:project/commit/:tree_id' => 'projects#projectcommit'
  get '/:username/:project/tree/:branch/' => 'projects#show_tree_content'
  get '/:username/:project/tree/:branch/*destination' => 'projects#show_tree_content'
  get '/:username/:project/blob/:branch/*destination' => 'projects#show_blob_content', :destination => /.*/
  get '/:username/:project/master/:image_name' => 'projects#masterbranch', :image_name => /[^\/]*/
  get '/:username/:project/master/:image_name/history' => 'projects#file_history', :image_name => /[^\/]*/
  get '/:username/:project/createsvg' => 'projects#new_svg'
  get '/:username/:project/newfile' => 'projects#newfile'
  get '/:username/:project/master/:image_name/edit' => 'projects#edit_svg', :image_name => /[^\/]*/
  get '/:username/:project/master/:image_name/update' => 'projects#update', :image_name => /[^\/]*/
  delete '/:username/:project/master/:image_name/delete' => 'projects#file_delete', :image_name => /[^\/]*/
  post '/:username/:project/follow' => 'projects#follow'
  get '/:username/:project/fork' => 'projects#fork'
  get '/:username/:project/forkyou' => 'projects#forkyou'
  get '/:username/:project/pull' => 'projects#pull_request'
  get '/:username/:project/pull/:pull_id' => 'projects#pull'
  get '/:username/:project/pull/:pull_id/merge' => 'projects#merge'
  get '/:username/:project/pull/:pull_id/close' => 'projects#close'
  get '/:username/:project/pull/:pull_id/open' => 'projects#open'
  get '/:username/:project/pulls' => 'projects#pulls'
  get '/:username/:project/settings' => 'projects#settings'
  get '/:username/:project/issues/new' => 'issues#new'
  get '/:username/:project/issues' => 'issues#index'
  post '/:username/:project/issues/new' => 'issues#create'
  get '/:username/:project/issue/:sub_id' => 'issues#show'
  post '/:username/:project/issue/:sub_id/close' => 'issues#close'

 - get '/:username/:project/:xid' => 'projects#show'
 - get '/:username/:project/:xid/commits/:tree_id' => 'projects#commits'
  -get '/:username/:project/:xid/commit/:tree_id' => 'projects#projectcommit'
  -get '/:username/:project/:xid/master/:image_name' => 'projects#masterbranch', :image_name => /[^\/]*/
  -get '/:username/:project/:xid/master/:image_name/history' => 'projects#file_history', :image_name => /[^\/]*/
  -get '/:username/:project/:xid/createsvg' => 'projects#new_svg'
  -get '/:username/:project/:xid/newfile' => 'projects#newfile'
  -get '/:username/:project/:xid/master/:image_name/edit' => 'projects#edit_svg', :image_name => /[^\/]*/
  -get '/:username/:project/:xid/master/:image_name/update' => 'projects#update', -:image_name => /[^\/]*/
  -delete '/:username/:project/:xid/master/:image_name/delete' => 'projects#file_delete', :image_name => /[^\/]*/
  -post '/:username/:project/:xid/follow' => 'projects#follow'
  -get '/:username/:project/:xid/fork' => 'projects#fork'
  -get '/:username/:project/:xid/forkyou' => 'projects#forkyou'
  -get '/:username/:project/:xid/pull' => 'projects#pull_request'
  -get '/:username/:project/:xid/pull/:pull_id' => 'projects#pull'
  -get '/:username/:project/:xid/pull/:pull_id/merge' => 'projects#merge'
  -get '/:username/:project/:xid/pull/:pull_id/close' => 'projects#close'
  -get '/:username/:project/:xid/pull/:pull_id/open' => 'projects#open'
  -get '/:username/:project/:xid/pulls' => 'projects#pulls'
  -get '/:username/:project/:xid/settings' => 'projects#settings'
  -get '/:username/:project/:xid/issues' => 'issues#index'
  -get '/:username/:project/:xid/issue/:sub_id' => 'issues#show'
  -get '/:username/:project/:xid/issues/new' => 'issues#new'
  -post '/:username/:project/:xid/issues/new' => 'issues#create'
  -post '/:username/:project/:xid/issue/:id/close' => 'issues#close'

=end  
  resources :projects do
    member do
      get 'projects/:id/invite.xml' => 'projects#invite'
      post :file_upload
      post :file_update
      post :handle_pull_request
      post :create_svg, :as => :create_svg
      post :edit_svg, :as => :edit_svg
      post :update_svg, :as => :update_svg
    end
  end 

end
