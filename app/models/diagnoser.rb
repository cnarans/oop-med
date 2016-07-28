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

end

