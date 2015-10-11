require 'rest-client'
require 'nokogiri'

SCHEDULER.every '10s' do
  queryNeo = "start n=node(*) match (n{type:'skill'})-[r]-() return n, count(r) as rel_count order by rel_count desc"
  #args = {'query': query}
  response = RestClient.post('http://127.0.0.1:7474/db/data/cypher',
    {
      :query => queryNeo
  })

  rows=[]
  responseOut = JSON.parse(response.body)
  responseOut['data'].each do |resp|
    key = resp[0]['data']['name']
    value =  resp[1]
    rows << key
    send_event(key, { current: value.to_i})
  end
  set :number_rows, rows
  #print responseOut
end
