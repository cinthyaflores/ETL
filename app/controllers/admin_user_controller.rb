# frozen_string_literal: true

class AdminUserController < ApplicationController
  def init
    AlumnosController.new.init #LO INICIALIZA, PARA QUE EL INDEX SOLO MUESTRE LO QUE TIENE EL DATAWAREHOUSE
    MaestrosController.new.init
    ActividadExtraescolarController.new.index
    ActividadesPorAlumnoController.new.index
    AlumnoCompController.new.index
    AlumnoGrupoActividadController.new.index
    AlumnoGrupoInglesController.new.index
    AlumnosExternosInglesController.new.index
    AreaMaestroController.new.index
    AreaRecreativaController.new.index
    AreasAdminController.new.index
    ArticulosController.new.index
    AsistenciaAlumnoController.new.index
    AsistenciaMaestroController.new.index
    AulaController.new.index
    BajasController.new.index
    CalificacionesAlumnoController.new.index
    CambioCarreraController.new.index
    CarreraController.new.init
    CompetenciasController.new.index
    ConstanciasController.new.index
    DetalleOrdenCompraController.new.index
    DetallePrestamoController.new.index
    DiasController.new.index
    EditorialesController.new.index
    EscuelaDeInglesExternaController.new.index
    EstantesController.new.index
    EvaluacionesIngresoController.new.index
    EventosAlumnoController.new.index
    EventosController.new.index
    FormaTitulacionController.new.index
    GrupoActividadController.new.init
    GrupoController.new.init
    GrupoInglesController.new.index
    HardwareController.new.index
    HardwareMantenimientoController.new.index
    HoraController.new.index
    HorariosAreaController.new.index
    IdiomasController.new.index
    JustificanteController.new.index
    LibrosController.new.index
    MaestroGrupoActividadesController.new.index
    MaestroGrupoInglesController.new.index
    MateriaController.new.index
    MaterialesController.new.index
    MovilidadAlumnoPeriodoController.new.index
    MovilidadController.new.init
    NivelDeInglesController.new.index
    NivelInglesAlumnoController.new.index
    OrdenDeCompraController.new.index
    PaisesController.new.index
    PeliculasController.new.index
    PerdidasMaterialesController.new.index
    PeriodicosController.new.index
    PeriodoController.new.index
    PersonalAdminController.new.init
    PrestamosController.new.index
    PrestamosSalaController.new.index
    ProductorasController.new.index
    RecursoMaterialController.new.index
    RevistasController.new.index
    SalaHardwareController.new.index
    SalaTrabajoController.new.index
    SeccionesController.new.index
    SoftwareController.new.index
    TipoBajaController.new.index
    TipoConstanciaController.new.index
    TipoContratoController.new.index
    TipoMttoController.new.index
    TipoPeliculaController.new.index
    TituladoController.new.index
    UnidadesController.new.index
   
  end

  def errors
    redirect_to '/alumnos'
  end

  def download
    render :download
  end


end
