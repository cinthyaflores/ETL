Rails.application.routes.draw do

  get 'grupo_actividad/index'
  get 'grupo_actividad/edit'
  get 'grupo_actividad/update'
  get 'grupo_actividad/delete'
  get 'aula/index'
  get 'periodo/index'
  get 'maestros/index'
  get 'maestros/edit'
  get 'maestros/update'
  get 'maestros/delete'
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
  get 'carrera/edit'
  get 'alumnos/index'
  get 'alumnos/edit'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
