class Symptom

	attr_reader :id, :name, :question

	attr_writer :id, :name, :question

	def initialize(id, name, question)
		@id = id
		@name = name
		@question = question
	end

	def Symptom.find(id)
		records = DATA.execute("SELECT * FROM symptom WHERE id = #{id}")
		record = records[0]

		Symptom.new(record["id"], record["name"], record["question"])
	end

	def save
	    DATA.execute("INSERT INTO symptom (name, question) VALUES ('#{name}', '#{question}')")
	    @id = DATA.last_insert_row_id
    	return self
  	end

end