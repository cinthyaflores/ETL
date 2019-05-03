class ShowTablesController < ApplicationController

  def index
    
    tablas_errores

    if @all_empty
      export_to_sql
      excel
    end

    def delete_all
      delete_all_tables
    end

  end

  def download
    send_file("simple2.xlsx",filename: "data_warehouse.xlsx")
  end

  private

    def tablas_errores 
      #Método para saber si hay errores en las tablas.. Verify verifica los errores en las tablas según el tipo de usuario actual (Para que sólo muestre las que corresponden al usuario) ** Solo en las que puede haber errores **
      @all_empty = false
      c = current_user.tipo
      @alumnos = AlumnosController.new.verify(c)
      @maestros = MaestrosController.new.verify(c)
      @adeudos = AdeudosController.new.verify(c)
      @area_ma = AreaMaestroController.new.verify(c)
      
      @area_adm = AreasAdminController.new.verify(c)
      
      @asis_alu = AsistenciaAlumnoController.new.verify(c)
      # @asis_ma = AsistenciaMaestroController.new.verify(c)
  
      # @calif_alu = CalificacionesAlumnoController.new.verify(c)

      # @carrera = CarreraController.new.verify(c)

      # @deta_ord = DetalleOrdenCompraController.new.verify(c)
      # @deta_pres = DetallePrestamoController.new.verify(c)
      
      # @edito = EditorialesController.new.verify(c)
      # @emple = EmpleadosController.new.verify(c)
      
      
      # @evalu = EvaluacionesIngresoController.new.verify(c)
      
      
      # @forma_ti = FormaTitulacionController.new.verify(c)
      # @grupo_act = GrupoActividadController.new.verify(c)
      # @grupo = GrupoController.new.verify(c)
      # @grupo_ing = GrupoInglesController.new.verify(c)
      # @hardware = HardwareController.new.verify(c)
      # @hard_mant = HardwareMantenimientoController.new.verify(c)
      # @hora = HoraController.new.verify(c)
      # @hora_area = HorariosAreaController.new.verify(c)
      # @idiomas = IdiomasController.new.verify(c)
      # @justi = JustificanteController.new.verify(c)
      # @libros = LibrosController.new.verify(c)
      # @ma_gru_act = MaestroGrupoActividadesController.new.verify(c)
      # @ma_gru_ing = MaestroGrupoInglesController.new.verify(c)
      # @materia = MateriaController.new.verify(c)
      # @materiales = MaterialesController.new.verify(c)
      # @movi_alu = MovilidadAlumnoPeriodoController.new.verify(c)
      # @movili = MovilidadController.new.verify(c)
      # @nivel_ing = NivelDeInglesController.new.verify(c)
      # @nivel_alu = NivelInglesAlumnoController.new.verify(c)
      # @orden_comp = OrdenDeCompraController.new.verify(c)
      # @paises = PaisesController.new.verify(c)
      # @peliculas = PeliculasController.new.verify(c)
      # @perdi_mat = PerdidasMaterialesController.new.verify(c)
      # @periodicos = PeriodicosController.new.verify(c)
      # @periodo = PeriodoController.new.verify(c)
      # @pers_admin = PersonalAdmin.new.init
      # @prestamos = PrestamosController.new.verify(c)
      # @presta_mat = PrestamosMaterialController.new.verify(c)
      # @presta_sala = PrestamosSalaController.new.verify(c)
      # @produ = ProductorasController.new.verify(c)
      # @recu_mat = RecursoMaterialController.new.verify(c)
      # @revistas = RevistasController.new.verify(c)
      # @sala_hard = SalaHardwareController.new.verify(c)
      # @sala_tra = SalaTrabajoController.new.verify(c)
      # @secciones = SeccionesController.new.verify(c)
      # @software = SoftwareController.new.verify(c)
      # @tipo_baja = TipoBajaController.new.verify(c)
      # @tipo_const = TipoConstanciaController.new.verify(c)
      # @tipo_con = TipoContratoController.new.verify(c)
      # @tipo_eva = TipoEvaluacionController.new.verify(c)
      # @tipo_mtto = TipoMttoController.new.verify(c)
      # @tipo_peli = TipoPeliculaController.new.verify(c)
      # @titu = TituladoController.new.verify(c)
      # @turnos = TurnosController.new.verify(c)
      # @unidades = UnidadesController.new.verify(c)

      if !@alumnos && !@maestros && !@adeudos && !@area_ma && !@area_re && !@area_adm && !@articulos && !@asis_alu && !@asis_ma && !@aula && !@bajas && !@calif_alu && !@cam_ca && !@carrera && !@comp && !@const && !@deta_ord && !@deta_pres && !@dias && !@edito && !@emple && !@esc_ingl && !@estantes && !@evalu && !@even_alu && !@eventos && !@forma_ti && !@grupo_act && !@grupo && !@grupo_ing && !@hardware && !@hard_mant && !@hora && !@hora_area && !@idiomas && !@justi && !@libros && !@ma_gru_act && !@ma_gru_ing && !@materia && !@materiales && !@movi_alu && !@movili && !@nivel_ing && !@nivel_alu && !@orden_comp && !@paises && !@peliculas && !@perdi_mat && !@periodicos && !@periodo && !@pers_admin && !@prestamos && !@presta_mat && !@presta_sala && !@produ && !@recu_mat && !@revistas && !@sala_hard && !@sala_tra && !@secciones && !@software && !@tipo_baja && !@tipo_const && !@tipo_con && !@tipo_eva && !@tipo_mtto && !@tipo_peli && !@titu && !@turnos && !@unidades
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
      # @asis_ma = AsistenciaMaestroController.new.verify(c)

      AulaController.new.export_to_sql

      BajasController.new.export_to_sql
      # @calif_alu = CalificacionesAlumnoController.new.verify(c)

      CambioCarreraController.new.export_to_sql
      # @carrera = CarreraController.new.verify(c)

      CompetenciasController.new.export_to_sql
      ConstanciasController.new.export_to_sql
      # @deta_ord = DetalleOrdenCompraController.new.verify(c)
      # @deta_pres = DetallePrestamoController.new.verify(c)

      DiasController.new.export_to_sql
      # @edito = EditorialesController.new.verify(c)
      # @emple = EmpleadosController.new.verify(c)

      EscuelaDeInglesExternaController.new.export_to_sql
      EstantesController.new.export_to_sql

      # @evalu = EvaluacionesIngresoController.new.verify(c)

      EventosAlumnoController.new.export_to_sql
      EventosController.new.export_to_sql

      # @forma_ti = FormaTitulacionController.new.verify(c)
      # @grupo_act = GrupoActividadController.new.verify(c)
      # @grupo = GrupoController.new.verify(c)
      # @grupo_ing = GrupoInglesController.new.verify(c)
      # @hardware = HardwareController.new.verify(c)

      HardwareMantenimientoController.new.export_to_sql
      HoraController.new.export_to_sql
      HorariosAreaController.new.export_to_sql

      # @idiomas = IdiomasController.new.verify(c)

      JustificanteController.new.export_to_sql

      # @libros = LibrosController.new.verify(c)

      LoginsController.new.export_to_sql

      MaestroGrupoActividadesController.new.export_to_sql
      MaestroGrupoInglesController.new.export_to_sql

      # @materia = MateriaController.new.verify(c)
      # @materiales = MaterialesController.new.verify(c)

      MovilidadAlumnoPeriodoController.new.export_to_sql

      # @movili = MovilidadController.new.verify(c)

      NivelDeInglesController.new.export_to_sql

      # @nivel_alu = NivelInglesAlumnoController.new.verify(c)
      # @orden_comp = OrdenDeCompraController.new.verify(c)
      # @paises = PaisesController.new.verify(c)
      # @peliculas = PeliculasController.new.verify(c)
      # @perdi_mat = PerdidasMaterialesController.new.verify(c)
      # @periodicos = PeriodicosController.new.verify(c)

      PeriodoController.new.export_to_sql

      # @pers_admin = PersonalAdmin.new.init
      # @prestamos = PrestamosController.new.verify(c)
      PrestamosMaterialController.new.export_to_sql
      PrestamosSalaController.new.export_to_sql

      # @produ = ProductorasController.new.verify(c)
      # @recu_mat = RecursoMaterialController.new.verify(c)
      # @revistas = RevistasController.new.verify(c)
      # @sala_hard = SalaHardwareController.new.verify(c)
      # @sala_tra = SalaTrabajoController.new.verify(c)

      SeccionesController.new.export_to_sql

      # @software = SoftwareController.new.verify(c)
      # @tipo_baja = TipoBajaController.new.verify(c)
      # @tipo_const = TipoConstanciaController.new.verify(c)

      TipoContratoController.new.export_to_sql

      # @tipo_eva = TipoEvaluacionController.new.verify(c)
      # @tipo_mtto = TipoMttoController.new.verify(c)
      # @tipo_peli = TipoPeliculaController.new.verify(c)

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
        sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
        alumnos.each do |t|
            sheet.add_row [t.Id_Alumno, t.No_control, t.Nombre, t.Id_Carrera], :style => style
        end
      end
      wb.add_worksheet(name: "Maestros") do |sheet|
        sheet.add_row ["ID", "Área", "Tipo Contrato", "Nombre", "Correo Electrónico", "Teléfono", "Título", "Clave"], :style => style
        maestros = MaestrosController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
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
            sheet.add_row [t.Id_alumno, t.Id_Periodo, t.Asistencias, t.Faltas, t.Retardos] :style => style
        end
      end
      # wb.add_worksheet(name: "AsistenciaMaestro") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = AsistenciaMaestroController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
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
      # wb.add_worksheet(name: "CalificacionesAlumno") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = CalificacionesAlumnoController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      wb.add_worksheet(name: "CambioCarrera") do |sheet|
        sheet.add_row ["Id_Cambio", "Id_Alumno", "Id_Carr_Ant", "Fec_Cambio"], :style => style
        maestros = CambioCarreraController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Cambio, t.Id_Alumno, t.Id_Carr_Ant, t.Fec_Cambio], :style => [style, style, style, format_time]
        end
      end
      # wb.add_worksheet(name: "Carrera") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = CarreraController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
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
      # wb.add_worksheet(name: "DetalleOrdenCompra") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = DetalleOrdenCompraController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "DetallePrestamo") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = DetallePrestamoController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      wb.add_worksheet(name: "Dias") do |sheet|
        sheet.add_row ["Id_dias", "Descripcion"], :style => style
        maestros = DiasController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_dias, t.Descripcion], :style => style
        end
      end
      # wb.add_worksheet(name: "Editoriales") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = EditorialesController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "Empleados") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = EmpleadosController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
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
      # wb.add_worksheet(name: "EvaluacionesIngreso") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = EvaluacionesIngresoController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
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
      # wb.add_worksheet(name: "FormaTitulacion") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = FormaTitulacionController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "GrupoActividad") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = GrupoActividad.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "Grupo") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = GrupoController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "GrupoIngles") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = GrupoInglesController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "Hardware") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = HardwareController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
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
      # wb.add_worksheet(name: "Idiomas") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = IdiomasController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      wb.add_worksheet(name: "Justificante") do |sheet|
        sheet.add_row ["Id_Just", "Id_Alumno", "Id_Personal", "Fecha_ini", "Fecha_fin", "Causa", "Fecha_elab"], :style => style
        maestros = JustificanteController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Just, t.Id_Alumno, t.Id_Personal, t.Fecha_ini, t.Fecha_fin, t.Causa, t.Fecha_elab], :style => [style, style, style, format_time, format_time, style, format_time]
        end
      end
      # wb.add_worksheet(name: "Libros") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = LibrosController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      wb.add_worksheet(name: "Logins") do |sheet|
        sheet.add_row ["Id_login", "usuario", "Apellidos", "Cargo"], :style => style
        maestros = LoginsController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_login, t.usuario, t.modificacion, t.fecha], :style => [style, style, style, format_datetime]
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
      # wb.add_worksheet(name: "Materia") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = MateriaController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "Materiales") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = MaterialesController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      wb.add_worksheet(name: "MovilidadAlumnoPeriodo") do |sheet|
        sheet.add_row ["Id_Movilidad", "Id_Alumno", "Id_Periodo"], :style => style
        maestros = MovilidadAlumnoPeriodoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Movilidad, t.Id_Alumno, t.Id_Periodo], :style => style
        end
      end
      # wb.add_worksheet(name: "Movilidad") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = Movilidad.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      wb.add_worksheet(name: "NivelDeInglesController") do |sheet|
        sheet.add_row ["Id_Nivel", "Nombre", "Descripcion"], :style => style
        maestros = NivelDeInglesController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Nivel, t.Nombre, t.Descripcion], :style => style
        end
      end
      # wb.add_worksheet(name: "NivelInglesAlumnoController") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = NivelInglesAlumno.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "OrdenDeCompraController") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = OrdenDeCompra.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "PaisesController") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = Paises.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "PeliculasController") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = PeliculasController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "PerdidasMateriales") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = PerdidasMaterialesController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "Periodicos") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = PeriodicosController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      wb.add_worksheet(name: "Periodo") do |sheet|
        sheet.add_row ["Id_Periodo", "Nombre", "FechaIn", "FechaFin", "Abreviacion"], :style => style
        maestros = PeriodoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_Periodo, t.Nombre, t.FechaIn, t.FechaFin, t.Abreviacion], :style => [style, style, format_time, format_time, style]
        end
      end
      # wb.add_worksheet(name: "PersonalAdmin") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = PersonalAdmin.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "Prestamos") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = PrestamosController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
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
      # wb.add_worksheet(name: "Productoras") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = ProductorasController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "RecursoMaterial") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = RecursoMaterialController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "Revistas") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = RevistasController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "SalaHardware") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = SalaHardwareController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "SalaTrabajo") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = SalaTrabajoController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      wb.add_worksheet(name: "Secciones") do |sheet|
        sheet.add_row ["id_Seccion", "Nombre"], :style => style
        maestros = SeccionesController.new.data
        maestros.each do |t|
            sheet.add_row [t.id_Seccion, t.Nombre], :style => style
        end
      end
      # wb.add_worksheet(name: "Software") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = SoftwareController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "TipoBaja") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = TipoBajaController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "TipoConstancia") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = TipoConstanciaController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      wb.add_worksheet(name: "TipoContrato") do |sheet|
        sheet.add_row ["Id_contrato", "Nombre", "Duración"], :style => style
        maestros = TipoContratoController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_contrato, t.Nombre, t.Duración], :style => style
        end
      end
      # wb.add_worksheet(name: "TipoEvaluacion") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = TipoEvaluacionController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "TipoMtto") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = TipoMttoController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
      # wb.add_worksheet(name: "TipoPelicula") do |sheet|
      #   sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"], :style => style
      #   maestros = TipoPeliculaController.new.data
      #   maestros.each do |t|
      #       sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec], :style => style
      #   end
      # end
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
      Alumno.using(:data_warehouse).where(errorNombre: 1).destroy_all
      Alumno.using(:data_warehouse).where(errorNombre: 2).destroy_all
      Alumno.using(:data_warehouse).where(errorTelefono: 1).destroy_all
      Alumno.using(:data_warehouse).where(errorTelefono: 2).destroy_all
      Alumno.using(:data_warehouse).where(errorCurp: 1).destroy_all
      Alumno.using(:data_warehouse).where(errorCurp: 2).destroy_all
      Alumno.using(:data_warehouse).where(errorPeso: 1).destroy_all
      Alumno.using(:data_warehouse).where(errorPeso: 2).destroy_all   
      Alumno.using(:data_warehouse).where(errorCorreo: 1).destroy_all
      Alumno.using(:data_warehouse).where(errorCorreo: 2).destroy_all
      Alumno.using(:data_warehouse).where(errorCurp: 1).destroy_all
      Alumno.using(:data_warehouse).where(errorCurp: 2).destroy_all
      Alumno.using(:data_warehouse).where(errorPromedio: 1).destroy_all
      Alumno.using(:data_warehouse).where(errorPromedio: 2).destroy_all
      Maestro.using(:data_warehouse).where(errorNombre: 1).destroy_all
      Maestro.using(:data_warehouse).where(errorTelefono: 1).destroy_all
      Maestro.using(:data_warehouse).where(errorCorreo: 1).destroy_all
      Area_maestro.using(:data_warehouse).where(errorNombre: 1).destroy_all
      Area_maestro.using(:data_warehouse).where(errorNombre: 2).destroy_all
      Adeudos.using(:data_warehouse).where(errorCargo: 1).destroy_all
      usuario = current_user.email
      fecha = DateTime.now.strftime("%d/%m/%Y %T")
      campo_modificado = "Eliminó todos errores"
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado) 
      redirect_to '/show_tables'
    end
end
