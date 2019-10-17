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
		return {author=>content}
	end
	def index_gossip (array_gossip)
		array_gossip.each_with_index { |gossip,index| puts "#{index+1} Author : #{gossip.author}\nContent : #{gossip.content}"}
	end
	# gets an array of gossip, reject one then return the new array
	def reject_gossip (array_gossip)
		index_gossip(array_gossip)
		user_input = 0
		while (user_input < 1 || user_input > array_gossip.size) do
			puts "Enter the number of the gossip you want to erase"
			print "> "
			user_input = gets.to_i
		end
		array_gossip.reject.each_with_index{|k,i|i==user_input-1}
	end
end