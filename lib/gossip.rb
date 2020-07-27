require 'pry'
require 'csv'

class Gossip
	
	attr_accessor :author, :content

	def initialize(author, content)
		@content = content
		@author = author
	end

	def save
		
		CSV.open("db/gossip.csv", "a+") do |csv|
			csv << [@author, @content]
		end
		puts "fait"
	end

	def edit(id)
		csv_file = CSV.read("db/gossip.csv")

		csv_file.each_with_index { |line, i| csv_file[i] = [@author, @content] if i == id.to_i }

		CSV.open("db/gossip.csv", "wb") do |csv_line|
			csv_file.each { |new_line| csv_line << new_line }
		end
		puts "edition faite"
	end

	def self.all
		all_gossips = []

		csv = CSV.read("db/gossip.csv")
		csv.each_with_index do |line, i|
			all_gossips << Gossip.new(line[0], line[1])
		end

		return all_gossips
	end

	def self.find(id)

		this_gossip = []

		CSV.read("db/gossip.csv").select.with_index { |line, i| this_gossip << Gossip.new(line[0], line[1]) if i == id.to_i }
		
		return this_gossip
	end

end