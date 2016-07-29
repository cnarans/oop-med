class Diagnoser

	@symptoms
	@diseases
	@relationships
	@answers

	# Constructor
	#
	def initialize
		@symptoms = DATA.execute("SELECT * FROM symptom")
		@diseases = DATA.execute("SELECT * FROM disease")
		@relationships = DATA.execute("SELECT * FROM relationship")
		@answers = []
		for i in 0..@symptoms.count-1
			@answers.push(nil)
		end
	end

	# Resets @answers entries to nil
	#
	def resetQuestions()
		for i in 0..@answers.count-1
			@answers[i]=nil
		end
	end

	# Set @answer entry to true or false
	#
	# response -> true or false answer to medical question
	# number -> index of the question/answer
	#
	def answerQuestion(response, number)
		@answers[number]=response
	end

	# Returns the text of a specific question
	#
	# number -> index of the question
	#
	def getQuestion(number)
		if number>@symptoms.count-1
			return nil
		else
			return @symptoms[number]["question"]
		end
	end

	# Returns the name of a specific symptom
	#
	# number -> index of the symptom
	#
	def getSymptom(number)
		return @symptoms[number]["name"]
	end

	# Returns true if the given symptom is related to the given disease
	#
	# disease -> index of disease
	# symptom -> index of symptom
	#
	def isSymptom(disease, symptom)
		opinion = DATA.execute("SELECT * FROM relationship WHERE disease_id=#{disease} AND symptom_id=#{symptom}")
		if opinion.empty?
			return false
		else
			return true
		end
	end

	# Calculates what percentage of a diseases symptoms are true
	#
	# disease -> index of the disease
	# sympnum -> number of disease symptoms the patient has
	#
	def likelihood(disease, sympnum)
		total = DATA.execute("SELECT * FROM relationship WHERE disease_id=#{disease}")
		total = total.count.to_f
		sympnum = sympnum.to_f
		return sympnum/total
	end

	# Returns the name of a disease
	#
	# id -> id of the disease
	#
	def diseaseName(id)
		return @diseases[id]["name"]
	end

	# diagnose counts up the number of the patient's symptoms for each disease.  The index of the  
	# disease with the highest ratio of patient symptoms to its total symptoms is returned.
	#
	def diagnose()
		if !@answers.index(nil).nil?
			return nil
		else
			chances = []
			for i in 0..@diseases.count-1
				chances.push(0)
				for j in 1..@answers.count
					if (isSymptom(i+1,j)&&(@answers[j-1]))
						chances[i]+=1
					end
				end
				chances[i]=likelihood(i+1,chances[i])
			end
			return chances.index(chances.max)
		end

	end

end

