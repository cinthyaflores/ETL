class ShowTablesController < ApplicationController

  def index
    tablas_errores

    if @all_empty
      export_to_sql
      excel
    end

  end

  def delete_all
    delete_all_tables
  end


  def download
    send_file("simple2.xlsx",filename: "data_warehouse.xlsx")
  end


  private

    def tablas_errores 
      #Método para saber si hay errores en las tablas.. Verify verifica los errores en las tablas según el tipo de usuario actual (Para que sólo muestre las que corresponden al usuario) ** Solo en las que puede haber errores **
      if Alumno.using(:data_warehouse).where(errorNombre: [1,2]).empty? && Alumno.using(:data_warehouse).where(errorTelefono: [1,2]).empty? && Alumno.using(:data_warehouse).where(errorCurp: [1,2]).empty? && Alumno.using(:data_warehouse).where(errorPeso: [1,2]).empty? && Alumno.using(:data_warehouse).where(errorCorreo: [1,2]).empty? && Alumno.using(:data_warehouse).where(errorCreditos: [1,2]).empty? && Alumno.using(:data_warehouse).where(errorPromedio: [1,2]).empty?
        @alumnos = true
      end
      if Maestro.using(:data_warehouse).where(errorNombre: 1).empty? && Maestro.using(:data_warehouse).where(errorTelefono: 1).empty? && Maestro.using(:data_warehouse).where(errorCorreo: 1).empty?
        @maestros = true
      end
      @area_ma = true if Area_maestro.using(:data_warehouse).where(errorNombre: [1,2]).empty?
      @adeudos = true if Adeudos.using(:data_warehouse).where(errorCargo: 1).empty?
      @areas_admin = true if Areas_admin.using(:data_warehouse).where(errorNombre: 1).empty?
      if Asistencia_alumno.using(:data_warehouse).where(errorAsistencias: 1).empty? && Asistencia_alumno.using(:data_warehouse).where(errorFaltas: 1).empty? && Asistencia_alumno.using(:data_warehouse).where(errorRetardos: 1).empty?
        @asis_alu = true
      end
      @calif_alu = true if Calificaciones_alumno.using(:data_warehouse).where(errorCalif: 1).empty?
      if Carrera.using(:data_warehouse).where(errorNombre: 1).empty? && Carrera.using(:data_warehouse).where(errorCreditos: 1).empty?
        @carreras = true 
      end
      if Detalle_orden_compra.using(:data_warehouse).where(errorCantidad: 1).empty? && Detalle_orden_compra.using(:data_warehouse).where(errorCosto: 1).empty?
        @detalle_ord = true 
      end
      if Editorial.using(:data_warehouse).where(errorNombre: 1).empty? && Editorial.using(:data_warehouse).where(errorTelefono: 1).empty?
        @editoriales = true 
      end
      if Empleado.using(:data_warehouse).where(errorNombre: 1).empty? && Empleado.using(:data_warehouse).where(errorTelefono: 1).empty? && Empleado.using(:data_warehouse).where(errorCorreo: 1).empty?
        @empleados = true 
      end
      @grupo_act = true if Grupo_actividad.using(:data_warehouse).where(errorCupo: 1).empty?
      @grupos = true if Grupo.using(:data_warehouse).where(errorClave: 1).empty?
      @libros = true if Libro.using(:data_warehouse).where(errorISBN: 1).empty?
      if Materia.using(:data_warehouse).where(errorNombre: 1).empty? && Materia.using(:data_warehouse).where(errorCreditos: 1).empty?
        @materias = true 
      end
      if Materiales.using(:data_warehouse).where(errorAutor: 1).empty? && Materiales.using(:data_warehouse).where(errorExistencia: 1).empty?
        @materiales = true 
      end
      if Movilidad.using(:data_warehouse).where(errorPais: 1).empty? && Movilidad.using(:data_warehouse).where(errorEstado: 1).empty?
        @movilidad = true
      end
      if Orden_de_compra.using(:data_warehouse).where(errorEstado: 1).empty? && Orden_de_compra.using(:data_warehouse).where(errorCosto: 1).empty?
        @ord_comp = true 
      end
      if Paises.using(:data_warehouse).where(errorNombre: 1).empty? && Paises.using(:data_warehouse).where(errorClave: 1).empty?
        @paises = true 
      end
      if Perdidas_materiales.using(:data_warehouse).where(errorCosto: 1).empty? && Perdidas_materiales.using(:data_warehouse).where(errorCantidad: 1).empty?
        @perdidas = true
      end 
      if Personal_Admin.using(:data_warehouse).where(errorNombre: 1).empty? && Personal_Admin.using(:data_warehouse).where(errorEstado: 1).empty?
        @personal_admin = true 
      end
      @prestamos = true if Prestamos.using(:data_warehouse).where(errorEstado: 1).empty?
      if Recurso_material.using(:data_warehouse).where(errorCosto: 1).empty? && Recurso_material.using(:data_warehouse).where(errorCantidad: 1).empty? && Recurso_material.using(:data_warehouse).where(errorNombre: 1).empty?
        @recursos = true 
      end
      if Tipo_constancia.using(:data_warehouse).where(errorNombre: 1).empty? && Tipo_constancia.using(:data_warehouse).where(errorCosto: 1).empty?
        @tipo_cons = true 
      end
      @tipo_eva = true if Tipo_evaluacion.using(:data_warehouse).where(errorNombre: 1).empty?

      if @alumnos && @maestros && @area_ma && @adeudos && @areas_admin && @asis_alu && @calif_alu && @carreras && @detalle_ord && @editoriales && @empleados && @grupo_act && @grupos && @libros && @materias && @materiales && @movilidad && @ord_comp && @paises && @perdidas && @personal_admin && @recursos && @tipo_cons && @tipo_eva
        @all_empty = true
      end

    end

    def export_to_sql
      AlumnosController.new.export_to_sql
      MaestrosController.new.export_to_sql
      ActividadExtraescolarController.new.export_to_sql
      ActividadesPorAlumnoController.new.export_to_sql
      AdeudosController.new.export_to_sql
      AlumnoCompController.new.export_to_sql
      AlumnoGrupoController.new.export_to_sql
      AlumnoGrupoActividadController.new.export_to_sql
      AlumnoGrupoInglesController.new.export_to_sql
      AlumnosExternosInglesController.new.export_to_sql
      AreaMaestroController.new.export_to_sql
      AreaRecreativaController.new.export_to_sql
      AreasAdminController.new.export_to_sql
      ArticulosController.new.export_to_sql
      AsistenciaAlumnoController.new.export_to_sql
      AsistenciaMaestroController.new.export_to_sql
      AulaController.new.export_to_sql
      BajasController.new.export_to_sql
      CalificacionesAlumnoController.new.export_to_sql
      CambioCarreraController.new.export_to_sql
      CarreraController.new.export_to_sql
      CompetenciasController.new.export_to_sql
      ConstanciasController.new.export_to_sql
      DetalleOrdenCompraController.new.export_to_sql
      DetallePrestamoController.new.export_to_sql
      DiasController.new.export_to_sql
      EditorialesController.new.export_to_sql
      EmpleadosController.new.export_to_sql
      EscuelaDeInglesExternaController.new.export_to_sql
      EstantesController.new.export_to_sql
      EvaluacionesIngresoController.new.export_to_sql
      EventosAlumnoController.new.export_to_sql
      EventosController.new.export_to_sql
      FormaTitulacionController.new.export_to_sql
      GrupoActividadController.new.export_to_sql
      GrupoController.new.export_to_sql
      GrupoInglesController.new.export_to_sql
      HardwareController.new.export_to_sql
      HardwareMantenimientoController.new.export_to_sql
      HoraController.new.export_to_sql
      HorariosAreaController.new.export_to_sql
      IdiomasController.new.export_to_sql
      JustificanteController.new.export_to_sql
      LibrosController.new.export_to_sql
      LoginsController.new.export_to_sql
      MaestroGrupoActividadesController.new.export_to_sql
      MaestroGrupoInglesController.new.export_to_sql
      MateriaController.new.export_to_sql
      MaterialesController.new.export_to_sql
      MovilidadAlumnoPeriodoController.new.export_to_sql
      MovilidadController.new.export_to_sql
      NivelDeInglesController.new.export_to_sql
      NivelInglesAlumnoController.new.export_to_sql
      OrdenDeCompraController.new.export_to_sql
      PaisesController.new.export_to_sql
      PeliculasController.new.export_to_sql
      PerdidasMaterialesController.new.export_to_sql
      PeriodicosController.new.export_to_sql
      PeriodoController.new.export_to_sql
      PersonalAdminController.new.export_to_sql
      PrestamosController.new.export_to_sql
      PrestamosMaterialController.new.export_to_sql
      PrestamosSalaController.new.export_to_sql
      ProductorasController.new.export_to_sql
      RecursoMaterialController.new.export_to_sql
      RevistasController.new.export_to_sql
      SalaHardwareController.new.export_to_sql
      SalaTrabajoController.new.export_to_sql
      SeccionesController.new.export_to_sql
      SoftwareController.new.export_to_sql
      TipoBajaController.new.export_to_sql
      TipoConstanciaController.new.export_to_sql
      TipoContratoController.new.export_to_sql
      TipoEvaluacionController.new.export_to_sql
      TipoMttoController.new.export_to_sql
      TipoPeliculaController.new.export_to_sql
      TituladoController.new.export_to_sql
      TurnosController.new.export_to_sql
      UnidadesController.new.export_to_sql

    end

    def excel 
      p = Axlsx::Package.new
      wb = p.workbook
      style = wb.styles.add_style(:sz=>12) 
      format_time = wb.styles.add_style(:num_fmt => Axlsx::NUM_FMT_YYYYMMDD, :sz=>12)
      format_datetime = wb.styles.add_style(:num_fmt => Axlsx::NUM_FMT_YYYYMMDDHHMMSS, :sz=>12)
      time_f = wb.styles.add_style(:num_fmt => 21, :sz=>12)
      wb.add_worksheet(name: "Alumnos") do |sheet|
        alumnos = AlumnosController.new.data
        sheet.add_row ["ID", "No Control", "Carrera", "Nombre", "Genero", "E-mail", "Dirección", "Teléfono", "Curp", "Fecha_nac", "Créditos", "Promedio General", "Peso", "Estatura", "Tel Extraescolares", "Estado", "Fecha ingreso", "Fecha egreso"], :style => style
        alumnos.each do |t|
            sheet.add_row [t.Id_Alumno, t.No_control, t.Id_Carrera, t.Nombre, t.Genero, t.CorreoElec,t.Dirección, t.Telefono, t.Curp, t.Fecha_nac, t.Cre_acum, t.Promedio_G, t.Peso, t.Estatura, t.telefono_extra, t.Estado, t.Fec_ingreso, t.Fec_egreso], :style => [style, style, style, style, style, style, style, style, style, format_time,style, style, style, style, style, style, format_time, format_time]
        end
      end
      wb.add_worksheet(name: "Actividades Extraescolares") do |sheet|
        sheet.add_row ["ID", "Nombre", "Tipo de Actividad"], :style => style
        actividad = ActividadExtraescolarController.new.data
        actividad.each do |t|
            sheet.add_row [t.Id_actividad, t.Nombre, t.Tipo_actividad], :style => style
        end
      end
      wb.add_worksheet(name: "Actividades Por Alumno") do |sheet|
        sheet.add_row ["Id Alumno", "Id actividad", "Id Periodo", "Creditos Obtenidos"], :style => style
        actividad = ActividadesPorAlumnoController.new.data
        actividad.each do |t|
            sheet.add_row [t.Id_Alumno, t.Id_actividad, t.Id_Periodo, t.Num_Credito_obtenido], :style => style
        end
      end
      wb.add_worksheet(name: "Adeudos") do |sheet|
        sheet.add_row ["id Adeudos", "id Prestamo", "Cargo por Dia"], :style => style
        adeudos = AdeudosController.new.data
        adeudos.each do |t|
            sheet.add_row [t.id_Adeudos, t.id_Prestamo, t.Cargo_Dia], :style => style
        end
      end
      wb.add_worksheet(name: "Alumno Competencia") do |sheet|
        sheet.add_row ["Id_Compet", "Id_Alumno", "Oportunidad", "Calificación"], :style => style
        alumnos = AlumnoCompController.new.data
        alumnos.each do |t|
            sheet.add_row [t.Id_Compet, t.Id_Alumno, t.Oportunidad, t.Calificación], :style => style
        end
      end
      wb.add_worksheet(name: "Alumno Grupo") do |sheet|
        sheet.add_row ["Id_Alumno", "Id_Grupo", "Oportunidad", "Promedio"], :style => style
        alumnos = AlumnoGrupoController.new.data
        alumnos.each do |t|
            sheet.add_row [t.Id_Alumno, t.Id_Grupo, t.Oportunidad,t.Promedio], :style => style
        end
      end
      wb.add_worksheet(name: "Alumno Grupo Actividad") do |sheet|
        sheet.add_row ["Id_Grupo", "Id_Alumno", "Periodo"], :style => style
        alumnos = AlumnoGrupoActividadController.new.data
        alumnos.each do |t|
            sheet.add_row [t.Id_grupo_Ac, t.Id_Alumno, t.Id_periodo], :style => style
        end
      end
      wb.add_worksheet(name: "Alumno Grupo Ingles") do |sheet|
        sheet.add_row ["Id_Alumno", "Id_grupo_Ing", "Id_periodo"], :style => style
        alumnos = AlumnoGrupoInglesController.new.data
        alumnos.each do |t|
            sheet.add_row [t.Id_Alumno, t.Id_grupo_Ing, t.Id_periodo], :style => style
        end
      end
      wb.add_worksheet(name: "AlumnosExternosIngles") do |sheet|
        sheet.add_row ["Id_Alumno", "Id_escuela"], :style => style
        alumnos = AlumnosExternosInglesController.new.data
        alumnos.each do |t|
            sheet.add_row [t.Id_Alumno, t.Id_escuela], :style => style
        end
      end
      wb.add_worksheet(name: "AreaMaestro") do |sheet|
        sheet.add_row ["Id_Area_mtro", "Nombre", "Descripción"], :style => style
        areas = AreaMaestroController.new.data
        areas.each do |t|
            sheet.add_row [t.Id_Area_mtro, t.Nombre, t.Descripción], :style => style
        end
      end
      wb.add_worksheet(name: "AreaRecreativa") do |sheet|
        sheet.add_row ["Id_area_rec", "Nombre", "Descripción"], :style => style
        areas = AreaRecreativaController.new.data
        areas.each do |t|
            sheet.add_row [t.Id_area_rec, t.Nombre, t.Descripción], :style => style
        end
      end
      wb.add_worksheet(name: "Areas Admin") do |sheet|
        sheet.add_row ["Id_Area", "Nombre", "Descripción"], :style => style
        maestros = AreasAdminController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Area, t.Nombre, t.Descr], :style => style
        end
      end
      wb.add_worksheet(name: "Articulos") do |sheet|
        sheet.add_row ["Id Articulo", "fecha_publicacion"], :style => style
        articulos = ArticulosController.new.data
        articulos.each do |t|
            sheet.add_row [t.idArticulo, t.fecha_publicacion], :style => [style, format_time]
        end
      end
      wb.add_worksheet(name: "AsistenciaAlumno") do |sheet|
        sheet.add_row ["Id_alumno", "Id_Periodo", "Asistencias", "Faltas", "Retardos"], :style => style
        maestros = AsistenciaAlumnoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_alumno, t.Id_Periodo, t.Asistencias, t.Faltas, t.Retardos], :style => style
        end
      end
      wb.add_worksheet(name: "AsistenciaMaestro") do |sheet|
        sheet.add_row ["Id_maestro", "Id_Area_mtro", "Asistencias", "Id_periodo", "Faltas", "Retardos"], :style => style
        maestros = AsistenciaMaestroController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Asistencias, t.Id_periodo, t.Faltas, t.Retardos], :style => style
        end
      end
      wb.add_worksheet(name: "Aula") do |sheet|
        sheet.add_row ["Id_Aula", "Nombre", "Edificio", "Descripcion"], :style => style
        aulas = AulaController.new.data
        aulas.each do |t|
            sheet.add_row [t.Id_Aula, t.Nombre, t.Edificio, t.Descripcion], :style => style
        end
      end
      wb.add_worksheet(name: "Bajas") do |sheet|
        sheet.add_row ["Id_Baja", "Id_Alumno", "Id_Tipo_Baja", "Fecha_Baja"], :style => style
        maestros = BajasController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Baja, t.Id_Alumno, t.Id_Tipo_Baja, t.Fecha_Baja], :style => [style, style, style, format_time]
        end
      end
      wb.add_worksheet(name: "CalificacionesAlumno") do |sheet|
        sheet.add_row ["id_calif_alu", "Id_Alumno", "Id_nivel", "Calificacion", "Unidad", "Id_Periodo"], :style => style
        maestros = CalificacionesAlumnoController.new.data
        maestros.each do |t|
            sheet.add_row [t.id_calif_alu, t.Id_Alumno, t.Id_nivel, t.Calificacion, t.Unidad, t.Id_Periodo], :style => style
        end
      end
      wb.add_worksheet(name: "CambioCarrera") do |sheet|
        sheet.add_row ["Id_Cambio", "Id_Alumno", "Id_Carr_Ant", "Fec_Cambio"], :style => style
        maestros = CambioCarreraController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Cambio, t.Id_Alumno, t.Id_Carr_Ant, t.Fec_Cambio], :style => [style, style, style, format_time]
        end
      end
      wb.add_worksheet(name: "Carrera") do |sheet|
        sheet.add_row ["Id_Carrera", "Nombre", "Descripción", "Creditos", "Acreditada"], :style => style
        maestros = CarreraController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Carrera, t.Nombre, t.Descripción, t.Creditos, t.Acreditada], :style => style
        end
      end
      wb.add_worksheet(name: "Competencias") do |sheet|
        sheet.add_row ["Id_Compet", "Id_Unidad", "Descripción"], :style => style
        maestros = CompetenciasController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Compet, t.Id_Unidad, t.Descripción], :style => style
        end
      end
      wb.add_worksheet(name: "Constancias") do |sheet|
        sheet.add_row ["Id_Const", "Id_Alumno", "Id_Personal", "Id_Tipo_Con", "Fecha_elab"], :style => style
        maestros = ConstanciasController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Const, t.Id_Alumno, t.Id_Personal, t.Id_Tipo_Con, t.Fecha_elab], :style => [style, style, style,style, format_time]
        end
      end
      wb.add_worksheet(name: "DetalleOrdenCompra") do |sheet|
        sheet.add_row ["id_detalle_orden", "Id_orden_compra", "Id_recurso", "Cantidad", "Costo_unitario"], :style => style
        maestros = DetalleOrdenCompraController.new.data
        maestros.each do |t|
            sheet.add_row [t.id_detalle_orden, t.Id_orden_compra, t.Id_recurso, t.Cantidad, t.Costo_unitario], :style => style
        end
      end
      wb.add_worksheet(name: "DetallePrestamo") do |sheet|
        sheet.add_row ["Id_prestamo", "Id Recurso", "Cantidad"], :style => style
        maestros = DetallePrestamoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_prestamo, t.IdRM, t.Cantidad], :style => style
        end
      end
      wb.add_worksheet(name: "Dias") do |sheet|
        sheet.add_row ["Id_dias", "Descripcion"], :style => style
        maestros = DiasController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_dias, t.Descripcion], :style => style
        end
      end
      wb.add_worksheet(name: "Editoriales") do |sheet|
        sheet.add_row ["Id_Editorial", "Nombre", "CP", "Direccion", "Telefono", "Pais"], :style => style
        maestros = EditorialesController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Editorial, t.Nombre, t.CP, t.Direccion, t.Telefono, t.Id_Pais], :style => style
        end
      end
      wb.add_worksheet(name: "Empleados") do |sheet|
        sheet.add_row ["idEmpleado", "Nombre", "fec_nac", "direccion", "telefono", "email", "id_turno"], :style => style
        maestros = EmpleadosController.new.data
        maestros.each do |t|
            sheet.add_row [t.idEmpleado, t.nombre_empleado, t.fec_nac, t.direccion, t.telefono, t.email, t.id_turno], :style => [style, style, format_time, style, style, style, style]
        end
      end
      wb.add_worksheet(name: "EscuelaDeInglesExterna") do |sheet|
        sheet.add_row ["Id_escuela", "Nombre"], :style => style
        maestros = EscuelaDeInglesExternaController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_escuela, t.Nombre], :style => style
        end
      end
      wb.add_worksheet(name: "Estantes") do |sheet|
        sheet.add_row ["id_Estante", "Id_Seccion", "Clave"], :style => style
        maestros = EstantesController.new.data
        maestros.each do |t|
            sheet.add_row [t.id_Estante, t.Id_Seccion, t.Clave], :style => style
        end
      end
      wb.add_worksheet(name: "EvaluacionesIngreso") do |sheet|
        sheet.add_row ["Id_Evalu", "Id_Alumno", "Id_Pers", "Id_Tipo_eva", "Fecha_apl", "Resultado"], :style => style
        maestros = EvaluacionesIngresoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Evalu, t.Id_Alumno, t.Id_Pers, t.Id_Tipo_eva, t.Fecha_apl, t.Resultado], :style =>[style, style, style, style, format_time, style]
        end
      end
      wb.add_worksheet(name: "EventosAlumno") do |sheet|
        sheet.add_row ["Id_Alumno", "Id_evento_e", "Id_periodo_e"], :style => style
        maestros = EventosAlumnoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Alumno, t.Id_evento_e, t.Id_periodo_e], :style => style
        end
      end
      wb.add_worksheet(name: "Eventos") do |sheet|
        sheet.add_row ["Id_evento", "Nombre", "Descripcion", "Fecha", "Tipo_evento"], :style => style
        maestros = EventosController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_evento, t.Nombre, t.Descripcion, t.Fecha, t.Tipo_evento], :style => [style, style, style, format_time, style]
        end
      end
      wb.add_worksheet(name: "FormaTitulacion") do |sheet|
        sheet.add_row ["Id_Form_Titu", "Nombre"], :style => style
        maestros = FormaTitulacionController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Form_Titu, t.Nombre], :style => style
        end
      end
      wb.add_worksheet(name: "GrupoActividad") do |sheet|
        sheet.add_row ["Id_Grupo", "Id_actividad", "Nombre", "Cargo", "Id_area", "Dias", "Hora_inicio", "Hora_fin"], :style => style
        maestros = GrupoActividadController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Grupo, t.Id_actividad, t.Nombre, t.Cupo, t.Id_area, t.Dias, t.Hora_inicio, t.Hora_fin], :style => [style, style, style, style, style, style, time_f, time_f]
        end
      end
      wb.add_worksheet(name: "Grupo") do |sheet|
        sheet.add_row ["Id_Grupo", "Id_Materia", "Id_hora", "Id_Maestro", "Id_Periodo", "Id_Aula", "Clave"], :style => style
        maestros = GrupoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Grupo, t.Id_Materia, t.Id_hora, t.Id_Maestro, t.Id_Periodo, t.Id_Aula, t.Clave], :style => style
        end
      end
      wb.add_worksheet(name: "GrupoIngles") do |sheet|
        sheet.add_row ["Id_grupo_I", "Id_nivel", "Nombre", "Cupo", "Id_aula", "Dias", "Hora_inicio", "Hora_fin"], :style => style
        maestros = GrupoInglesController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_grupo_I, t.Id_nivel, t.Nombre, t.Cupo, t.Id_aula, t.Dias, t.Hora_inicio, t.Hora_fin], :style =>  [style, style, style, style, style, style, time_f, time_f]
        end
      end
      wb.add_worksheet(name: "Hardware") do |sheet|
        sheet.add_row ["idHardware", "fabricante", "modelo", "tipo_Hardware"], :style => style
        maestros = HardwareController.new.data
        maestros.each do |t|
            sheet.add_row [t.idHardware, t.fabricante, t.modelo, t.tipo_Hardware], :style => style
        end
      end
      wb.add_worksheet(name: "HardwareMantenimiento") do |sheet|
        sheet.add_row ["Id_Tipo_Mtto", "Fecha_Mtto", "Diagnostico", "No_Tecnico","id_Hardware"], :style => style
        maestros = HardwareMantenimientoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Tipo_Mtto, t.Fecha_Mtto, t.Diagnostico, t.No_Tecnico, t.id_Hardware], :style => [style, format_time, style, style, style]
        end
      end
      wb.add_worksheet(name: "Hora") do |sheet|
        sheet.add_row ["Id_Hora", "Hora_inicio", "Hora_fin"], :style => style
        maestros = HoraController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Hora, t.Hora_inicio, t.Hora_fin], :style => [style, time_f, time_f]
        end
      end
      wb.add_worksheet(name: "HorariosArea") do |sheet|
        sheet.add_row ["Id_area", "Hora_inicio", "Hora_fin"], :style => style
        maestros = HorariosAreaController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_area, t.Hora_inicio, t.Hora_fin], :style => [style, time_f, time_f]
        end
      end
      wb.add_worksheet(name: "Idiomas") do |sheet|
        sheet.add_row ["Id_Idioma", "Nombre", "codigo"], :style => style
        maestros = IdiomasController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Idioma, t.nombre, t.codigo], :style => style
        end
      end
      wb.add_worksheet(name: "Justificante") do |sheet|
        sheet.add_row ["Id_Just", "Id_Alumno", "Id_Personal", "Fecha_ini", "Fecha_fin", "Causa", "Fecha_elab"], :style => style
        maestros = JustificanteController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Just, t.Id_Alumno, t.Id_Personal, t.Fecha_ini, t.Fecha_fin, t.Causa, t.Fecha_elab], :style => [style, style, style, format_time, format_time, style, format_time]
        end
      end
      wb.add_worksheet(name: "Libros") do |sheet|
        sheet.add_row ["idLibro", "edicion", "aPublicacion", "ISBN", "Editorial"], :style => style
        maestros = LibrosController.new.data
        maestros.each do |t|
            sheet.add_row [t.idLibro, t.edicion, t.aPublicacion, t.ISBN, t.id_Editorial], :style => style
        end
      end
      wb.add_worksheet(name: "Logins") do |sheet|
        sheet.add_row ["Id_login", "usuario", "Apellidos", "Cargo"], :style => style
        maestros = LoginsController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_login, t.usuario, t.modificacion, t.fecha], :style => [style, style, style, format_datetime]
        end
      end
      wb.add_worksheet(name: "Maestros") do |sheet|
        sheet.add_row ["ID", "Área", "Tipo Contrato", "Nombre", "Correo Electrónico", "Teléfono", "Título", "Clave"], :style => style
        maestros = MaestrosController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec, t.Telefono, t.Id_Area_mtro, t.Titulo, t.Clave], :style => style
        end
      end
      wb.add_worksheet(name: "MaestroGrupoActividades") do |sheet|
        sheet.add_row ["Id_Maestro", "Id_grupo_Ac", "Id_periodo"], :style => style
        maestros = MaestroGrupoActividadesController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Maestro, t.Id_grupo_Ac, t.Id_periodo], :style => style
        end
      end
      wb.add_worksheet(name: "MaestroGrupoIngles") do |sheet|
        sheet.add_row ["Id_maestro", "Id_grupo_I", "Id_periodo"], :style => style
        maestros = MaestroGrupoInglesController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_maestro, t.Id_grupo_I, t.Id_periodo], :style => style
        end
      end
      wb.add_worksheet(name: "Materia") do |sheet|
        sheet.add_row ["Id_Materia", "Nombre", "Clave", "Créditos"], :style => style
        maestros = MateriaController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Materia, t.Nombre, t.Clave, t.Créditos], :style => style
        end
      end
      wb.add_worksheet(name: "Materiales") do |sheet|
        sheet.add_row ["id_Material", "Nombre", "autor", "existencia", "id_Pais", "Id_idioma", "Tipo_Material", "Id_Estante"], :style => style
        maestros = MaterialesController.new.data
        maestros.each do |t|
            sheet.add_row [t.id_Material, t.nombre, t.autor, t.existencia, t.id_Pais, t.Id_idioma,t.Tipo_Material, t.Id_Estante], :style => style
        end
      end
      wb.add_worksheet(name: "MovilidadAlumnoPeriodo") do |sheet|
        sheet.add_row ["Id_Movilidad", "Id_Alumno", "Id_Periodo"], :style => style
        maestros = MovilidadAlumnoPeriodoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Movilidad, t.Id_Alumno, t.Id_Periodo], :style => style
        end
      end
      wb.add_worksheet(name: "Movilidad") do |sheet|
        sheet.add_row ["Id_Movilidad", "Id_Carrera", "País", "Estado", "Universidad"], :style => style
        maestros = MovilidadController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Movilidad, t.Id_Carrera, t.País, t.Estado, t.Universidad], :style => style
        end
      end
      wb.add_worksheet(name: "Nivel De Ingles") do |sheet|
        sheet.add_row ["Id_Nivel", "Nombre", "Descripcion"], :style => style
        maestros = NivelDeInglesController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Nivel, t.Nombre, t.Descripcion], :style => style
        end
      end
      wb.add_worksheet(name: "Nivel Ingles Alumno") do |sheet|
        sheet.add_row ["Id_Alumno", "Id_Periodo", "Id_nivel", "Creditos"], :style => style
        maestros = NivelInglesAlumnoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Alumno, t.Id_Periodo, t.Id_nivel, t.Creditos], :style => style
        end
      end
      wb.add_worksheet(name: "Orden De Compra") do |sheet|
        sheet.add_row ["Id_orden_compra", "Fecha", "Costo", "Estado"], :style => style
        maestros = OrdenDeCompraController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_orden_compra, t.Fecha, t.Costo, t.Estado], :style => [style, format_time, style, style]
        end
      end
      wb.add_worksheet(name: "Paises") do |sheet|
        sheet.add_row ["id_Pais", "nombre_pais", "clave"], :style => style
        maestros = PaisesController.new.data
        maestros.each do |t|
            sheet.add_row [t.id_Pais, t.nombre_pais, t.clave], :style => style
        end
      end
      wb.add_worksheet(name: "Peliculas") do |sheet|
        sheet.add_row ["idFilm", "director", "ann_publicacion", "tipo_film"], :style => style
        maestros = PeliculasController.new.data
        maestros.each do |t|
            sheet.add_row [t.idFilm, t.director, t.ann_publicacion, t.tipo_film], :style => style
        end
      end
      wb.add_worksheet(name: "Perdidas Materiales") do |sheet|
        sheet.add_row ["Id_perdida", "Id_recurso", "Id_prestamo", "Cantidad", "Costo_total"], :style => style
        maestros = PerdidasMaterialesController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_perdida, t.Id_recurso, t.Id_prestamo, t.Cantidad, t.Costo_total], :style => style
        end
      end
      wb.add_worksheet(name: "Periodicos") do |sheet|
        sheet.add_row ["idPeriodico", "No_Serie", "fecha_publicado", "Id_Editorial"], :style => style
        maestros = PeriodicosController.new.data
        maestros.each do |t|
            sheet.add_row [t.idPeriodico, t.No_Serie, t.fecha_publicado, t.Id_Editorial], :style => [style, style, format_time,style]
        end
      end
      wb.add_worksheet(name: "Periodo") do |sheet|
        sheet.add_row ["Id_Periodo", "Nombre", "FechaIn", "FechaFin", "Abreviacion"], :style => style
        maestros = PeriodoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Periodo, t.Nombre, t.FechaIn, t.FechaFin, t.Abreviacion], :style => [style, style, format_time, format_time, style]
        end
      end
      wb.add_worksheet(name: "Personal Admin") do |sheet|
        sheet.add_row ["Id_Pers", "Id_Area", "Nombre", "CorreoE", "Fecha_Cont", "Estado"], :style => style
        maestros = PersonalAdminController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Pers, t.Id_Area, t.Nombre, t.CorreoE, t.Fecha_Cont, t.Estado], :style => [style, style, style,style, format_time, style]
        end
      end
      wb.add_worksheet(name: "Prestamos") do |sheet|
        sheet.add_row ["Id_maestro_ex", "Id_prestamo", "Id_periodo", "Fechaprestamo", "Fechaentrega", "Estado"], :style => style
        maestros = PrestamosController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_maestro_ex, t.Id_prestamo, t.Id_periodo, t.Fechaprestamo, t.Fechaentrega, t.Estado], :style => [style, style, style, format_time, format_time, style]
        end
      end
      wb.add_worksheet(name: "PrestamosMaterial") do |sheet|
        sheet.add_row ["Id_Prestamo_Mat", "fec_salida", "fec_entrega", "id_Material","Id_Solicitante", "Tipo_Solicitante", "id_Empleado", "tipo_prestamo"], :style => style
        maestros = PrestamosMaterialController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Prestamo_Mat, t.fec_salida, t.fec_entrega, t.id_Material,t.Id_Solicitante, t.Tipo_Solicitante, t.id_Empleado, t.tipo_prestamo], :style => [style, format_time, format_time, style, style, style, style, style]
        end
      end
      wb.add_worksheet(name: "PrestamosSala") do |sheet|
        sheet.add_row ["id_Prestamo_Sala", "Fecha", "Hora_Entrada", "Hora_Salida","id_Sala", "Id_Solicitante", "Tipo_Solicitante", "id_Empleado"], :style => style
        maestros = PrestamosSalaController.new.data
        maestros.each do |t|
            sheet.add_row [t.id_Prestamo_Sala, t.Fecha, t.Hora_Entrada, t.Hora_Salida, t.id_Sala, t.Id_Solicitante, t.Tipo_Solicitante, t.id_Empleado], :style => [style, format_time, time_f, time_f, style, style, style, style]
        end
      end
      wb.add_worksheet(name: "Productoras") do |sheet|
        sheet.add_row ["ID", "Nombre", "Ano_Fund", "Id_Pais"], :style => style
        maestros = ProductorasController.new.data
        maestros.each do |t|
            sheet.add_row [t.idProductora, t.Nombre, t.Ano_Fund, t.Id_Pais], :style => style
        end
      end
      wb.add_worksheet(name: "RecursoMaterial") do |sheet|
        sheet.add_row ["Id_recurso", "Area_pertenece", "Nombre", "Cantidad", "Costo"], :style => style
        maestros = RecursoMaterialController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_recurso, t.Area_pertenece, t.Nombre, t.Cantidad, t.Costo], :style => style
        end
      end
      wb.add_worksheet(name: "Revistas") do |sheet|
        sheet.add_row ["idRevista", "fecha_publicacion", "No_paginas", "Id_editorial"], :style => style
        maestros = RevistasController.new.data
        maestros.each do |t|
            sheet.add_row [t.idRevista, t.fecha_publicacion, t.No_paginas, t.Id_editorial], :style => [style, format_time, style, style]
        end
      end
      wb.add_worksheet(name: "SalaHardware") do |sheet|
        sheet.add_row ["Id_salon", "Id_Hardware", "Cantidad"], :style => style
        maestros = SalaHardwareController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_salon, t.Id_Hardware, t.Cantidad], :style => style
        end
      end
      wb.add_worksheet(name: "SalaTrabajo") do |sheet|
        sheet.add_row ["Id_salon", "Clave", "Capacidad"], :style => style
        maestros = SalaTrabajoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_salon, t.Clave, t.Capacidad], :style => style
        end
      end
      wb.add_worksheet(name: "Secciones") do |sheet|
        sheet.add_row ["id_Seccion", "Nombre"], :style => style
        maestros = SeccionesController.new.data
        maestros.each do |t|
            sheet.add_row [t.id_Seccion, t.Nombre], :style => style
        end
      end
      wb.add_worksheet(name: "Software") do |sheet|
        sheet.add_row ["idSoftware", "version", "ann_salida"], :style => style
        maestros = SoftwareController.new.data
        maestros.each do |t|
            sheet.add_row [t.idSoftware, t.version, t.ann_salida], :style => style
        end
      end
      wb.add_worksheet(name: "TipoBaja") do |sheet|
        sheet.add_row ["Id_Baja", "Nombre"], :style => style
        maestros = TipoBajaController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Baja, t.Nombre], :style => style
        end
      end
      wb.add_worksheet(name: "TipoConstancia") do |sheet|
        sheet.add_row ["Id_Tipo_con", "Nombre", "Costo"], :style => style
        maestros = TipoConstanciaController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Tipo_con, t.Nombre, t.Costo], :style => style
        end
      end
      wb.add_worksheet(name: "TipoContrato") do |sheet|
        sheet.add_row ["Id_contrato", "Nombre", "Duración"], :style => style
        maestros = TipoContratoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_contrato, t.Nombre, t.Duración], :style => style
        end
      end
      wb.add_worksheet(name: "TipoEvaluacion") do |sheet|
        sheet.add_row ["Id_Tipo_Eva", "Nombre", "Descripción"], :style => style
        maestros = TipoEvaluacionController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Tipo_Eva, t.Nombre, t.Descripción], :style => style
        end
      end
      wb.add_worksheet(name: "TipoMtto") do |sheet|
        sheet.add_row ["id_Tipo_Mtto", "Nombre", "Costo"], :style => style
        maestros = TipoMttoController.new.data
        maestros.each do |t|
            sheet.add_row [t.id_Tipo_Mtto, t.Nombre, t.Costo], :style => style
        end
      end
      wb.add_worksheet(name: "TipoPelicula") do |sheet|
        sheet.add_row ["Id_Tipo_Pel", "Nombre"], :style => style
        maestros = TipoPeliculaController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Tipo_Pel, t.Nombre], :style => style
        end
      end
      wb.add_worksheet(name: "Titulado") do |sheet|
        sheet.add_row ["Id_Titulado", "Id_Alumno", "Id Forma Titulación", "Fecha Titulación"], :style => style
        maestros = TituladoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Titulado, t.Id_Alumno, t.Id_Form_Titu, t.Fecha_Tit], :style => [style, style, style, format_time]
        end
      end
      wb.add_worksheet(name: "Turnos") do |sheet|
        sheet.add_row ["idTurno", "Nombre", "hora_inicio", "hora_fin"], :style => style
        maestros = TurnosController.new.data
        maestros.each do |t|
            sheet.add_row [t.idTurno, t.nomb_turno, t.hora_inicio, t.hora_fin], :style => [style, style, format_time, format_time]
        end
      end
      wb.add_worksheet(name: "Unidades") do |sheet|
        sheet.add_row ["Id_Unidad", "Id_Materia", "Nombre"], :style => style
        maestros = UnidadesController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Unidad, t.Id_Materia, t.Nombre], :style => style
        end
      end

      p.serialize('simple2.xlsx')
    end

    def delete_all_tables
      case current_user.tipo
      when 1
        Alumno.using(:data_warehouse).where(errorNombre: [1,2]).destroy_all
        Alumno.using(:data_warehouse).where(errorTelefono: [1,2]).destroy_all
        Alumno.using(:data_warehouse).where(errorCurp: [1,2]).destroy_all
        Alumno.using(:data_warehouse).where(errorPeso: [1,2]).destroy_all
        Alumno.using(:data_warehouse).where(errorCorreo: [1,2]).destroy_all
        Alumno.using(:data_warehouse).where(errorCreditos: [1,2]).destroy_all
        Alumno.using(:data_warehouse).where(errorPromedio: [1,2]).destroy_all
        Maestro.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Maestro.using(:data_warehouse).where(errorTelefono: 1).destroy_all
        Maestro.using(:data_warehouse).where(errorCorreo: 1).destroy_all
        Area_maestro.using(:data_warehouse).where(errorNombre: [1,2]).destroy_all
        Adeudos.using(:data_warehouse).where(errorCargo: 1).destroy_all
        Areas_admin.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Asistencia_alumno.using(:data_warehouse).where(errorAsistencias: 1).destroy_all
        Asistencia_alumno.using(:data_warehouse).where(errorFaltas: 1).destroy_all
        Asistencia_alumno.using(:data_warehouse).where(errorRetardos: 1).destroy_all
        Calificaciones_alumno.using(:data_warehouse).where(errorCalif: 1).destroy_all
        Carrera.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Carrera.using(:data_warehouse).where(errorCreditos: 1).destroy_all
        Detalle_orden_compra.using(:data_warehouse).where(errorCantidad: 1).destroy_all
        Detalle_orden_compra.using(:data_warehouse).where(errorCosto: 1).destroy_all
        Editorial.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Editorial.using(:data_warehouse).where(errorTelefono: 1).destroy_all
        Empleado.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Empleado.using(:data_warehouse).where(errorTelefono: 1).destroy_all
        Empleado.using(:data_warehouse).where(errorCorreo: 1).destroy_all
        Grupo_actividad.using(:data_warehouse).where(errorCupo: 1).destroy_all
        Grupo.using(:data_warehouse).where(errorClave: 1).destroy_all
        Libro.using(:data_warehouse).where(errorISBN: 1).destroy_all
        Materia.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Materia.using(:data_warehouse).where(errorCreditos: 1).destroy_all
        Materiales.using(:data_warehouse).where(errorAutor: 1).destroy_all
        Materiales.using(:data_warehouse).where(errorExistencia: 1).destroy_all
        Movilidad.using(:data_warehouse).where(errorPais: 1).destroy_all
        Movilidad.using(:data_warehouse).where(errorEstado: 1).destroy_all
        Orden_de_compra.using(:data_warehouse).where(errorEstado: 1).destroy_all
        Orden_de_compra.using(:data_warehouse).where(errorCosto: 1).destroy_all
        Paises.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Paises.using(:data_warehouse).where(errorClave: 1).destroy_all
        Perdidas_materiales.using(:data_warehouse).where(errorCosto: 1).destroy_all
        Perdidas_materiales.using(:data_warehouse).where(errorCantidad: 1).destroy_all
        Personal_Admin.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Personal_Admin.using(:data_warehouse).where(errorEstado: 1).destroy_all
        Prestamos.using(:data_warehouse).where(errorEstado: 1).destroy_all
        Recurso_material.using(:data_warehouse).where(errorCosto: 1).destroy_all
        Recurso_material.using(:data_warehouse).where(errorCantidad: 1).destroy_all
        Recurso_material.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Tipo_constancia.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Tipo_constancia.using(:data_warehouse).where(errorCosto: 1).destroy_all
        Tipo_evaluacion.using(:data_warehouse).where(errorNombre: 1).destroy_all
        campo_modificado = "Eliminó errores de las tablas de todos los sistemas"
      when 2
        Alumno.using(:data_warehouse).where(errorNombre: [1]).destroy_all
        Alumno.using(:data_warehouse).where(errorTelefono: [1,3]).destroy_all
        Alumno.using(:data_warehouse).where(errorCurp: [1]).destroy_all
        Alumno.using(:data_warehouse).where(errorCorreo: [1]).destroy_all
        Alumno.using(:data_warehouse).where(errorCreditos: [1]).destroy_all
        Alumno.using(:data_warehouse).where(errorPromedio: [1]).destroy_all
        Maestro.using(:data_warehouse).where(errorNombre: 1, base: 'c').destroy_all
        Maestro.using(:data_warehouse).where(errorTelefono: 1, base: 'c').destroy_all
        Maestro.using(:data_warehouse).where(errorCorreo: 1, base: 'c').destroy_all
        Area_maestro.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Areas_admin.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Carrera.using(:data_warehouse).where(errorNombre: 1, base: 'c').destroy_all
        Carrera.using(:data_warehouse).where(errorCreditos: 1, base: 'c').destroy_all
        Grupo.using(:data_warehouse).where(errorClave: 1).destroy_all
        Materia.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Materia.using(:data_warehouse).where(errorCreditos: 1).destroy_all
        Movilidad.using(:data_warehouse).where(errorPais: 1).destroy_all
        Movilidad.using(:data_warehouse).where(errorEstado: 1).destroy_all
        Personal_Admin.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Personal_Admin.using(:data_warehouse).where(errorEstado: 1).destroy_all
        Tipo_constancia.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Tipo_constancia.using(:data_warehouse).where(errorCosto: 1).destroy_all
        Tipo_evaluacion.using(:data_warehouse).where(errorNombre: 1).destroy_all
        campo_modificado = "Eliminó errores de las tablas de Control Académico"
      when 3
        Alumno.using(:data_warehouse).where(errorNombre: [2]).destroy_all
        Alumno.using(:data_warehouse).where(errorTelefono: [2,3]).destroy_all
        Alumno.using(:data_warehouse).where(errorPeso: [2]).destroy_all
        Alumno.using(:data_warehouse).where(errorCorreo: [2]).destroy_all
        Maestro.using(:data_warehouse).where(errorNombre: 1, base: 'e').destroy_all
        Maestro.using(:data_warehouse).where(errorTelefono: 1, base: 'e').destroy_all
        Maestro.using(:data_warehouse).where(errorCorreo: 1, base: 'e').destroy_all
        Asistencia_alumno.using(:data_warehouse).where(errorAsistencias: 1).destroy_all
        Asistencia_alumno.using(:data_warehouse).where(errorFaltas: 1).destroy_all
        Asistencia_alumno.using(:data_warehouse).where(errorRetardos: 1).destroy_all
        Calificaciones_alumno.using(:data_warehouse).where(errorCalif: 1).destroy_all
        Carrera.using(:data_warehouse).where(errorNombre: 1, base: 'e').destroy_all
        Carrera.using(:data_warehouse).where(errorCreditos: 1, base: 'e').destroy_all
        Detalle_orden_compra.using(:data_warehouse).where(errorCantidad: 1).destroy_all
        Detalle_orden_compra.using(:data_warehouse).where(errorCosto: 1).destroy_all
        Grupo_actividad.using(:data_warehouse).where(errorCupo: 1).destroy_all
        Orden_de_compra.using(:data_warehouse).where(errorEstado: 1).destroy_all
        Orden_de_compra.using(:data_warehouse).where(errorCosto: 1).destroy_all
        Perdidas_materiales.using(:data_warehouse).where(errorCosto: 1).destroy_all
        Perdidas_materiales.using(:data_warehouse).where(errorCantidad: 1).destroy_all
        Prestamos.using(:data_warehouse).where(errorEstado: 1).destroy_all    
        Recurso_material.using(:data_warehouse).where(errorCosto: 1).destroy_all
        Recurso_material.using(:data_warehouse).where(errorCantidad: 1).destroy_all
        Recurso_material.using(:data_warehouse).where(errorNombre: 1).destroy_all
        campo_modificado = "Eliminó errores de las tablas de Extraescolares"       
      when 4
        Maestro.using(:data_warehouse).where(errorNombre: 1, base: 'b').destroy_all
        Maestro.using(:data_warehouse).where(errorTelefono: 1, base: 'b').destroy_all
        Maestro.using(:data_warehouse).where(errorCorreo: 1, base: 'b').destroy_all
        Area_maestro.using(:data_warehouse).where(errorNombre: 2).destroy_all
        Adeudos.using(:data_warehouse).where(errorCargo: 1).destroy_all
        Carrera.using(:data_warehouse).where(errorNombre: 1, base: 'b').destroy_all
        Carrera.using(:data_warehouse).where(errorCreditos: 1, base: 'b').destroy_all
        Editorial.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Editorial.using(:data_warehouse).where(errorTelefono: 1).destroy_all
        Empleado.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Empleado.using(:data_warehouse).where(errorTelefono: 1).destroy_all
        Empleado.using(:data_warehouse).where(errorCorreo: 1).destroy_all
        Libro.using(:data_warehouse).where(errorISBN: 1).destroy_all
        Materiales.using(:data_warehouse).where(errorAutor: 1).destroy_all
        Materiales.using(:data_warehouse).where(errorExistencia: 1).destroy_all
        Paises.using(:data_warehouse).where(errorNombre: 1).destroy_all
        Paises.using(:data_warehouse).where(errorClave: 1).destroy_all
        campo_modificado = "Eliminó errores de las tablas de Biblioteca"
      end
      usuario = current_user.email
      fecha = DateTime.now.strftime("%d/%m/%Y %T")
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado) 
      redirect_to '/show_tables'
    end
end
