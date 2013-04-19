# Miles Grimshaw
# Scraper for Kiva Loans
# April 18th, 2013

require "json"
require "pp"
require "open-uri"
require "csv"

# write to CSV
CSV.open("loans.csv", "wb") do |csv|

	# set up headers for the csv
	csv << [
		"name", 
		"status", 
		"funded amount", 
		"loand amount", 
		"paid amount", 
		"activity", 
		"sector", 
		"country", 
		"gender", 
		"imgid"]
	
	# get the current number of kiva loans over all time
	page = JSON.parse(open("http://api.kivaws.org/v1/statistics/count.json").read)[0]
	count = page["count"]
	
	loans = Array.new

	# loop through and get every 50th loan

	for i in (84..count.to_i).step(50)


		begin
			loan = JSON.parse(open("http://api.kivaws.org/v1/loans/#{i}.json").read)
			loan["loans"].each do |item|

				# Get the parameters of the loan
				name = item["name"]				
				stat = item["status"]
				funded = item["funded_amount"]
				loan = item["loan_amount"]
				paid = item["paid_amount"]
				activity = item["activity"]
				sector = item["sector"]
				country = item["location"]["country"]
				gender = item["borrowers"][0]["gender"]				
				imgid = item["image"]["id"]

				if funded != 0 && name != "Anonymous"
					csv << [name, stat, funded, loan, paid, activity, sector, country, gender, "http://www.kiva.org/img/500/#{imgid}.jpg"]
				end
				#pp "#{name} was funded #{funded}, paid #{paid}, and has status #{stat}"
			end
		rescue
			pp "#{i} not found!"
		end
	end
end