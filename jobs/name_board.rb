# buzzwords = ['Paradigm shift', 'Leverage', 'Pivoting', 'Turn-key', 'Streamlininess', 'Exit strategy', 'Synergy', 'Enterprise', 'Web 2.0']
# buzzword_counts = Hash.new({ value: 0 })
#
# SCHEDULER.every '2s' do
#   random_buzzword = buzzwords.sample
#   buzzword_counts[random_buzzword] = { label: random_buzzword, value: (buzzword_counts[random_buzzword][:value] + 1) % 30 }
#
#   send_event('buzzwords', { items: buzzword_counts.values })
# end

require 'rest-client'
require 'nokogiri'
SCHEDULER.every '1s' do

  #p curVal

    queryNeo = "start n=node(*) match (n{name:'Java'})<-[r]-(x) return x.name"
    #args = {'query': query}
    response = RestClient.post('127.0.0.1:7474/db/data/cypher',
      {
        :query => queryNeo
    })
    #print response
    rows=[]
    responseOut = JSON.parse(response.body)
    #send_event('buzzwords', { items: buzzword_counts.values })

end
