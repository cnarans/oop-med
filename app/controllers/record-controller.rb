MyApp.post "/records" do
  session['name'] = params[:name]
  redirect "/records"
end

MyApp.get "/records" do
  @name = session['name']
  @recs = Record.returnAll(@name)
  erb :"records"
end