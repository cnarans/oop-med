MyApp.post "/records" do
  session['name'] = params[:name]
  redirect "/records"
end

MyApp.get "/records" do
  @name = session['name']
  @all = DATA.execute("SELECT * FROM diagnosis where name = '#{@name}'")
  @recs=[]
  for i in 0..@all.count-1
  	@recs[i] = Record.new(@all[i])
  end
  erb :"records"
end

MyApp.get "/save" do
	@time = Time.now.strftime("%F %T")
	@name = session['name']
	@disease = session['diagnosis']
	@disease_id = DATA.execute("SELECT id FROM disease WHERE name = '#{@disease}'")[0][0]
	DATA.execute("INSERT INTO diagnosis (name, timestamp, disease_id) VALUES ('#{@name}','#{@time}', #{@disease_id})")
	erb :"save"
end

MyApp.post "/records/delete" do
  session['name'] = params[:name]
  redirect "/records/delete"
end

MyApp.get "/records/delete" do
  @name = session['name']
  DATA.execute("DELETE FROM diagnosis where name = '#{@name}'")
  erb :"delete"
end