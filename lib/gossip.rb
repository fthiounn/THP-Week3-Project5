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
end