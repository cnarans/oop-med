require "httparty"
require "pry"

require_relative "secret.rb"

class Geo

	def Geo.getLocation(zipcode)
		info = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{zipcode}&key=#{API_KEY}")
		lat = info["results"][0]["geometry"]["location"]["lat"]
		lng = info["results"][0]["geometry"]["location"]["lng"]
		return lat.to_s+lng.to_s
	end

	def Geo.getLocation(street,city,state,zip)
		query = street.split(" ").join("+")
		query += "," + city + "," + state + "," + zip
		info = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{query}&key=#{API_KEY}")
		lat = info["results"][0]["geometry"]["location"]["lat"]
		lng = info["results"][0]["geometry"]["location"]["lng"]
		return lat.to_s+","+lng.to_s
	end

end

#street = ""
#city = ""
#state = ""
#zip = "68108"
#puts Geo.getLocation(street, city, state, zip)