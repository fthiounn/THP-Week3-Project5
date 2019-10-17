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
	def index_gossip
		@view.index_gossip(Gossip.all)
	end
	def delete_gossip
		Gossip.modify_csv(@view.reject_gossip(Gossip.all))
	end

#Demander au model un array qui contient tous les potins que l'on a en base
#Demander à la view d’exécuter sa propre méthode index_gossips qui affichera tous les potins

end