class Relationship

	@table = "relationship"

	extend MedORM

	attr_reader :id, :disease_id, :symptom_id

	attr_writer :id, :disease_id, :symptom_id

	def initialize(id, disease_id, symptom_id)
		@id = id
		@disease_id = disease_id
		@symptom_id = symptom_id
	end

	def save
	    DATA.execute("INSERT INTO relationship (disease_id, symptom_id) VALUES (#{disease_id}, #{symptom_id})")
	    @id = DATA.last_insert_row_id
    	return self
  	end

  	def Relationship.allDisease(disease_id)
  		records = DATA.execute("SELECT * FROM relationship WHERE disease_id = #{disease_id}")
  		return_arr = []
  		for record in records
  			return_arr.push(Relationship.new(record["id"], record["disease_id"], record["symptom_id"]))
  		end
  		return return_arr
  	end

end