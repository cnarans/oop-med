require 'json'

MyApp.get "/api/diseases" do
  content_type :json
  DATA.execute("SELECT * FROM diseases")
end

MyApp.get "/api/diseases/:id" do
  content_type :json
  DATA.execute("SELECT * FROM diseases WHERE id = #{id}")
end 

MyApp.get "/api/patient/:name" do
  content_type :json
  name = params[:name]
  info = DATA.execute("SELECT * FROM diagnosis WHERE name = '#{name}'")
  info.to_json
end