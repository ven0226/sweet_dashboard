require 'net/http'
current_valuation = 0
current_karma = 0
$loopCount = 10

SCHEDULER.every '2s' do
  url = 'http://www.acme.com/products/3322' # ACME boomerang
  resp = Net::HTTP.get_response(URI.parse(url))
  resp_text = resp.body
  last_valuation = current_valuation
  last_karma     = current_karma
  current_valuation = rand(10)
  current_karma     = rand(200000)
  send_event('valuation0', { current: current_valuation, last: last_valuation })
  send_event('valuation1', { current: current_valuation, last: last_valuation })
  send_event('karma', { current: current_karma, last: last_karma })
  send_event('synergy',   { value: rand(100) })
end
