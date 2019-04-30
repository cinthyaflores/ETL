Rails.application.routes.draw do

  get 'tipo_evaluacion/index'
  get 'tipo_evaluacion/edit'
  get 'turnos/index'
  get 'empleados/index'
  get 'empleados/edit'
  get 'adeudos/index'
  get 'adeudos/edit'
  get 'prestamos_material/index'
  #ME CREA LAS RUTAS NECESARIAS PARA LOS CONTROLADORES, CON EXCEPT LE DIGO CUALES RUTAS NO ME CRE

  resources :actividades_por_alumno, except: [:delete, :show]
  resources :actividad_extraescolar, only: [:index]
  resources :adeudos, except: [:delete, :show]
  resources :admin_user, only: [:index]
  resources :alumno_comp, except: [:delete, :show]
  resources :alumno_grupo, except: [:delete, :show]
  resources :alumno_grupo_actividad, only: [:index]
  resources :alumno_grupo_ingles, only: [:index]
  resources :alumnos_externos_ingles, only: [:index]
  resources :area_recreativa, only: [:index]
  resources :alumnos, except: [:delete, :show]
  resources :area_maestro, except: [:delete, :show]
  resources :areas_admin, except: [:delete, :show]
  resources :articulos, only: [:index]
  resources :asistencia_alumno, except: [:delete, :show]
  resources :asistencia_maestro, except: [:delete, :show]
  resources :aula, only: [:index]
  resources :bajas, only: [:index]
  resources :cambio_carrera, only: [:index]
  resources :carrera, except: [:delete, :show]
  resources :calificaciones_alumno, except: [:delete, :show]
  resources :competencias, only: [:index]
  resources :constancias, only: [:index]
  resources :detalle_orden_compra, except: [:delete, :show]
  resources :detalle_prestamo, except: [:delete, :show]
  resources :dias, only: [:index]
  resources :editoriales, except: [:delete, :show]
  resources :empleados, except: [:delete, :show]
  resources :escuela_de_ingles_externa, except: [:delete, :show]
  resources :estantes, only: [:index]
  resources :eventos, only: [:index]
  resources :eventos_alumno, only: [:index]
  resources :evaluaciones_ingreso, except: [:delete, :show]
  resources :forma_titulacion, except: [:delete, :show]
  resources :grupo, except: [:delete, :show]
  resources :grupo_actividad, except: [:delete, :show] 
  resources :grupo_ingles, except: [:delete, :show]
  resources :hardware, except: [:delete, :show] 
  resources :hardware_mantenimiento, only: [:index] 
  resources :hora, only: [:index] 
  resources :horarios_area, only: [:index]
  resources :idiomas, except: [:delete, :show] 
  resources :justificante, only: [:index]
  resources :libros, only: [:index]
  resources :maestros, except: [:delete, :show]
  resources :materia, except: [:delete, :show]
  resources :materiales, except: [:delete, :show]
  resources :maestro_grupo_actividades, only: [:index]
  resources :maestro_grupo_ingles, only: [:index]
  resources :movilidad, except: [:delete, :show]
  resources :movilidad_alumno_periodo, only: [:index]
  resources :nivel_de_ingles, only: [:index]
  resources :nivel_ingles_alumno, except: [:delete, :show]
  resources :orden_de_compra, except: [:delete, :show]
  resources :paises, except: [:delete, :show]
  resources :peliculas, except: [:delete, :show]
  resources :periodo, only: [:index]
  resources :periodicos, except: [:delete, :show]
  resources :personal_admin, except: [:delete, :show]
  resources :perdidas_materiales, except: [:delete, :show]
  resources :prestamos, except: [:delete, :show]
  resources :prestamos_sala, only: [:index]
  resources :prestamos_material, only: [:index]
  resources :productoras, except: [:delete, :show]
  resources :recurso_material, except: [:delete, :show]
  resources :revistas, except: [:delete, :show]
  resources :sala_trabajo, except: [:delete, :show]
  resources :sala_hardware, except: [:delete, :show]
  resources :secciones, only: [:index]
  resources :software, except: [:delete, :show]
  resources :tipo_baja, except: [:delete, :show]
  resources :titulado, only: [:index]
  resources :tipo_evaluacion, except: [:delete, :show] #FALTA DE LA MIA
  resources :tipo_constancia, except: [:delete, :show]
  resources :tipo_contrato, except: [:delete, :show]
  resources :tipo_mtto, except: [:delete, :show]
  resources :tipo_pelicula, except: [:delete, :show]
  resources :turnos, only: [:index]
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
  get '/delete_areas_maestro', to: 'area_maestro#delete_table', as: 'eliminar_areas_maestro' #Solo de aqui en adelante tienen validacion login
  get '/delete_adeudos', to: 'adeudos#delete_table', as: 'eliminar_adeudos'
  get '/delete_empleados', to: 'empleados#delete_table', as: 'eliminar_empleados'
  get '/delete_tipo_eva', to: 'tipo_evaluacion#delete_table', as: 'eliminar_tipo_eva'


  get 'welcome/index'
  root 'welcome#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
