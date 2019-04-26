# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_23_162635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "Actividad_extraescolar ", primary_key: "Id_actividad", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre"
    t.integer "Tipo_actividad "
  end

  create_table "Actividades_por_alumno", id: false, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_actividad"
    t.integer "Id_Periodo"
    t.integer "Num_Credito_obtenido"
  end

  create_table "Adeudos", primary_key: "id_Adeudos", id: :integer, default: nil, force: :cascade do |t|
    t.integer "id_Prestamo"
    t.integer "Cargo_Dia"
  end

  create_table "Alumno", primary_key: "Id_Alumno", id: :integer, default: nil, force: :cascade do |t|
    t.string "No_control", limit: 8, null: false
    t.integer "Id_Carrera"
    t.string "Nombre", limit: 50
    t.string "Genero", limit: 1
    t.string "CorreoElec", limit: 50
    t.string "Dirección", limit: 30
    t.string "Telefono", limit: 20
    t.string "Curp", limit: 18
    t.date "Fecha_nac"
    t.integer "Cre_acum"
    t.integer "Promedio_G"
    t.integer "Estado"
    t.date "Fec_ingreso"
    t.date "Fec_egreso"
    t.float "Peso"
    t.integer "errorNombre"
    t.integer "errorCurp"
    t.integer "errorPeso"
    t.integer "errorTelefono"
    t.string "Estatura", limit: 10
    t.index ["No_control"], name: "UK_Ctrol", unique: true
  end

  create_table "Alumno-Competencia", id: false, force: :cascade do |t|
    t.integer "Id_Compet"
    t.integer "Id_Alumno"
    t.string "Oportunidad", limit: 20
    t.integer "Calificación"
  end

  create_table "Alumno-Eventos", id: false, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.string "Id_Evento"
    t.integer "Id_periodo"
  end

  create_table "Alumno-Grupo", id: false, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_Clase"
    t.string "Oportunidad", limit: 20
    t.integer "Promedio"
  end

  create_table "Alumno-GrupoActividad", id: false, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_grupo_Ac"
    t.integer "Id_periodo"
  end

  create_table "Alumno-GrupoIngles", id: false, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_grupo_Ing"
    t.integer "Id_periodo"
  end

  create_table "Area_recreativa", primary_key: "Id_area_rec", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre"
    t.string "Descripción"
  end

  create_table "Areas_Admin", primary_key: "Id_Area", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 30
    t.string "Descr", limit: 50
  end

  create_table "Articulos", primary_key: "idArticulo", id: :string, limit: 6, force: :cascade do |t|
    t.date "fecha_publicacion"
  end

  create_table "Asistencia_maestro", id: false, force: :cascade do |t|
    t.integer "Id_maestro"
    t.integer "Asistencias"
    t.integer "Faltas"
    t.integer "Retardos"
    t.integer "Id_periodo"
    t.integer "Id_Area_mtro"
  end

  create_table "Aula", primary_key: "Id_Aula", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 20
    t.string "Edificio", limit: 20
  end

  create_table "Baja", primary_key: "Id_Baja", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_Tipo_Baja"
    t.date "Fecha_Baja"
  end

  create_table "Cambio_Carrera", primary_key: "Id_Cambio", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_Carr_Ant"
    t.date "Fec_Cambio"
  end

  create_table "Carrera", primary_key: "Id_Carrera", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 30
    t.string "Descripción", limit: 50
    t.boolean "Acreditada"
  end

  create_table "Competencias", primary_key: "Id_Compet", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Unidad"
    t.string "Descripción", limit: 50
  end

  create_table "Constancia", primary_key: "Id_Const", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_Personal"
    t.integer "Id_Tipo_Con"
    t.date "Fecha_elab"
  end

  create_table "Deatlle_orden_compra", id: false, force: :cascade do |t|
    t.string "Id_orden_compra", limit: 15
    t.string "Id_recurso"
    t.integer "Cantidad"
    t.integer "Costo_unitario"
  end

  create_table "Detalle_prestamo", id: false, force: :cascade do |t|
    t.integer "Id_prestamo"
    t.integer "IdRM"
    t.integer "Cantidad"
  end

  create_table "Editoriales", primary_key: "Id_Editorial", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 60
    t.integer "CP"
    t.string "Direccion", limit: 80
    t.string "Telefono", limit: 15
    t.integer "Id_Pais"
  end

  create_table "Empleado", primary_key: "idEmpleado", id: :integer, default: nil, force: :cascade do |t|
    t.string "nombre_empleado"
    t.date "fec_nac"
    t.string "direccion", limit: 90
    t.string "telefono", limit: 11
    t.string "email", limit: 50
    t.integer "id_turno"
  end

  create_table "Estantes", primary_key: "id_Estante", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Seccion"
    t.string "Clave", limit: 10
  end

  create_table "Evaluaciones_Ingreso", primary_key: "Id_Evalu", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_Pers"
    t.integer "Id_Tipo_eva"
    t.date "Fecha_apl"
    t.integer "Resultado"
  end

  create_table "Eventos", primary_key: "Id_eventos", id: :string, limit: 15, force: :cascade do |t|
    t.string "Nombre", limit: 30
    t.string "Descripcion", limit: 150
    t.date "Fecha"
    t.integer "Tipo_evento"
  end

  create_table "Films", primary_key: "idFilm", id: :string, limit: 6, force: :cascade do |t|
    t.string "director", limit: 80
    t.string "ann_publicacion", limit: 4
    t.string "tipo_film", limit: 45
    t.integer "id_productora"
  end

  create_table "Forma_Titulacion", primary_key: "Id_Form_Titu", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 20
  end

  create_table "Grupo", primary_key: "Id_Grupo", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Materia"
    t.integer "Id_hora"
    t.integer "Id_Maestro"
    t.integer "Id_Periodo"
    t.integer "Id_Aula"
    t.string "Clave", limit: 10
  end

  create_table "Grupo-Ingles", primary_key: "Id_Grupo_ing", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre"
    t.integer "Cupo"
    t.string "Id_nivel"
    t.integer "Id_aula"
    t.time "Hora_inicio"
    t.time "Hora_fin"
  end

  create_table "Grupo_Actividad", primary_key: "Id_Grupo", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_actividad "
    t.integer "Id_maestro"
    t.string "Nombre"
    t.integer "Cupo"
    t.integer "Id_area"
    t.integer "Id_hor_ext"
  end

  create_table "Hardware", primary_key: "idHardware", id: :string, limit: 6, force: :cascade do |t|
    t.string "fabricante", limit: 80
    t.string "modelo", limit: 80
    t.string "tipo_Hardware", limit: 45
    t.date "f_ingreso"
  end

  create_table "Hardware-Mantenimiento", id: false, force: :cascade do |t|
    t.integer "Id_Tipo_Mtto"
    t.date "Fecha_Mtto"
    t.string "Diagnostico", limit: 90
    t.integer "No_Tecnico"
    t.string "id_Hardware", limit: 6
  end

  create_table "Hora", primary_key: "Id_Hora", id: :integer, default: nil, force: :cascade do |t|
    t.time "Hora inicio"
    t.time "Hora fin"
  end

  create_table "Horarios_Extraescolares", primary_key: "Id_hor_ext", id: :integer, default: nil, force: :cascade do |t|
    t.string "Días"
    t.string "Hora_inicio", limit: 5
    t.string "Hora_fin", limit: 5
  end

  create_table "Horarios_de_area", id: false, force: :cascade do |t|
    t.integer "Id_area_rec "
    t.time "Hora_inicio"
    t.time "Hora_fin"
  end

  create_table "Idiomas", primary_key: "Id_Idioma", id: :integer, default: nil, force: :cascade do |t|
    t.string "nombre", limit: 40
    t.string "codigo", limit: 10
  end

  create_table "Justificante", primary_key: "Id_Just", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_Personal"
    t.date "Fecha_ini"
    t.date "Fecha_fin"
    t.string "Causa", limit: 30
    t.date "Fecha_elab"
  end

  create_table "Libro", primary_key: "idLibro", id: :string, limit: 6, force: :cascade do |t|
    t.integer "edicion"
    t.string "aPublicacion", limit: 4
    t.integer "ISBN"
    t.integer "id_Editorial"
  end

  create_table "Maestro", primary_key: "Id_maestro", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Area_mtro"
    t.integer "Id_contrato"
    t.string "Nombre", limit: 50
    t.string "CorreoElec", limit: 40
    t.string "Telefono", limit: 20
    t.string "Titulo", limit: 30
    t.integer "errorNombre"
    t.integer "errorTelefono"
    t.string "Clave"
    t.index ["Clave"], name: "UK_clave", unique: true
  end

  create_table "Materia", primary_key: "Id_Materia", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 20
    t.string "Clave", limit: 10
    t.integer "Tipo"
    t.integer "Créditos"
  end

  create_table "Material", primary_key: "id_Material", id: :integer, default: nil, force: :cascade do |t|
    t.string "nombre/titulo", limit: 80
    t.string "autor", limit: 80
    t.integer "existencia"
    t.integer "id_Pais"
    t.integer "Id_idioma"
    t.string "Tipo _Material", limit: 6
    t.integer "Id_Estante"
  end

  create_table "Movilidad", primary_key: "Id_movilidad", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Carrera"
    t.string "País", limit: 20
    t.string "Estado", limit: 15
    t.string "Universidad", limit: 30
  end

  create_table "Movilidad-Alumno-Periodo", id: false, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_Movilidad"
    t.integer "Id_Periodo"
  end

  create_table "Nivel-Alumno", id: false, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_Nivel"
    t.integer "Id_Periodo"
    t.string "Calificacion", limit: 10
    t.integer "Credittos"
  end

  create_table "Nivel_de_ingles", primary_key: "Id_Nivel", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre"
    t.string "Descripción "
  end

  create_table "Orden _de_compra", primary_key: "Id_orden_comrpa", id: :string, limit: 15, force: :cascade do |t|
    t.date "Fecha"
    t.string "Costo"
    t.integer "Estado"
  end

  create_table "Paises", primary_key: "id_Pais", id: :integer, default: nil, force: :cascade do |t|
    t.string "nombre_pais", limit: 40
    t.string "clave", limit: 10
  end

  create_table "Perdidas_materiales", primary_key: "Id_perdidia", id: :string, force: :cascade do |t|
    t.string "Id_recurso"
    t.integer "Cantidad"
    t.string "Costo_total"
    t.string "Id_prestamo"
  end

  create_table "Periodicos", primary_key: "idPeriodico", id: :string, limit: 6, force: :cascade do |t|
    t.string "No_Serie", limit: 10
    t.date "fecha_publicado"
    t.integer "Id_Editorial"
  end

  create_table "Periodo", primary_key: "Id_Periodo", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 20
    t.date "FechaIn"
    t.date "FechaFin"
    t.string "Abreviacion", limit: 10
  end

  create_table "Personal_Admin", primary_key: "Id_Pers", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Area"
    t.string "Nombre", limit: 30
    t.string "CorreoE", limit: 50
    t.date "Fecha_Cont"
    t.integer "Estado"
  end

  create_table "Prestamos", primary_key: "Id_prestamo", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_maestro"
    t.date "Fechaprestamo"
    t.date "Fechaentrega"
    t.integer "Id_periodo"
    t.integer "Estado"
  end

  create_table "Prestamos_Material", primary_key: "Id_Prestamo_Mat", id: :integer, default: nil, force: :cascade do |t|
    t.date "fec_salida"
    t.date "fec_entrega"
    t.integer "id_Material"
    t.integer "Id_Solicitante"
    t.integer "Tipo_Solicitante"
    t.integer "id_Empleado"
    t.string "tipo_prestamo", limit: 20
  end

  create_table "Prestamos_Sala", primary_key: "id_Prestamo_Sala", id: :integer, default: nil, force: :cascade do |t|
    t.date "Fecha"
    t.time "Hora_Entrada"
    t.time "Hora_Salida"
    t.integer "id_Sala"
    t.integer "Id_Solicitante"
    t.integer "Tipo_Solicitante"
    t.integer "id_Empleado"
  end

  create_table "Productoras", primary_key: "idProductora", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 60
    t.string "Ano_Fund", limit: 4
    t.integer "Id_Pais"
  end

  create_table "Recurso-Area", id: false, force: :cascade do |t|
    t.integer "Id_recurso"
    t.integer "Id_area_rec"
    t.integer "Cantidad"
  end

  create_table "Recurso_Material", primary_key: "Id_recurso", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre"
    t.float "costo"
  end

  create_table "Revistas", primary_key: "idRevista", id: :string, limit: 6, force: :cascade do |t|
    t.date "fecha_publicacion"
  end

  create_table "Sala_Hardware", id: false, force: :cascade do |t|
    t.integer "Id_salon"
    t.string "Id_Hardware", limit: 6
    t.integer "Cantidad"
  end

  create_table "Sala_Trabajo", primary_key: "Id_salon", id: :integer, default: nil, force: :cascade do |t|
    t.string "Clave", limit: 3
    t.integer "Capacidad"
  end

  create_table "Secciones", primary_key: "id_Seccion", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 40
  end

  create_table "Software", primary_key: "idSoftware", id: :string, limit: 6, force: :cascade do |t|
    t.string "version", limit: 20
    t.string "ann_salida", limit: 4
  end

  create_table "Tipo_Contrato", primary_key: "Id_contrato", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 20
    t.string "Duración", limit: 20
  end

  create_table "Tipo_Evaluacion", primary_key: "Id_Tipo_Eva", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 20
    t.string "Descripción", limit: 50
  end

  create_table "Tipo_Mantenimiento", primary_key: "id_Tipo_Mtto", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 40
    t.integer "Costo"
  end

  create_table "Tipo_Pelicula", primary_key: "Id_Tipo_Pel", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 30
  end

  create_table "Tipo_baja", primary_key: "Id_Baja", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 20
  end

  create_table "Tipo_constancia", primary_key: "Id_Tipo_con", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 30
    t.integer "Costo"
  end

  create_table "Tipo_evento", primary_key: "Id_tipo_eve", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 20
  end

  create_table "Titulado", primary_key: "Id_Titulado", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_Form_Titu"
    t.date "Fecha_Tit"
  end

  create_table "Turnos", primary_key: "idTurno", id: :integer, default: nil, force: :cascade do |t|
    t.string "nomb_turno", limit: 40
    t.string "hora_inicio", limit: 5
    t.string "hora_fin", limit: 5
  end

  create_table "Unidad-Alumno", id: false, force: :cascade do |t|
    t.integer "Id_Alumno"
    t.integer "Id_Unidad"
    t.integer "Calificacion"
    t.string "Oportunidad", limit: 10
  end

  create_table "Unidades", primary_key: "Id_Unidad", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Materia"
    t.string "Nombre", limit: 30
  end

  create_table "Unidades-Ingles", primary_key: "Id_Unidad_ing", id: :integer, default: nil, force: :cascade do |t|
    t.integer "Id_Nivel"
    t.string "Nombre"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tipo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "Área_maestro", primary_key: "Id_Area_mtro", id: :integer, default: nil, force: :cascade do |t|
    t.string "Nombre", limit: 20
    t.string "Descripción", limit: 40
  end

end
