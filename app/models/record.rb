class Record

	@name
	@time
	@disease
	@symptoms

	# default constructor
	#
	def initialize(entry)
		@name = entry["name"]
		@time = entry["timestamp"]
		@disease = getDisease(entry["disease_id"])
		@symptoms = getSymptoms(entry["disease_id"])
	end

	def getDisease(id)
		dis = DATA.execute("SELECT name FROM disease WHERE id = #{id}")[0]["name"]
		return dis
	end

	def getSymptoms(id)
		symptom_ids = DATA.execute("SELECT symptom_id FROM relationship WHERE disease_id = #{id}")
		symptoms = []
		for i in 0..symptom_ids.length-1
			symptoms.push(DATA.execute("SELECT name FROM symptom WHERE id = #{symptom_ids[i][0]}")[0][0])
		end
		return symptoms
	end


	def name()
		return @name
	end

	def time()
		return @time
	end

	def symptoms()
		return @symptoms
	end

	def disease()
		return @disease
	end

end