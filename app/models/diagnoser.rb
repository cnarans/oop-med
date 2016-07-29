class Diagnoser

	@symptoms
	@diseases
	@relationships
	@answers

	def initialize
		@symptoms = DATA.execute("SELECT * FROM symptom")
		@diseases = DATA.execute("SELECT * FROM disease")
		@relationships = DATA.execute("SELECT * FROM relationship")
		@answers = []
		for i in 0..@symptoms.count-1
			@answers.push(nil)
		end
	end

	def resetQuestions()
		for i in 0..@answers.count-1
			@answers[i]=nil
		end
	end

	def answerQuestion(response, number)
		@answers[number]=response
	end

	def getQuestion(number)
		if number>@symptoms.count-1
			return nil
		else
			return @symptoms[number]["question"]
		end
	end

	def getSymptom(number)
		return @symptoms[number]["name"]
	end

	def isSymptom(disease, symptom)
		opinion = DATA.execute("SELECT * FROM relationship WHERE disease_id=#{disease} AND symptom_id=#{symptom}")
		if opinion.empty?
			return false
		else
			return true
		end
	end

	def likelihood(disease, sympnum)
		total = DATA.execute("SELECT * FROM relationship WHERE disease_id=#{disease}")
		total = total.count.to_f
		sympnum = sympnum.to_f
		return sympnum/total
	end

	def diseaseName(id)
		return @diseases[id]["name"]
	end

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

