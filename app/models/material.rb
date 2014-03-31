class Material < ActiveRecord::Base
	has_many :testfiles, :foreign_key => "material_id", dependent: :destroy
	has_many :mat_membership, :foreign_key => "material_id"
	has_many :groups, through: :mat_membership
attr_accessible :density, :elastic_modulus, :shear_modulus, :poissons_ratio, :yield_strength, :ultimate_tensile_strength, :ultimate_total_elongation, :hardness_value, :melting_point, :thermal_expansion, :thermal_conductivity, :specific_heat, :electrical_resistivity, :chemical_composition, :mat_name, :mat_type
	
	filterrific(
  	:default_settings => { :sorted_by => 'id_asc' },
  	:filter_names => [:search_query,:sorted_by,:with_created_at_gte]
	)

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |material|
			  csv << material.attributes.values_at(*column_names)
			end
		end
	end

  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(materials.mat_name) LIKE ?",
          "LOWER(materials.mat_type) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^id_/
      order("materials.id #{ direction }")
    when /^created_at_/
      order("materials.created_at #{ direction }")
    when /^mat_name_/
      order("LOWER(materials.mat_name) #{ direction }")
    when /^density_/
      order("materials.density #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  
  scope :with_created_at_gte, lambda { |ref_date|
    where('materials.created_at >= ?', ref_date)
  }

  
  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'mat_name_asc'],
      ['Registration date (newest first)', 'created_at_desc'],
      ['Registration date (oldest first)', 'created_at_asc'],
      ['Density (Smallest to Largest)', 'density_asc']
    ]
  end

  def decorated_created_at
    created_at.to_date.to_s(:long)
  end

end
