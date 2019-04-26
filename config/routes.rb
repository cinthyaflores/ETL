Rails.application.routes.draw do

  get 'alumno_grupo/index'
  get 'constancias/index'
  get 'cambio_carrera/index'
  get 'bajas/index'
  get 'areas_admin/index'
  #ME CREA LAS RUTAS NECESARIAS PARA LOS CONTROLADORES, CON EXCEPT LE DIGO CUALES RUTAS NO ME CRE

  resources :admin_user, only: [:index]
  resources :alumno_comp, only: [:index]
  resources :alumno_grupo, only: [:index]
  resources :alumnos, except: [:delete, :show]
  resources :area_maestro, only: [:index]
  resources :areas_admin, only: [:index]
  resources :aula, only: [:index]
  resources :bajas, only: [:index]
  resources :cambio_carrera, only: [:index]
  resources :carrera, except: [:delete, :show]
  resources :competencias, only: [:index]
  resources :constancias, only: [:index]
  resources :grupo_actividad, except: [:delete, :show] 
  resources :maestros, except: [:delete, :show]
  resources :materia, only: [:index]
  resources :periodo, only: [:index]
  resources :unidades, only: [:index]
  
  get 'welcome/index'
  root 'welcome#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
