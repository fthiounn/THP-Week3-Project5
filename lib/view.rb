#SPECIFICATIONS Class View

# ¿WHY?
# This is the controller in our MVC arch

#fonctions :
# => 
# => 
# => 

class View

	def initialize
	end

	def create_gossip
		puts "Enter Author of the Gossip"
		author = gets.chomp
		puts "Enter content of the gossip"
		content = gets.chomp
		return {content=>author}
	end
end