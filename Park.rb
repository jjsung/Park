
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
	response1 = JSON.parse(response)
	response1 = response1["results"][0]
	
	
	twiml = Twilio::TwiML::Response.new do |r|
		r.Message(response1.to_s)
	end
	content_type 'text/xml'
	twiml.text
end
