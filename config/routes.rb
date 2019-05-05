Rails.application.routes.draw do

  get 'logins/index'
  get 'show_tables/index'
  #ME CREA LAS RUTAS NECESARIAS PARA LOS CONTROLADORES, CON EXCEPT LE DIGO CUALES RUTAS NO ME CRE

  resources :actividades_por_alumno, only: [:index]
  resources :actividad_extraescolar, only: [:index]
  resources :adeudos, except: [:delete, :show]
  resources :admin_user, only: [:index]
  resources :alumno_comp, only: [:index]
  resources :alumno_grupo, only: [:index]
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
  resources :libros, except: [:delete, :show]
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
  resources :show_tables, only: [:index]
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
  resources :control, only: [:index]
  
  get '/etl', to: 'admin_user#init', as: 'etl'
  get '/etl_errores', to: 'admin_user#errors', as: 'etl_errores'

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
  get '/delete_areas_admin', to: 'areas_admin#delete_table', as: 'eliminar_areas_admin'
  get '/delete_asistencias_alumno', to: 'asistencia_alumno#delete_table', as: 'eliminar_asistencia_alumnos'
  get '/delete_calif_alumnos', to: 'calificaciones_alumno#delete_table', as: 'eliminar_calif_alumno'
  get '/delete_detalle', to: 'detalle_orden_compra#delete_table', as: 'eliminar_detalle_orden'
  get '/delete_libros', to: 'libros#delete_table', as: 'eliminar_libros'
  get '/delete_tipo_constancia', to: 'tipo_constancia#delete_table', as: 'eliminar_tipo_constancia'
  get '/delete_recurso_material', to: 'recurso_material#delete_table', as: 'eliminar_recurso_material'
  get '/delete_prestamos', to: 'prestamos#delete_table', as: 'eliminar_prestamos'
  get '/delete_perdidas_materiales', to: 'perdidas_materiales#delete_table', as: 'eliminar_perdidas_materiales'
  get '/delete_paises', to: 'paises#delete_table', as: 'eliminar_paises'
  get '/delete_orden_de_compra', to: 'orden_de_compra#delete_table', as: 'eliminar_orden_de_compra'
  get '/delete_materiales', to: 'materiales#delete_table', as: 'eliminar_materiales'
  get '/delete_materia', to: 'materia#delete_table', as: 'eliminar_materias'
  get '/delete_editoriales', to: 'editoriales#delete_table', as: 'eliminar_editoriales'

  get '/delete_all', to: 'show_tables#delete_all', as: 'eliminar_errores'
  
  get '/download', to: 'show_tables#download', as: 'download'

  get 'welcome/index'
  root 'welcome#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
