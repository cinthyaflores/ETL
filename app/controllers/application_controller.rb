# frozen_string_literal: true

class ApplicationController < ActionController::Base
  require "roo"
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  private

    # PARA AGREGAR MÁS DATOS AL INICIO DE SESION DE DEVISE (solo se ponen los datos extras)
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:tipo])
    end
  
    def validate_name (name)
      !!(name =~ /\d+/) # Validar si el nombre tiene numeros. Convertir a boolean SOLO LETRAS: /^\D+/
    end
  
    def validate_number (num) # Validar números telefónicos (10 digitos)
      !!(num =~ /^\d{10}$/)
    end
  
    def validate_curp (curp)
      !!(curp =~ /^[A-Z]{4}+\d{6}+[A-Z]{6}+\d{2}$/)
    end
  
    def validate_weight(peso)
      !!(peso.to_s =~ /^\d+/) # Debe de tener puros numeros
    end
  
    def validate_clave(clave)
      !!(clave =~ /^[A-Z]{2}+\d{4}$/)
    end
  
    def validate_estado(estado)
      !!(estado.to_s =~ /[1-2]{1}/)
    end

    def validate_estado_tres(estado)
      !!(estado.to_s =~ /[1-3]{1}/)
    end

    def validate_email(correo)
      puts correo
      puts !!(correo.to_s =~ /\A([a-zA-Z\u00d1\u00f1\d]+)+@+(\w+)+\.+(\w+)\z/)
      !!(correo.to_s =~ /\A([a-zA-Z\u00d1\u00f1\d]+)+@+(\w+)+\.+(\w+)\z/)
    end

    def validate_date(fecha)
      puts !!(fecha.to_s =~ /\A\d{4}-\d{2}-\d{2}\z/)
      !!(fecha.to_s =~ /\A\d{4}-\d{2}-\d{2}\z/)
    end
  
    def validate_oportunidad(op)
      return false unless op.upcase == "PRIMERA" || op.upcase == "SEGUNDA" 
    end
  
    def find_id_alumno(no_ctrl)
      data = Alumno.using(:data_warehouse).all
      data.each do |alumno|
        return alumno.Id_Alumno if alumno.No_control == no_ctrl
      end
    end
  
    def area_maestro(tipo)
      return 10 if tipo == 2
      return 11 if tipo == 1
    end
  
    def area_maestro_id(clave)
      maestros_data = Maestro.using(:data_warehouse).all
      maestros_data.each do |maestro|
        return maestro.Id_Area_mtro if maestro.Clave == clave
      end
    end
  
    def find_id_maestro(clave)
      data = Maestro.using(:data_warehouse).all
      data.each do |maestro|
        return maestro.Id_maestro if maestro.Clave == clave
      end
    end
  
    def find_nombre_alumno(id_alumno)
      biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
      solicitantes = biblio.sheet("Solicitante")
      solicitantes.each do |soli|
        if soli[1] == id_alumno && soli[2] == 1
          return soli[3]
        end
      end
    end

    def get_numbers(string)
      string.gsub(/[^\d]/, '')
    end

    def db_empty
      return AlumnosController.new.empty
      return MaestrosController.new.empty
      # return ActividadExtraescolarController.new.empty
      # return ActividadesPorAlumnoController.new.empty
      # return AdeudosController.new.empty
      # return AlumnoCompController.new.empty
      # return AlumnoGrupoController.new.empty
      # return AlumnoGrupoActividadController.new.empty
      # return AlumnoGrupoInglesController.new.empty
      # return AlumnosExternosInglesController.new.empty
      # return AreaMaestroController.new.empty
      # return AreaRecreativaController.new.empty
      # return AreasAdminController.new.empty
      # return ArticulosController.new.empty
      # return AsistenciaAlumnoController.new.empty
      # return AsistenciaMaestroController.new.empty
      # return AulaController.new.empty
      # return BajasController.new.empty
      # return CalificacionesAlumnoController.new.empty
      # return CambioCarreraController.new.empty
      # return CarreraController.new.empty
      # return CompetenciasController.new.empty
      # return ConstanciasController.new.empty
      # return DetalleOrdenCompraController.new.empty
      # return DetallePrestamoController.new.empty
      # return DiasController.new.empty
      # return EditorialesController.new.empty
      # return EmpleadosController.new.empty
      # return EscuelaDeInglesExternaController.new.empty
      # return EstantesController.new.empty
      # return EvaluacionesIngresoController.new.empty
      # return EventosAlumnoController.new.empty
      # return EventosController.new.empty
      # return FormaTitulacionController.new.empty
      # return GrupoActividadController.new.empty
      # return GrupoController.new.empty
      # return GrupoInglesController.new.empty
      # return HardwareController.new.empty
      # return HardwareMantenimientoController.new.empty
      # return HoraController.new.empty
      # return HorariosAreaController.new.empty
      # return IdiomasController.new.empty
      # return JustificanteController.new.empty
      # return LibrosController.new.empty
      # return MaestroGrupoActividadesController.new.empty
      # return MaestroGrupoInglesController.new.empty
      # return MateriaController.new.empty
      # return MaterialesController.new.empty
      # return MovilidadAlumnoPeriodoController.new.empty
      # return Movilidad.new.init
      # return NivelDeInglesController.new.empty
      # return NivelInglesAlumnoController.new.empty
      # return OrdenDeCompraController.new.empty
      # return PaisesController.new.empty
      # return PeliculasController.new.empty
      # return PerdidasMaterialesController.new.empty
      # return PeriodicosController.new.empty
      # return PeriodoController.new.empty
      # return PersonalAdmin.new.init
      # return PrestamosController.new.empty
      # return PrestamosMaterialController.new.empty
      # return PrestamosSalaController.new.empty
      # return ProductorasController.new.empty
      # return RecursoMaterialController.new.empty
      # return RevistasController.new.empty
      # return SalaHardwareController.new.empty
      # return SalaTrabajoController.new.empty
      # return SeccionesController.new.empty
      # return SoftwareController.new.empty
      # return TipoBajaController.new.empty
      # return TipoConstanciaController.new.empty
      # return TipoContratoController.new.empty
      # return TipoEvaluacionController.new.empty
      # return TipoMttoController.new.empty
      # return TipoPeliculaController.new.empty
      # return TituladoController.new.empty
      # return TurnosController.new.empty
      # return UnidadesController.new.empty
      return true
    end

end
