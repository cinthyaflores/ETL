Rails.application.routes.draw do

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
  resources :evaluaciones_ingreso, only: [:index]
  resources :forma_titulacion, only: [:index]
  resources :grupo, except: [:delete, :show]
  resources :grupo_actividad, except: [:delete, :show] 
  resources :hora, only: [:index]
  resources :justificante, only: [:index]
  resources :maestros, except: [:delete, :show]
  resources :materia, only: [:index]
  resources :movilidad, except: [:delete, :show]
  resources :movilidad_alumno_periodo, only: [:index]
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
