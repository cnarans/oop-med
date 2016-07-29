class Record

	@name
	@time
	@disease
	@symptoms

	# Constructor
	#
	# entry -> diagnosis entry from SQL database
	#
	def initialize(entry)
		@name = entry["name"]
		@time = entry["timestamp"]
		@disease = getDisease(entry["disease_id"])
		@symptoms = getSymptoms(entry["disease_id"])
	end

	# Returns database information for given name
	#
	# name -> string containing the name of the records to be returns
	#
	def Record.apiReturn(name)
		recs = DATA.execute("SELECT * FROM diagnosis WHERE name = '#{name}'")
		return recs
	end

	# Retrieves the disease name for the given database id
	#
	# id -> the disease's SQL database id
	#
	def getDisease(id)
		dis = DATA.execute("SELECT name FROM disease WHERE id = #{id}")[0]["name"]
		return dis
	end

	# Retries the names of the symptoms for a given disease
	#
	# id -> the disease's SQL database id
	#
	def getSymptoms(id)
		symptom_ids = DATA.execute("SELECT symptom_id FROM relationship WHERE disease_id = #{id}")
		symptoms = []
		for i in 0..symptom_ids.length-1
			symptoms.push(DATA.execute("SELECT name FROM symptom WHERE id = #{symptom_ids[i][0]}")[0][0])
		end
		return symptoms
	end

	# Returns the name on the record
	#
	def name()
		return @name
	end

	# Returns the record's timestamp
	#
	def time()
		return @time
	end

	# Returns symptom information
	#
	def symptoms()
		return @symptoms
	end

	# Returns disease information
	#
	def disease()
		return @disease
	end

end