MyApp.post "/records" do
  session['name'] = params[:name]
  redirect "/records"
end

MyApp.get "/records" do
  @name = session['name']
  @recs=Diagnosis.getRecords(@name)
  erb :"records"
end

MyApp.get "/save" do
	@time = Time.now.strftime("%F %T")
	@name = session['name']
	@disease = session['diagnosis']
	@disease_id = DATA.execute("SELECT id FROM disease WHERE name = '#{@disease}'")[0][0]
  @diagnosis = Diagnosis.new(nil, @name, @time, @disease_id)
  @diagnosis.save
	#DATA.execute("INSERT INTO diagnosis (name, timestamp, disease_id) VALUES ('#{@name}','#{@time}', #{@disease_id})")
	erb :"save"
end

MyApp.post "/records/delete" do
  session['name'] = params[:name]
  redirect "/records/delete"
end

MyApp.get "/records/delete" do
  @name = session['name']
  Diagnosis.deleteRecords(@name)
  erb :"delete"
end