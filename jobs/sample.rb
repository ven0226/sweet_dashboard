require 'rest_client'
current_valuation = 0
current_karma = 0
#$loopCount = 10
$resp_text = ''
SCHEDULER.every '2s' do
  #url = 'http://www.acme.com/products/3322' # ACME boomerang
  #resp = Net::HTTP.get_response(URI.parse(url))
  #$resp_text = resp.body
  #response = RestClient.get 'http://localhost:3000/dashboard'
  #response.code
  response = RestClient.get('http://localhost:3000/dashboard'){ |response, request, result, &block|
  case response.code
  when 200
    #p "It worked !"
    response
  when 423
    raise SomeCustomExceptionIfYouWant
  else
    response.return!(request, result, &block)
  end
  }
  i = 0
  responseOut = JSON.parse(response.body)
  #@loopCount = responseOut['dashboard']['total'].to_i
  @interest = responseOut['dashboard']['interest']

  @interest.each do |json|
    send_event('valuation' + i, { current: json[value].to_i})
    i = i + 1
  end
  #last_valuation = current_valuation
  #last_karma     = current_karma
  #current_valuation = rand(10)
  #current_karma     = rand(200000)
  #send_event('valuation0', { current: current_valuation, last: last_valuation })
  #send_event('valuation1', { current: current_valuation, last: last_valuation })
  #send_event('karma', { current: current_karma, last: last_karma })
  #send_event('synergy',   { value: rand(100) })
end
