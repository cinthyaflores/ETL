class ShowTablesController < ApplicationController

  def index
    @errores = db_empty
    if !@errores
      tablas_errores
    end

    if @all_empty
      export_to_sql
      excel
    end

  end

  def download
    send_file("simple2.xlsx",filename: "data_warehouse.xlsx")
  end

  private

    def tablas_errores
      c = current_user.tipo
      @alumnos = AlumnosController.new.verify(c)
      @maestros = MaestrosController.new.verify(c)
      # @act_extra = ActividadExtraescolarController.new.verify(c)
      # @act_alu = ActividadesPorAlumnoController.new.verify(c)
      # @adeudos = AdeudosController.new.verify(c)
      # @alu_comp = AlumnoCompController.new.verify(c)
      # @alu_grupo = AlumnoGrupoController.new.verify(c)
      # @alu_grupo_act = AlumnoGrupoActividadController.new.verify(c)
      # @alu_grupo_ing = AlumnoGrupoInglesController.new.verify(c)
      # @alu_ext_ing = AlumnosExternosInglesController.new.verify(c)
      # @area_ma = AreaMaestroController.new.verify(c)
      # @area_re = AreaRecreativaController.new.verify(c)
      # @area_adm = AreasAdminController.new.verify(c)
      # @articulos = ArticulosController.new.verify(c)
      # @asis_alu = AsistenciaAlumnoController.new.verify(c)
      # @asis_ma = AsistenciaMaestroController.new.verify(c)
      # @aula = AulaController.new.verify(c)
      # @bajas = BajasController.new.verify(c)
      # @calif_alu = CalificacionesAlumnoController.new.verify(c)
      # @cam_ca = CambioCarreraController.new.verify(c)
      # @carrera = CarreraController.new.verify(c)
      # @comp = CompetenciasController.new.verify(c)
      # @const = ConstanciasController.new.verify(c)
      # @deta_ord = DetalleOrdenCompraController.new.verify(c)
      # @deta_pres = DetallePrestamoController.new.verify(c)
      # @dias = DiasController.new.verify(c)
      # @edito = EditorialesController.new.verify(c)
      # @emple = EmpleadosController.new.verify(c)
      # @esc_ingl = EscuelaDeInglesExternaController.new.verify(c)
      # @estantes = EstantesController.new.verify(c)
      # @evalu = EvaluacionesIngresoController.new.verify(c)
      # @even_alu = EventosAlumnoController.new.verify(c)
      # @eventos = EventosController.new.verify(c)
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
      # @movili = Movilidad.new.init
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

      if !@alumnos && !@maestros && !@act_extra && !@act_alu && !@adeudos && !@alu_comp && !@alu_grupo && !@alu_grupo_act && !@alu_grupo_ing && !@alu_ext_ing && !@area_ma && !@area_re && !@area_adm && !@articulos && !@asis_alu && !@asis_ma && !@aula && !@bajas && !@calif_alu && !@cam_ca && !@carrera && !@comp && !@const && !@deta_ord && !@deta_pres && !@dias && !@edito && !@emple && !@esc_ingl && !@estantes && !@evalu && !@even_alu && !@eventos && !@forma_ti && !@grupo_act && !@grupo && !@grupo_ing && !@hardware && !@hard_mant && !@hora && !@hora_area && !@idiomas && !@justi && !@libros && !@ma_gru_act && !@ma_gru_ing && !@materia && !@materiales && !@movi_alu && !@movili && !@nivel_ing && !@nivel_alu && !@orden_comp && !@paises && !@peliculas && !@perdi_mat && !@periodicos && !@periodo && !@pers_admin && !@prestamos && !@presta_mat && !@presta_sala && !@produ && !@recu_mat && !@revistas && !@sala_hard && !@sala_tra && !@secciones && !@software && !@tipo_baja && !@tipo_const && !@tipo_con && !@tipo_eva && !@tipo_mtto && !@tipo_peli && !@titu && !@turnos && !@unidades
        @all_empty = true
      end

    end

    def export_to_sql
      AlumnosController.new.export_to_sql
      MaestrosController.new.export_to_sql

      # @act_extra = ActividadExtraescolarController.new.verify(c)
      # @act_alu = ActividadesPorAlumnoController.new.verify(c)
      # @adeudos = AdeudosController.new.verify(c)
      # @alu_comp = AlumnoCompController.new.verify(c)
      # @alu_grupo = AlumnoGrupoController.new.verify(c)
      # @alu_grupo_act = AlumnoGrupoActividadController.new.verify(c)
      # @alu_grupo_ing = AlumnoGrupoInglesController.new.verify(c)
      # @alu_ext_ing = AlumnosExternosInglesController.new.verify(c)
      # @area_ma = AreaMaestroController.new.verify(c)
      # @area_re = AreaRecreativaController.new.verify(c)
      # @area_adm = AreasAdminController.new.verify(c)
      # @articulos = ArticulosController.new.verify(c)
      # @asis_alu = AsistenciaAlumnoController.new.verify(c)
      # @asis_ma = AsistenciaMaestroController.new.verify(c)
      # @aula = AulaController.new.verify(c)
      # @bajas = BajasController.new.verify(c)
      # @calif_alu = CalificacionesAlumnoController.new.verify(c)
      # @cam_ca = CambioCarreraController.new.verify(c)
      # @carrera = CarreraController.new.verify(c)
      # @comp = CompetenciasController.new.verify(c)
      # @const = ConstanciasController.new.verify(c)
      # @deta_ord = DetalleOrdenCompraController.new.verify(c)
      # @deta_pres = DetallePrestamoController.new.verify(c)
      # @dias = DiasController.new.verify(c)
      # @edito = EditorialesController.new.verify(c)
      # @emple = EmpleadosController.new.verify(c)
      # @esc_ingl = EscuelaDeInglesExternaController.new.verify(c)
      # @estantes = EstantesController.new.verify(c)
      # @evalu = EvaluacionesIngresoController.new.verify(c)
      # @even_alu = EventosAlumnoController.new.verify(c)
      # @eventos = EventosController.new.verify(c)
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
      # @movili = Movilidad.new.init
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
    end

    def excel 
      p = Axlsx::Package.new
      wb = p.workbook
      wb.add_worksheet(name: "Alumnos") do |sheet|
        alumnos = AlumnosController.new.data
        sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"]
        alumnos.each do |t|
            sheet.add_row [t.Id_Alumno, t.No_control, t.Nombre, t.Id_Carrera]
        end
      end
      wb.add_worksheet(name: "Maestros") do |sheet|
        sheet.add_row ["ID", "Nombre", "Apellidos", "Cargo"]
        maestros = MaestrosController.new.data
        maestros.each do |t|
            sheet.add_row [t.Id_maestro, t.Id_Area_mtro, t.Nombre, t.CorreoElec]
        end
      end
      p.serialize('simple2.xlsx')
    end

end
