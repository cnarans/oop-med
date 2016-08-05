class Symptom

	# sets the table var for MedORM functions
	@table = "symptom"

	extend MedORM

	attr_reader :id, :name, :question

	attr_writer :id, :name, :question

	# constructor
	#
	def initialize(id, name, question)
		@id = id
		@name = name
		@question = question
	end

	# returns the name of the given symptom
	#
	# id => database id of the symptom
	#
	def Symptom.nameOf(id)
		record = Symptom.find(id)
		if record.nil?
			return nil
		else
			return record.name
		end
	end

	# returns the question string for the given symptom
	#
	# id => database id of the symptom
	#
	def Symptom.getQuestion(id)
		record = Symptom.find(id)
		if record.nil?
			return nil
		else
			return record.question
		end
	end

	# save the current instance information to the database
	#
	def save
	    DATA.execute("INSERT INTO symptom (name, question) VALUES ('#{name}', '#{question}')")
	    @id = DATA.last_insert_row_id
    	return self
  	end

end