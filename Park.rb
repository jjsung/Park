
require 'twilio-ruby'
require 'sinatra'

post '/sms' do
    incoming = params[:Body]
	p incoming.reverse
	
	twiml = Twilio::TwiML::Response.new do |r|
		r.Message(incoming)
	end
	content_type 'text/xml'
	twiml.text
end
