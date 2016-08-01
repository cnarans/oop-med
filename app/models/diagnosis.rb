class Diagnosis

	attr_reader :id, :name, :timestamp, :disease_id

	attr_writer :id, :name, :timestamp, :disease_id

	def initialize(id, name, timestamp, disease_id)
		@id = id
		@name = name
		@timestamp = timestamp
		@disease_id = disease_id
	end

	def Diagnosis.find(id)
		records = DATA.execute("SELECT * FROM diagnosis WHERE id = #{id}")
		record = records[0]

		Diagnosis.new(record["id"], record["name"], record["timestamp"], record["disease_id"])
	end

	def save
	    DATA.execute("INSERT INTO diagnosis (name, timestamp, disease_id) VALUES ('#{name}', '#{timestamp}', #{disease_id})")
	    @id = DATA.last_insert_row_id
    	return self
  	end

  	def Diagnosis.getRecords(name)
  		records = DATA.execute("SELECT * FROM diagnosis WHERE name = '#{name}'")
  		return records
  	end

  	def Diagnosis.deleteRecords(name)
  		DATA.execute("DELETE FROM diagnosis WHERE name = '#{@name}'")
  	end

end