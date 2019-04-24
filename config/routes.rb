Rails.application.routes.draw do

  get 'admin_user/index'
  root 'welcome#index'
  
  get 'welcome/index'
  get 'alumno_comp/index'
  get 'competencias/index'
  get 'unidades/index'
  get 'materia/index'
  get 'alumno_clase/index'
  get 'act_compl/index'
  get 'carrera/index'
  get 'alumnos/index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
