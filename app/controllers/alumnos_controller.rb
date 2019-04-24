class AlumnosController < ApplicationController
  def index  
    @alumno = Alumno.using(:controlA).all
    @alumnoE= Alumno.using(:extra).all
  end

  private

  def export
    alumnosData = Alumno.using(:Data)
    aluControl = Alumno.using(:controlA).all
    
    aluControl.each do |alumno|
      #alumnosData.No_control = alumno.No_Control
      #etc
      #alumnosData.save
    end
    
  end

  

end
