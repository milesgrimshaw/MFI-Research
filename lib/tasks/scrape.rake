require "json"
require "open-uri"
require "pp"
require "rake"

namespace :db do 
  desc "Scraping Kiva for loans, taking as input start and end indices of range"
  task :scrape, [:start, :stop] => :environment do |t, args|
    
    # Get the upper bound for loans
    page = JSON.parse(open("http://api.kivaws.org/v1/statistics/count.json").read)[0]
    count = page["count"]
    
    # Set as defaults
    args.with_defaults(:start => "1", :stop => count)
    
    pp "Range is from #{args.start.to_i} to #{args.stop.to_i}"
    start = args.start.to_i
    stop = args.stop.to_i
    if start <= stop
      for i in start..stop
        begin
          loan = JSON.parse(open("http://api.kivaws.org/v1/loans/#{i}.json").read)
          loan["loans"].each do |item|
            id = item["id"]
            name = item["name"]
            funded = item["funded_amount"]
            imgid = item["image"]["id"]
            if funded != 0 && name != "Anonymous"
              b = Borrower.new(:name => name, :kiva_id => id, :image => "http://www.kiva.org/img/500/#{imgid}.jpg")
              b.save
              pp "#{id}: Saved borrower #{name}..."
            end
          end
        rescue
          pp "#{i} Not Found!"
        end
      end
    else
      pp "Invalid inputs"
    end
  end
end