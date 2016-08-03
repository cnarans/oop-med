class Diagnosis
	require_relative 'medorm.rb'
	extend MedORM

	@table = "diagnosis"

	attr_reader :id, :name, :timestamp, :disease_id, :disease, :symptoms

	attr_writer :id, :name, :timestamp, :disease_id, :disease, :symptoms

	def initialize(id, name, timestamp, disease_id)
		@id = id
		@name = name
		@timestamp = timestamp
		@disease_id = disease_id
		@disease = Disease.nameOf(disease_id)
		@symptoms = []
		symp_ids = Relationship.allDisease(disease_id)
		for symp_id in symp_ids
			@symptoms.push(Symptom.nameOf(symp_id.symptom_id))
		end
	end

#	def Diagnosis.find(id)
#		records = DATA.execute("SELECT * FROM diagnosis WHERE id = #{id}")
#		record = records[0]
#
#		Diagnosis.new(record["id"], record["name"], record["timestamp"], record["disease_id"])
#	end

	def save
	    DATA.execute("INSERT INTO diagnosis (name, timestamp, disease_id) VALUES ('#{name}', '#{timestamp}', #{disease_id})")
	    @id = DATA.last_insert_row_id
    	return self
  	end

  	def Diagnosis.getRecords(name)
  		records = DATA.execute("SELECT * FROM diagnosis WHERE name = '#{name}'")
  		diagnosis_array = []
  		for record in records
  			diagnosis_array.push(Diagnosis.new(record["id"], record["name"], record["timestamp"], record["disease_id"]))
  		end
  		return diagnosis_array
  	end

  	def Diagnosis.deleteRecords(name)
  		DATA.execute("DELETE FROM diagnosis WHERE name = '#{name}'")
  	end

end