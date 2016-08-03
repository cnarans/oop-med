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
		DOCTOR.answers[session['i']]=true
	elsif @answer=="no"
		DOCTOR.answers[session['i']]=false
	end
	redirect "/question"
end

MyApp.get "/question" do
	session['i']+=1
	@name = session['name']
	if @question = Symptom.getQuestion(session['i']+1)
		erb :"question"
	else
		verdict = DOCTOR.diagnose()
		@diagnosis = Disease.nameOf(verdict+1)
		session['diagnosis'] = @diagnosis
		erb :"results"
	end
end