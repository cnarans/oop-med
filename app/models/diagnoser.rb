class Diagnoser

	@symptoms
	@diseases
	@relationships
	@answers

	attr_reader :symptoms, :diseases, :relationships, :answers
	attr_writer :symptoms, :diseases, :relationships, :answers

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

	# Calculates what percentage of a diseases symptoms are true
	#
	# disease -> index of the disease
	# sympnum -> number of disease symptoms the patient has
	#
	def likelihood(disease, sympnum)
		total = Relationship.allDisease(disease)
		total = total.count.to_f
		sympnum = sympnum.to_f
		return sympnum/total
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
					if (Relationship.isSymptom(i+1,j)&&(@answers[j-1]))
						chances[i]+=1
					end
				end
				chances[i]=likelihood(i+1,chances[i])
			end
			return chances.index(chances.max)
		end

	end

end

