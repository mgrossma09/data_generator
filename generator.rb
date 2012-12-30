#!/Users/mgrossmann/.rvm/rubies/ruby-1.9.3-p194/bin/ruby

class List
	attr_reader :elements

	def initialize(list_file)
		@elements = []
		file = File.new(list_file, 'r')
		while (line = file.gets)
			@elements << line.chomp!
		end
		file.close
	end
end

# load the different lists into memory
lists = []
last_name_list = List.new('last_names.data')
female_list = List.new('female_first_names.data')
male_list = List.new('male_first_names.data')
us_cities_states_list = List.new('us_cities_states.data')
major_areas_of_study_list = List.new('major_areas_of_study.data')

class RandomName
	attr_reader :first_name, :last_name, :prefix, :suffix

	def initialize(last_name_list, female_first, male_first)
		suffixes = ['Jr.', 'Sr.', 'I', 'II', 'III', '', '', '', '']

		if rand(2) == 1
			@prefix = rand(2) == 1 ? 'Ms' : 'Mrs'
			first_name = female_first.elements[rand(female_first.elements.count)].capitalize.chomp
		else
			@prefix = 'Mr'
			first_name = male_first.elements[rand(male_first.elements.count)].capitalize.chomp
			@suffix = suffixes[rand(suffixes.count)]
		end

		@first_name = first_name
		@last_name = last_name_list.elements[rand(last_name_list.elements.count)].capitalize.chomp
	end
end

class RandomStreet
	attr_reader :street_address

	def initialize(last_name_list)
		suffixes = ['St', 'Blvd', 'Pl', 'Cmn', 'Ave']

		@street_address = rand(10000).to_s + ' ' + last_name_list.elements[rand(last_name_list.elements.count)].capitalize.chomp + ' ' + suffixes[rand(suffixes.count)]
	end
end

class RandomCity
	attr_reader :city, :state, :zip

	def initialize(us_cities_states_list)
		(@city, @state) = us_cities_states_list.elements[rand(us_cities_states_list.elements.count)].split(',')
		@zip = rand(100000).to_s.rjust(5, '0')
	end
end

class RandomPhone
		attr_reader :phone_number

		def initialize()
			@area_code = rand(999).to_s.rjust(3, '0')
			@phone_part1 = rand(999).to_s.rjust(3, '0')
			@phone_part2 = rand(9999).to_s.rjust(4, '0')

			@phone_number = "(#{@area_code}) #{@phone_part1} #{@phone_part2}"
		end
end

class RandomMajor
		attr_reader :major

		def initialize(major_areas_of_study_list)
			@major = major_areas_of_study_list.elements[rand(major_areas_of_study_list.elements.count)].split.map { |x| x.capitalize }.join(' ').chomp
		end
end

class RandomBool
		attr_reader :one_or_two

		def initialize(string1, string2)
			@one_or_two = rand(2) == 1 ? string1 : string2
		end
end

class RandomRecord
	attr_reader :data

	def initialize(last_name_list, female_list, male_list, us_cities_states_list, major_areas_of_study_list)
		@data = {}
		person = RandomName.new(last_name_list, female_list, male_list)
		street = RandomStreet.new(last_name_list)
		city = RandomCity.new(us_cities_states_list)
		phone = RandomPhone.new()
		major = RandomMajor.new(major_areas_of_study_list)

		@data['prefix'] = person.prefix
		@data['first_name'] = person.first_name
		@data['last_name'] = person.last_name
		@data['suffix'] = person.suffix
		@data['street_address'] = street.street_address
		@data['city'] = city.city
		@data['zip'] = city.zip
		@data['state'] = city.state
		@data['phone'] = phone.phone_number
		@data['major'] = major.major
	end
end

def PrintUsage()
	puts
	puts "Usage: #{$0} [--help|-h] [--separator|-s=<separator>] field_string count"
	puts
	puts "      field_string consists of comma-separated values of:"
	puts "            counter=START"
	puts "            randint=RANGE=PLUS"
	puts "            randfloat=RANGE=PRECISION"
	puts "            bool=STRING1=STRING2"
	puts "            prefix"
	puts "            first_name"
	puts "            last_name"
	puts "            suffix"
	puts "            street_address"
	puts "            city"
	puts "            zip"
	puts "            state"
	puts "            phone"
	puts "            major"
	puts
	puts "      --separator ....... separator for output fields, default = ,"
	puts
	puts "Example: #{$0} first_name,city,major 10"
	puts
	exit
end

separator = ','

if ARGV.count > 0
	if ARGV[0] == '-h' or ARGV[0] == '--help' 
			PrintUsage()
		elsif ARGV[0] =~ /-s=/ or ARGV[0] =~ /--separator=/
			separator = ARGV[0].split('=')[1]
			ARGV.shift
		end

		fields = ARGV[0].split(',')

		counter = fields.grep /^counter=/
		if counter.count > 0
			counter = counter[0].split('=')[1].to_i
		else
			counter = 0
		end

	ARGV[1].to_i.times do
		person = RandomRecord.new(last_name_list, female_list, male_list, us_cities_states_list, major_areas_of_study_list)
		output_fields = []

		fields.each do |field|
			params = field.split('=')

			if field =~ /^counter=/
				output_fields << counter
				next
			end

			if field =~ /^randint=/
				output_fields << rand(params[1].to_i) + params[2].to_i
				next
			end

			if field =~ /^randfloat=/
				output_fields << (rand()*(params[1].to_i)).round(params[2].to_i)
				next
			end

			if field =~ /^bool=/
				temp_random = RandomBool.new(params[1], params[2])
				output_fields << temp_random.one_or_two
				next
			end

			output_fields << person.data[field]
		end
		puts output_fields.join(separator)
		counter += 1
	end
else 
	PrintUsage()
end
