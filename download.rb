require 'twitter'
require 'csv'
require 'time'

# Config a Twitter client
$client = Twitter::REST::Client.new do |config|
  config.consumer_key    = 'KaP6dQMgDQypv7fVvQ7Q'
  config.consumer_secret = 'Spy6Ei4BVttpSJjYMTubto79xV9Sfo1H1E843xpP8'
end

# Target tweets' id that we want to analysis retweets on
targets = [517101582534852608, 517101577631694848, 517101563438178305,
  517101561269723137, 517101546111533056, 517101437713932289]

targets.each do |id|
  # Get original tweets
  tweet = $client.status(id)

  # Get headers for CSV output
  headers = tweet.attrs.map {|k, v| k}

  # Combine original tweets with all the retweet tweet into one array
  # sort them based on created time
  arr = ([tweet] + $client.retweets(id, count: 100)).sort do |a, b|
    Time.parse(a.attrs[:created_at]) <=> Time.parse(b.attrs[:created_at])
  end

  # Create a new CSV file and write all records
  CSV.open("./retweets_of_#{id}_new.csv", 'w') do |csv|
    csv << headers # Output header of CSV
    arr.each do |tweet|
      csv << tweet.attrs
        .select {|key, val| headers.include? key} # Only output a value with its key in headers defined earlier
        .map {|key, val| val.class == Hash ? nil : val.to_s} # Ignore values with nested attributes, we don't need them for now
    end
  end
end
