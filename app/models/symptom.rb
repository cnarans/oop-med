class Symptom

	@table = "symptom"

	extend MedORM

	attr_reader :id, :name, :question

	attr_writer :id, :name, :question

	def initialize(id, name, question)
		@id = id
		@name = name
		@question = question
	end

	def Symptom.nameOf(id)
		record = Symptom.find(id)
		if record.nil?
			return nil
		else
			return record.name
		end
	end

	def Symptom.getQuestion(id)
		record = Symptom.find(id)
		if record.nil?
			return nil
		else
			return record.question
		end
	end

	def save
	    DATA.execute("INSERT INTO symptom (name, question) VALUES ('#{name}', '#{question}')")
	    @id = DATA.last_insert_row_id
    	return self
  	end

end