MyApp.get "/"  do
	DOCTOR.resetQuestions()
	session['i']=-1
	erb :"home"
end

MyApp.post "/question" do
	if !params[:name].nil?
		session['name'] = params[:name]
	end
	@answer = params[:answer]

	if @answer=="yes"
		DOCTOR.answerQuestion(true, session['i'])
	elsif @answer=="no"
		DOCTOR.answerQuestion(false, session['i'])
	end
	redirect "/question"
end

MyApp.get "/question" do
	session['i']+=1
	@name = session['name']
	if @question = DOCTOR.getQuestion(session['i'])
		erb :"question"
	else
		verdict = DOCTOR.diagnose()
		@diagnosis = DOCTOR.diseaseName(verdict)
		session['diagnosis'] = @diagnosis
		erb :"results"
	end
end