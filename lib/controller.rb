#SPECIFICATIONS Class Controller

# ¿WHY?
# This is the controller in our MVC arch

#fonctions :
# => 
# => 
# => 


class Controller
	def initialize
		@view = View.new
	end
	def create_gossip
		params = @view.create_gossip
		gossip = Gossip.new(params.keys[0], params.values[0])
		#pour le moment, le contenu de ce gossip est inscrit "en dur" dans le code. L'utilisateur ne peut pas le changer.
		gossip.save_to_csv
	end
end