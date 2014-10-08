require 'csv'
require 'time'

ONE_HOUR = 60 * 60

targets = [
  517101582534852608, 517101577631694848, 517101563438178305,
  517101561269723137, 517101546111533056, 517101437713932289]

targets.each do |id|
  table = CSV.table "retweets_of_#{id}_new.csv"

  summary = []
  time = Time.parse table[0][:created_at]
  current = {time: (time + ONE_HOUR / 2).to_s, count: 0}

  table.each_with_index do |row, i|
    next if i == 0

    t = Time.parse row[:created_at]

    if t - time <= ONE_HOUR
      current[:count] += 1
    else
      time += ONE_HOUR
      summary << current
      current = {time: time + ONE_HOUR / 2, count: 1}
    end

  end

  summary << current

  CSV.open("summary_of_#{id}.csv", 'w') do |csv|
    csv << summary[0].map {|key, val| key}
    csv << [Time.parse(table[0][:created_at])]
    summary.each do |row|
      csv << row.map {|key, val| val}
    end
  end
end
