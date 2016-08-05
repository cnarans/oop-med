class Relationship

	# sets the table var for MedORM functions
	@table = "relationship"

	extend MedORM

	attr_reader :id, :disease_id, :symptom_id

	attr_writer :id, :disease_id, :symptom_id

	# constructor
	#
	def initialize(id, disease_id, symptom_id)
		@id = id
		@disease_id = disease_id
		@symptom_id = symptom_id
	end

	# saves the current instance information to the database
	#
	def save
	    DATA.execute("INSERT INTO relationship (disease_id, symptom_id) VALUES (#{disease_id}, #{symptom_id})")
	    @id = DATA.last_insert_row_id
    	return self
  	end

  	# returns an array of all Relationship records for the given disease
  	#
  	# disease_id => database id of the disease
  	#
  	def Relationship.allDisease(disease_id)
  		records = DATA.execute("SELECT * FROM relationship WHERE disease_id = #{disease_id}")
  		return_arr = []
  		for record in records
  			return_arr.push(Relationship.new(record["id"], record["disease_id"], record["symptom_id"]))
  		end
  		return return_arr
  	end

  	# Returns true if the given symptom is related to the given disease
	#
	# disease => index of disease
	# symptom => index of symptom
	#
	def Relationship.isSymptom(disease, symptom)
		opinion = DATA.execute("SELECT * FROM relationship WHERE disease_id=#{disease} AND symptom_id=#{symptom}")
		if opinion.empty?
			return false
		else
			return true
		end
	end

end