
require 'twilio-ruby'
require 'sinatra'  #AIzaSyBJi0e7HcPXnom-skb5b_Sy7KVfrLEiYgY 

require 'net/http'
require 'json'
 


post '/sms' do
    incoming = params[:Body]
    incoming = incoming.gsub(/\s+/, "+")
    #"600+Amphitheatre+Parkway,+Mountain+View,+CA"

	p incoming
	url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{incoming}&key=AIzaSyBJi0e7HcPXnom-skb5b_Sy7KVfrLEiYgY"
	uri = URI(url)
	response = Net::HTTP.get(uri)
	response = JSON.parse(response)
	#response1 = response['results']['formatted_address']
	response1 = response.to_s
	lat = response1[response1.index('lat')..response1.index('lat')+16]
	lat = lat[6..15]
	long = response1[response1.index('lng')..response1.index('lng')+16]
	long = long[6..15]
	#response3 = lat+" "+long

	url1="http://api.parkwhiz.com/search/?lat=#{lat}&lng=#{long}&start=1474749188&end=1474759988&key=b8d464c0fcd86c5d3d83fc41ef98eb07"


	uri1=URI(url1)
	response2 = Net::HTTP.get(uri1)
	response2 = JSON.parse(response2)

	twiml = Twilio::TwiML::Response.new do |r|
		r.Message(response2)
		r.Body(lat)
		r.Body(long)
	end
	content_type 'text/xml'
	twiml.text
end
