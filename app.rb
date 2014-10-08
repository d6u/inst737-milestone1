require 'twitter'
require 'multi_json'
require 'oj'

Oj.default_options = {mode: :compat}
MultiJson.use Oj

FILE_NAME = 'WWDC14.csv'

$client = Twitter::REST::Client.new do |config|
  config.consumer_key    = 'KTJsDCW16m4FmzODN66apbM3s'
  config.consumer_secret = 'Q0MYQEMRoRei7MtRf3CDAFeBy0nxKLIvzhVvHFjrB5YKHXi2UC'
end

def fetch_search()
  count = 0
  $client.search('#IceBucketChallenge until:2014-09-30', include_entities: true, result_type: 'recent').each do |tweet|
    puts tweet.created_at
    count += 1
  end
  puts '--> ', count
end

fetch_search()
