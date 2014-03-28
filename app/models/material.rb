class Material < ActiveRecord::Base
	has_many :testfiles, :foreign_key => "material_id", dependent: :destroy
	has_and_belongs_to_many :groups
attr_accessible :density, :elastic_modulus, :shear_modulus, :poissons_ratio, :yield_strength, :ultimate_tensile_strength, :ultimate_total_elongation, :hardness_value, :melting_point, :thermal_expansion, :thermal_conductivity, :specific_heat, :electrical_resistivity, :chemical_composition, :mat_name, :mat_type

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |material|
			  csv << material.attributes.values_at(*column_names)
			end
		end
	end
end
