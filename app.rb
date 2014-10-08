require 'twitter'
require 'multi_json'
require 'oj'
require 'csv'

Oj.default_options = {mode: :compat}
MultiJson.use Oj

$client = Twitter::REST::Client.new do |config|
  config.consumer_key    = 'KaP6dQMgDQypv7fVvQ7Q'
  config.consumer_secret = 'Spy6Ei4BVttpSJjYMTubto79xV9Sfo1H1E843xpP8'
end

targets = [517101582534852608, 517101577631694848, 517101563438178305,
  517101561269723137, 517101546111533056, 517101437713932289]

targets.each do |id|
  res = $client.retweets id, count: 100

  CSV.open("./retweets_of_#{id}.csv", 'w') do |csv|
    csv << res[0].to_h.map {|key, val| key.to_s}
    res.each do |tweet|
      csv << tweet.to_h.map {|key, val| val.class == Hash ? nil : val.to_s}
    end
  end
end

__END__
