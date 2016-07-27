MyApp.get "/"  do
	erb :"home"
end

MyApp.post "/question" do
	erb :"question"
end