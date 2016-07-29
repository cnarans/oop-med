MyApp.post "/places" do
	@street = params[:street]
  @city = params[:city]
  @state = params[:state]
  @zip = params[:zip]
  @location = Geo.getLocation(@street,@city,@state,@zip)
	@location = @location.split(",")
	@places = Places.get_clinics(@location[0],@location[1])[0,5]
  erb :"places/list"
end

