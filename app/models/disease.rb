class Disease

	@table = "disease"

	extend MedORM

	attr_reader :id, :name

	attr_writer :id, :name

	def initialize(id, name)
		@id = id
		@name = name
	end

	def save
	    DATA.execute("INSERT INTO disease (name) VALUES ('#{name}')")
	    @id = DATA.last_insert_row_id
    	return self
  	end

  	def Disease.nameOf(id)
  		record = Disease.find(id)
  		return record.name
  	end

end