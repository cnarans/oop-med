require 'json'

MyApp.get "/api/diseases" do
  content_type :json
  Record.listDiseases.to_json
end

MyApp.get "/api/diseases/:id" do
  content_type :json
  Record.listSymptoms(params[:id].to_i).to_json
end 

MyApp.get "/api/patient/:name" do
  content_type :json
  name = params[:name]
  info = Record.apiReturn(name)
  info.to_json
end