MyApp.get "/"  do
	DOCTOR.resetQuestions()
	session['i']=-1
	erb :"home"
end

MyApp.post "/question" do
	session['name'] = params[:name]
	redirect "/question"
end

MyApp.get "/question" do
	session['i']+=1
	@name = session['name']
	if @question = DOCTOR.getQuestion(session['i'])
		erb :"question"
	else
		@diagnosis = "TEST"
		erb :"results"
	end
end