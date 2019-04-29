Rails.application.routes.draw do

  #ME CREA LAS RUTAS NECESARIAS PARA LOS CONTROLADORES, CON EXCEPT LE DIGO CUALES RUTAS NO ME CRE

  resources :actividades_por_alumno, only: [:index]
  resources :actividad_extraescolar, only: [:index]
  resources :admin_user, only: [:index]
  resources :alumno_comp, only: [:index]
  resources :alumno_grupo, only: [:index]
  resources :alumno_grupo_actividad, only: [:index]
  resources :alumno_grupo_ingles, only: [:index]
  resources :alumnos_externos_ingles, only: [:index]
  resources :area_recreativa, only: [:index]
  resources :alumnos, except: [:delete, :show]
  resources :area_maestro, only: [:index]
  resources :areas_admin, only: [:index]
  resources :articulos, only: [:index]
  resources :asistencia_alumno, only: [:index]
  resources :asistencia_maestro, only: [:index]
  resources :aula, only: [:index]
  resources :bajas, only: [:index]
  resources :cambio_carrera, only: [:index]
  resources :carrera, except: [:delete, :show]
  resources :calificaciones_alumno, only: [:index]
  resources :competencias, only: [:index]
  resources :constancias, only: [:index]
  resources :detalle_orden_compra, only: [:index]
  resources :detalle_prestamo, only: [:index]
  resources :dias, only: [:index]
  resources :editoriales, only: [:index]
  resources :escuela_de_ingles_externa, only: [:index]
  resources :estantes, only: [:index]
  resources :eventos, only: [:index]
  resources :eventos_alumno, only: [:index]
  resources :evaluaciones_ingreso, only: [:index]
  resources :forma_titulacion, only: [:index]
  resources :grupo, except: [:delete, :show]
  resources :grupo_actividad, except: [:delete, :show] 
  resources :grupo_ingles, only: [:index] 
  resources :hardware, only: [:index] 
  resources :hardware_mantenimiento, only: [:index] 
  resources :hora, only: [:index] 
  resources :horarios_area, only: [:index]
  resources :idiomas, only: [:index]
  resources :justificante, only: [:index]
  resources :libros, only: [:index]
  resources :maestros, except: [:delete, :show]
  resources :materia, only: [:index]
  resources :materiales, only: [:index]
  resources :maestro_grupo_actividades, only: [:index]
  resources :maestro_grupo_ingles, only: [:index]
  resources :movilidad, except: [:delete, :show]
  resources :movilidad_alumno_periodo, only: [:index]
  resources :nivel_de_ingles, only: [:index]
  resources :nivel_ingles_alumno, only: [:index]
  resources :paises, only: [:index]
  resources :peliculas, only: [:index]
  resources :periodo, only: [:index]
  resources :periodicos, only: [:index]
  resources :personal_admin, except: [:delete, :show]
  resources :perdidas_materiales, only: [:index]
  resources :prestamos, only: [:index]
  resources :prestamos_sala, only: [:index]
  resources :productoras, only: [:index]
  resources :recurso_material, only: [:index]
  resources :revistas, only: [:index]
  resources :sala_trabajo, only: [:index]
  resources :sala_hardware, only: [:index]
  resources :secciones, only: [:index]
  resources :software, only: [:index]
  resources :orden_de_compra, only: [:index]
  resources :tipo_baja, only: [:index]
  resources :titulado, only: [:index]
  resources :tipo_constancia, only: [:index]
  resources :tipo_contrato, only: [:index]
  resources :tipo_mtto, only: [:index]
  resources :tipo_pelicula, only: [:index]
  resources :unidades, only: [:index]
  
  get '/etl', to: 'admin_user#init', as: 'etl'
  get '/etl_errores', to: 'admin_user#errors', as: 'etl_errores'
  get '/descargar_etl', to: 'admin_user#download', as: 'descargar_etl'
  get '/delete_alumnos', to: 'alumnos#delete_table', as: 'eliminar_alumnos'
  get '/delete_carreras', to: 'carrera#delete_table', as: 'eliminar_carreras'
  get '/delete_grupo', to: 'grupo#delete_table', as: 'eliminar_grupo'
  get '/delete_grupo_act', to: 'grupo_actividad#delete_table', as: 'eliminar_grupo_act'
  get '/delete_maestro', to: 'maestros#delete_table', as: 'eliminar_maestros'
  get '/delete_movilidad', to: 'movilidad#delete_table', as: 'eliminar_movilidad'
  get '/delete_personal_admin', to: 'personal_admin#delete_table', as: 'eliminar_personal_admin'


  get 'welcome/index'
  root 'welcome#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
