class Libro < ApplicationRecord
  self.table_name = "Libro"
  
  validates :ISBN, format: { with: /[0-9]{3}\-[0-9]{2}\-[0-9]{5}\-[0-9]{2}\-[0-9]/ , message: "El ISBN debe de ser del formato: ###-##-#####-##-#"}, on: :update
end