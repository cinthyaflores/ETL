# frozen_string_literal: true

class AdminUserController < ApplicationController

  def index 
    @empty = db_empty
  end

  def init
    AlumnosController.new.init #LO INICIALIZA, PARA QUE EL INDEX SOLO MUESTRE LO QUE TIENE EL DATAWAREHOUSE
    MaestrosController.new.init
    ActividadExtraescolarController.new.init
    ActividadesPorAlumnoController.new.init
    AdeudosController.new.init
    AlumnoCompController.new.init
    AlumnoGrupoController.new.init
    AlumnoGrupoActividadController.new.init
    AlumnoGrupoInglesController.new.init
    AlumnosExternosInglesController.new.init
    AreaMaestroController.new.init
    AreaRecreativaController.new.init
    AreasAdminController.new.init
    ArticulosController.new.init
    AsistenciaAlumnoController.new.init
    AsistenciaMaestroController.new.init
    AulaController.new.init
    BajasController.new.init
    CalificacionesAlumnoController.new.init
    CambioCarreraController.new.init
    CarreraController.new.init
    CompetenciasController.new.init
    ConstanciasController.new.init
    DetalleOrdenCompraController.new.init
    DetallePrestamoController.new.init
    DiasController.new.init
    EditorialesController.new.init
    EmpleadosController.new.init
    EscuelaDeInglesExternaController.new.init
    EstantesController.new.init
    EvaluacionesIngresoController.new.init
    EventosAlumnoController.new.init
    EventosController.new.init
    FormaTitulacionController.new.init
    GrupoActividadController.new.init
    GrupoController.new.init
    GrupoInglesController.new.init
    HardwareController.new.init
    HardwareMantenimientoController.new.init
    HoraController.new.init
    HorariosAreaController.new.init
    IdiomasController.new.init
    JustificanteController.new.init
    LibrosController.new.init
    MaestroGrupoActividadesController.new.init
    MaestroGrupoInglesController.new.init
    MateriaController.new.init
    MaterialesController.new.init
    MovilidadAlumnoPeriodoController.new.init
    MovilidadController.new.init
    NivelDeInglesController.new.init
    NivelInglesAlumnoController.new.init
    OrdenDeCompraController.new.init
    PaisesController.new.init
    PeliculasController.new.init
    PerdidasMaterialesController.new.init
    PeriodicosController.new.init
    PeriodoController.new.init
    PersonalAdminController.new.init
    PrestamosController.new.init
    PrestamosMaterialController.new.init
    PrestamosSalaController.new.init
    ProductorasController.new.init
    RecursoMaterialController.new.init
    RevistasController.new.init
    SalaHardwareController.new.init
    SalaTrabajoController.new.init
    SeccionesController.new.init
    SoftwareController.new.init
    TipoBajaController.new.init
    TipoConstanciaController.new.init
    TipoContratoController.new.init
    TipoEvaluacionController.new.init
    TipoMttoController.new.init
    TipoPeliculaController.new.init
    TituladoController.new.init
    TurnosController.new.init
    UnidadesController.new.init
    
    redirect_to show_tables_index_path

  end

end
