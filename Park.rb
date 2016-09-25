
require 'twilio-ruby'
require 'sinatra'  #AIzaSyBJi0e7HcPXnom-skb5b_Sy7KVfrLEiYgY   https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=parking&name=cruise&key=AIzaSyBJi0e7HcPXnom-skb5b_Sy7KVfrLEiYgY

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
	lat = lat[6..14]
	lng = response1[response1.index('lng')..response1.index('lng')+16]
	lng = lng[6..14]
	#response3 = lat+" "+long

	url= "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+lat.to_s+","+lng.to_s"+&radius=500&type=parking&key=AIzaSyBJi0e7HcPXnom-skb5b_Sy7KVfrLEiYgY"
	uri = URI(url)
	response2 = Net::HTTP.get(uri)
	response2 = JSON.parse(response2\)
	response2 = response2.to_s

	twiml = Twilio::TwiML::Response.new do |r|
		r.Message(response2)
		
	end
	content_type 'text/xml'
	twiml.text
end
