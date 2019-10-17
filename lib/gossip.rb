#SPECIFICATIONS Class Gossip

# ¿WHY?
# This is the Model in our MVC

#fonctions :
# => save to cvs
# => 
# => 

class Gossip
	attr_accessor :content, :author
	def initialize(author, content)
	  @content = content
	  @author = author
	end
	def save_to_csv
		File.open('db/gossip.csv','a') do |file|
			file.puts author + "," +content
		end
	end
	def self.all
		gossip_array = []
		iterator_lines = 0
		File.open('db/gossip.csv','r').each_line do |line|
			data = line.split(/\t/)
			gossip_array[iterator_lines]= Gossip.new(data[0].split(",").at(0),data[0].split(",").at(1))
			iterator_lines+=1
		end
		return gossip_array
	end
	#new content is an array of gossip
	def self.modify_csv(new_content)
		File.open('db/gossip.csv','w') do |file|
			new_content.each {|gossip| file.puts gossip.author + "," + gossip.content}
		end
	end
end