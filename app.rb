require 'twitter'
require 'multi_json'
require 'oj'

Oj.default_options = {mode: :compat}
MultiJson.use Oj

$client = Twitter::REST::Client.new do |config|
  config.consumer_key    = 'KTJsDCW16m4FmzODN66apbM3s'
  config.consumer_secret = 'Q0MYQEMRoRei7MtRf3CDAFeBy0nxKLIvzhVvHFjrB5YKHXi2UC'
end

tweet = Twitter::Tweet.new({id: 517181915472740352})

arr = $client.retweets tweet, "count" => 200

puts arr[arr.size - 1].attrs[:id] - 1 # max_id
