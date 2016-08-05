class Disease

	# sets table var for MedORM functions
	@table = "disease"

	extend MedORM

	attr_reader :id, :name

	attr_writer :id, :name

	# constructor
	#
	def initialize(id, name)
		@id = id
		@name = name
	end

	# saves current instance information to database
	#
	def save
	    DATA.execute("INSERT INTO disease (name) VALUES ('#{name}')")
	    @id = DATA.last_insert_row_id
    	return self
  	end

  	# returns the name of a disease
  	# 
  	# id => database id of the disease
  	#
  	def Disease.nameOf(id)
  		record = Disease.find(id)
  		return record.name
  	end

end