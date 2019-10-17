THP - Week 3 Project 5
Francois Thiounn

Projet : The Gossip Project - The MVC version

How to use me ?


  
Description du projet par THP :

1. Introduction
La théorie, c'est bien. La pratique, c'est mieux. Nous allons donc te proposer de mieux appréhender l'architecture du MVC en faisant une application Ruby. Cette application utilisera bien entendu le modèle du MVC, afin d'avoir du code propre, bien rangé, et bien ordonné. Le projet sera assez pas à pas car il n'est jamais aisé de produire son premier MVC.

Voici l'application : The Hacking Project est une superbe formation, avec une communauté soudée. Qui dit communauté soudée, dit potins à tout-va. Nous allons donc créer une application qui s'appelle The Gossip Project, où l'utilisateur pourra rentrer les ragots et rumeur, afficher une liste des potins, puis supprimer ceux qui ne sont plus d'actualité.

Les vues seront affichées dans le terminal, les potins enregistrés en CSV, et le programme tournera jusqu'à ce que l'utilisateur le quitte.

Pour cet exercice, j'ai fait le choix de CSV, mais tu peux remplacer CSV par JSON si tu es plus à l'aise. Il faudra juste garder la même arborescence et la même logique. Maintenant que c’est dit, nous pouvons commencer.

2. Le projet
2.1. Décomposer le programme
Avant de partir dans du code sans réfléchir, nous allons penser et conceptualiser le programme. Il y aura 4 grandes parties, chacune correspondant à une classe (donc un fichier) :

Le routeur
Le controller
La view
La base de donnée (model)
Pour le moment, ne code rien. On va juste passer en revue chaque fichier pour bien te rappeler ce qu'ils vont chacun faire.

Le routeur
Le travail du routeur sera simple : c'est de demander ce que l'utilisateur veut faire et de lancer la bonne méthode dans la bonne classe, en fonction.
Il y aura 3 choix : créer un gossip, voir la liste complète des gossips ou supprimer un gossip. Chaque action correspond à une méthode du controller.

Le controller
Le controller servira de relai entre la view et le model. Il aura 3 méthodes : une qui gère la création d'un potin, une qui gère l'affichage de la liste des potins, et une qui permet de détruire un potin. Une fois l'action effectuée (via le model), la méthode devra renvoyer vers la view.

La view
La view s'occupera d'afficher les bonnes informations à l'utilisateur. Comme on n'a pas encore vu les systèmes de fichiers HTML (on voit ça très bientôt 😉), on va coder ça sur le terminal avec des bons vieux puts en l'affichage et gets.chomp pour obtenir les ordres de l'utilisateur.

Le model et la base de données
Un potin sans son contenu, eh bien c'est comme un hamburger sans pain. Vazy cé nul. Nous allons donc faire en sorte qu'un potin ait 2 attributs :

son content qui est un string
un author qui est aussi un string
C'est tout. On aurait pu ajouter d'autres choses (la date du potin par exemple), mais pour ce premier MVC on va faire simple.

Au final, le model sera une classe Gossip qui ira piocher dans la base de données (le CSV) et sortira des instances de type Gossip. Elles auront, tu l'as compris, 2 variables d'instance : un content et un author.

Architecture du programme
Ok, en sachant tout ceci, notre arborescence du programme va ressembler, à la fin, à ça :

.
├── lib
│    ├── controller.rb
│    ├── gossip.rb
│    ├── router.rb
│    └── view.rb
├── db
│   └── gossip.csv
├── app.rb
├── Gemfile
└── Gemfile.lock
Jusqu'ici, rien de bien nouveau. Mais ça fait du bien de se rafraîchir la mémoire !
Et maintenant, pour coder tout ça, commençons par le commencement, la première fonctionnalité : l'ajout de potins.

2.2. Ajouter un potin
Poser les bases d'un programme, sa structure, c'est toujours le gros morceau. Pour t'éviter le syndrome de la page blanche, nous allons te guider dans ta quête du potin parfait.

2.2.1. Mettre en place son environnement de travail
Avant toute chose, tu vas créer un dossier the_hacking_gossip_ruby_version_POO puis te placer dedans. Tu vas ensuite créer le Gemfile, mettre la bonne version de Ruby, la gem CSV, puis tes gems préférées (PRY pourra t'aider par exemple), et faire l'installation via Bundler.

Puis nous allons faire le fichier app.rb, porte d'entrée de notre application. Étant donné que tout passe par le router, il faut juste que son code fasse appelle à la classe Router via un Router.new.perform et puis c'est tout 👈

Par contre, une fois écrit, si tu lances ton programme, ce dernier devrait t'envoyer bouler puisque tu n'as pas encore créé ta classe Router. C'est la prochaine étape.

Ton arborescence doit, pour le moment, ressembler à ceci :

.
├── app.rb
├── Gemfile
└── Gemfile.lock
2.2.2. Le router
Le boulot du router est proche de celui d'un serveur : il propose les possibilités à notre utilisateur, et en fonction de ce que celui-ci rentre, il redirige vers la bonne méthode du controller. ✌

Crée un dossier \lib dans lequel tu vas ajouter un fichier router.rb qui doit héberger une classe Router. Maintenant on va te détailler ce que tu dois mettre dans cette classe.

Dès le début, le router va créer une instance de la classe Controller qu'on appellera @controller. C'est un peu déroutant mais c'est via cette instance qu'il va déclencher la méthode adéquate : celle qui permet d'ajouter un potin, de le supprimer ou de les lister tous.

🤓 QUESTION RÉCURRENTE
Une instance @controller ? Mais pourquoi ?

Dans ce cas précis, l'instance @controller ne te parle pas trop en termes d'objet, car on ne peut pas la rattacher à un objet concret de la vie (comme un gossip, un user ou une voiture).

Dis-toi juste que c'est une manière pour le routeur d'exécuter une méthode située dans une autre classe : en faisant @controller.create_gossip, le routeur passe la main à la classe Controller en exécutant sa méthode create_gossip.

Première étape donc : appeler la classe Controller avec require, et l'instancier (= créer une instance) dans l'initialize de la classe Router. C'est beaucoup de termes techniques, mais cela permet de bien te familiariser avec le vocabulaire de la POO. D'une pierre deux coups ⚡

Ensuite, on va créer une méthode perform, qui va contenir une boucle infinie (boucle while true)qui va demander ce que l'utilisateur veut faire en lui proposant 2 choix (utilise ici un case - when, va voir sur Google comment ça marche si besoin). Les 2 choix seront 1) créer un gossip et 4) quitter l'app

Essaye, en utilisant l'énoncé ci-dessus, de poser les bases de la classe Router. Ensuite, compare ce que tu as fait avec cette petite correction ci-dessous (on a conscience que c'est pas simple. On va pas te larguer direct !). Bien évidemment, regarde bien le code que je te propose et les commentaires que j'ai rajouté rien que pour tes yeux 👀
require 'controller'

class Router

#On veut qu'un "Router.new" lancé par app.rb, crée automatique une instance "@controller"
  def initialize
    @controller =  Controller.new
  end 

#rappelle-toi que l'on fait "Router.new.perform" dans app.rb => après initialize, on définit donc perform.
  def perform 
    puts "BIENVENUE DANS THE GOSSIP PROJECT"

    while true

      #on affiche le menu
      puts "Tu veux faire quoi jeune mouss' ?"
      puts "1. Je veux créer un gossip"
      puts "4. Je veux quitter l'app"
      params = gets.chomp.to_i #on attend le choix de l'utilisateur

      case params #en fonction du choix
      when 1
        puts "Tu as choisi de créer un gossip" 
        @controller.create_gossip

      when 4
        puts "À bientôt !"
        break #Ce "break" permet de sortir de la boucle while. C'est même la seule façon d'en sortir.

      else
        puts "Ce choix n'existe pas, merci de ressayer" #Si l'utilisateur saisit une entrée non prévue, il retourne au début du "while true". 
        #C'est pour ça que la boucle est infinie: potentiellement, il peut se gourer jusqu'à la fin des temps :)

      end
    end
  end
end
Un menu qui demande ce que l’utilisateur veut faire, un bon vieux case - when, et les bon appels de méthodes. C'est aussi simple que cela. Maintenant si tu lances le programme, ce dernier va râler, car le controller n'existe pas. C'est bon signe puisque cela veut dire qu'il arrive à lire le router, donc ne nous arrêtons pas en si bon chemin. On va créer le controller, et commencer à avoir un début de programme. En avant !

À ce moment-là, ton architecture de code devrait ressembler à ceci :

.
├── app.rb
├── Gemfile
├── Gemfile.lock
└── lib
    └── router.rb
2.2.3. Le controller
Ce fameux chef d'orchestre : le controller est avant tout une suite de méthodes qui sont appelées par le routeur. Chaque méthode va contenir des appels au model Gossip et se finira avec un retour vers une view qui affiche quelquechose.

On en profite pour te faire remarquer une chose : on a le fichier gossip.rb qui va héberger la classe Gossip et non pas un model.rb avec une classe Model. En effet, contrairement à la view, le routeur et le controller, un model est lié à des objets concrets : des potins ou Gossip. Donc autant leur donner directement ce nom là comme ça, pour créer un nouveau potin, on fera Gossip.new. Ce qui revient à créer une instance de la classe Gossip.

Voici ce que l'on veut que tu fasses concernant le controller :

Crée un fichier controller.rb dans le dossier lib.
Mets les bases de la classe Controller dedans.
Étant donné que le controller joue avec le model et la view, tu vas devoir les require au début du programme.
Tu vas créer la méthode create_gossip. Cette méthode va donc créer un nouvel objet gossip, donc instancer la classe Gossip (le model) avec Gossip.new.
C'est tout pour le moment. On verra comment pointer vers la view plus tard 😉
Idem, si tu testes ton programme, il devrait t'envoyer bouler comme d'hab, en disant que la classe Gossip n'existe pas. C'est parti, créé ton fichier gossip.rb et nous allons créer en base les potins.

2.2.4. Le model
La classe Gossip, qui constituera le model, va permettre de créer plein d'instances qui seront autant de potins, de gossip : enfin on revient à un exemple de classe qui héberge des objets concrets ! Mais le model aura aussi pour rôle d’interagir avec la base de données. Par exemple, pour la création, nous allons faire une méthode save qui ira écrire dans un fichier CSV notre instance de Gossip (notre potin quoi). Cela peut faire peur, mais c'est juste quelques lignes de code.

Déjà, notre potin aura deux variables d'instance que tu peux d'ores et déjà mettre en attr_reader : le author et le content.

Ces attributs seront déclarés à l'initialisation de façon classique. Rajoute ce code à la classe Gossip :

def initialize(author, content)
  @content = content
  @author = author
end
Bon, grâce à ce code, si on fait Gossip.new("moi", "coucou !"), on peut créer un premier potin ! C'est un bon début, mais cela ne sauvegarde rien du tout dans notre CSV et du coup, l'information va disparaître quand le programme s'arrêtera de tourner. Il faudrait donc une méthode save qui enregistre dans la base de donnée l'instance de potin que l'on vient de créer. Nous allons faire cela.

En gros, quand on va vouloir créer un potin via le model Gossip, ça va se passer ainsi :

my_gossip = Gossip.new("auteur", "ceci est un exemple content") #=> Crée une instance de potin, sauvergardée juste dans cette variable
my_gossip.save #=> Sauvegarde l'instance de potin dans le CSV correspondant, en créant une nouvelle ligne dans mon fichier CSV
Notre base de données de potins sera rangée dans un fichier gossip.csv qui se trouve dans un dossier db/ (cf. l'arborescence donnée au début). Chaque ligne correspond à un potin, avec en colonne 1 le author et en colonne 2 le content.

Maintenant tu vas coder la méthode save dans la classe Gossip de façon à ce que si on l'appelle, cela crée une nouvelle ligne (sans tout effacer !) dans le CSV qui contiendra en colonne 1 le author et en colonne 2 le content (séparés par une virgule donc, c'est le principe du CSV).

Tu veux tester ta classe Gossip pour savoir si les méthodes initialize et save sont bien codées ? Voici une façon de t'y prendre :

Rajoute un petit require 'pry' en haut de la classe ;
Rajoute un petit binding.pry en bas de la classe ;
Exécute le fichier gossip.rb depuis ton terminal ;
Maintenant tu peux créer des objets gossip dans PRY. Par exemple : my_gossip = Gossip.new('José', 'Josiane ne sait pas se battre'). Ensuite tu peux aller voir si un my_gossip.save rajoute bien le gossip à ton CSV.
Evidemment, enlève le require et le binding.pry une fois que tu as fini !
2.2.5. Retour rapide au controller
Maintenant que le model est capable de créer un gossip et de le sauvegarder, retouche la méthode create_gossip dans le controller en y ajoutant les lignes suivantes :

gossip = Gossip.new("Jean-Michel Concierge", "Féfé est de Bordeaux")
#pour le moment, le contenu de ce gossip est inscrit "en dur" dans le code. L'utilisateur ne peut pas le changer.

gossip.save
Si tout est bien branché, si tu lances ton programmes et fais le choix 1 dans le menu du routeur, tu devrais voir apparaître une ligne dans ton CSV avec les paramètres "Jean-Michel Concierge" et "Féfé est de Bordeaux"v". Ce qui, quand on y pense, est un super début : tu as réussi à brancher tout seul comme un grand un routeur, un controller, et les lier à une base de données via un model. Je n'ai quasiment rien fait. Joli 😘

Évidemment, ce n'est pas encore fini, puisqu'il faut pouvoir rentrer les potins en base en choississant l'auteur et le contenu (on veut un programme intéractif !) . Eh bien la view va s'occuper de gérer cela : on va l'appeler depuis le controller.

Est-ce que tu te rappelles comment on fait pour qu'une classe (Controller) passe la main à une autre (View)? Exactement de la même façon que le routeur a rediriger vers le controller ! Vérifie que tu as bien require la classe View à partir du controller, puis fais un petit @view = View.new dans l'initialize du controller.
Maintenant, au début de la méthode create_gossip de Controller, on va appeler la classe View en faisant : params = @view.create_gossip. Et oui, pour ne pas nous emmêler trop les pinceaux, on va se débrouiller pour que la méthode create_gossip de la classe Controller soit liée à une méthode éponyme create_gossip de la classe View. Comme ça c'est facile de s'en rappeler.

Donc si je résume ce que fait la méthode create_gossip du controller :

Elle exécute la méthode create_gossip de la View afin de récupérer les infos de l'utilisateur (= le contenu et l'auteur du nouveau gossip) ;
Elle créé une instance de Gossip avec Gossip.new (on verra comment injecter ici les infos saisies par l'utilisateur) ;
Elle finit par demander au model de l'inscrire dans le CSV avec gossip.save.
2.2.6. La view
Évidemment, si tu testes le programme, ce dernier va te saouler, car il faut créer le fichier view.rb et la classe View. Ça commence à être relou, MAIS ce sera la dernière fois aujourd'hui que tu vas faire cela. Promis.
Une fois le fichier créé, l'arborescence de ton dossier devrait être identique à l'arborescence que j'avais proposée au début.

Alors réflechissons. Que voulons-nous que la méthode create_gossip de la classe View fasse ? Elle doit demander deux variables (l'auteur et le contenu) à l'utilisateur (via des puts et gets.chomp), puis retourner ces deux variables. C'est tout.

Pour le return des variables, je t'invite à le faire sous la forme d'un hash : return params = { content: content_que_tu_viens_de_demander, author: author_que_tu_viens_de_demander }. Pourquoi comme ceci ? Eh bien en général pour les interactions avec les utilisateurs, dans le web on utilise une variable qui s'appelle params et qui est sous le format hash. Et c'est bien d'avoir dès le début les bons termes.
Bien entendu, tu aurais pu enlever params = ce qui aurait donné exactement le même résultat (une méthode retourne le contenu d'une variable, pas son nom), mais c'est pour plus de clarté, ce qui n'est jamais de refus quand on débute 😇

Je te laisse coder la méthode create_gossip de la classe View

2.2.7. Retour au controller
Encore ? Eh oui, le controller est le chef d'orchestre, donc c'est normal d'y faire des aller-retours ! Maintenant, si ton programme est bien branché, la méthode create_gossip de Controller devrait avoir à sa disposition une variable params qui est un hash qui contient les informations que tu veux.

🚀 ALERTE BONNE ASTUCE
Galère de variable mal placée ? Tu ne sais pas trop comment jouer avec params ? N'oublie pas ma phrase préférée : "dans le doute, fous des puts". Et n'hésite pas à faire plein de tests avec PRY, très pratique pour jouer avec des variables récalcitrantes.

Maintenant, injecte les valeurs de ton hash params dans le Gossip.new(author, content), et à toi la gloire !

2.2.8. Création terminée !
Waow ! Tu as réussi à faire –presque– tout seul une création de potin en MVC ! Si c'est pas classe ça, then I don't know what is 😎

On va pouvoir s'éclater avec la suite : nous allons afficher tous les potins, puis évidemment supprimer de la base les potins qui ne sont plus d'actualité. C'est parti !

2.3. Afficher les potins
Cette partie sera un peu moins pas à pas, mais quand même on va t'aider. Tout d'abord, avant de foncer tête baissée dans le code, nous allons réfléchir à ce qu'il faut.

Nous voudrions pouvoir, quand l'utilisateur le demande, afficher tous les potins en base. Cela veut dire : laisser la possibilité à l'utilisateur de choisir l'option 2. Afficher tous les potins via le routeur, ce qui va le rediriger vers une méthode index_gossips de notre controller. Cette méthode index_gossips va demander au model de lui sortir tous les potins, puis les donner à la view pour qu'elle puisse les afficher. Du MVC dans toute sa splendeur. Allez, c'est parti !

2.3.1. Le router
C'est la partie la plus simple : il faut pouvoir dire à l'utilisateur qu'il peut choisir 2, qui est le numéro pour afficher tous les potins. S'il choisit 2, nous allons le rediriger vers la méthode index_gossips de notre controller.

2.3.2. Le controller
La méthode index_gossips du controller va faire deux choses :

Demander au model un array qui contient tous les potins que l'on a en base
Demander à la view d’exécuter sa propre méthode index_gossips qui affichera tous les potins
2.3.3. Le model
Pour ceci, nous allons utiliser une méthode qui s'appelle self.all, qui va lire chaque ligne du CSV, puis retourner un array contenant des instances de potins du genre : [potin_1, potin_2, …, potin_n]. J'insiste sur un point: il s'agit d'un array d'objets de la classe Gossip. Donc si je fais potin_1.author, je récupère l'auteur du potin_1. Si je fais potin_2.content, je récupère le contenu du potin_2. Et ainsi de suite.

Comme ce n'est pas la méthode la plus simple, nous allons te donner le pseudo-code de la méthode self.all, pour t'aiguiller dans la recherche de l'array parfait :

def self.all
  # 1)création d'un array vide qui s'appelle all_gossips

  # 2)chaque ligne de ton CSV.each do |ligne|
    # 2-a) gossip_provisoire = Gossip.new(paramètres de la ligne) - permet de créer un objet gossip
    # 2-b) all_gossips << gossip_provisoire - permet de rajouter le gossip provisoire au array
  # end

  # 3)return all_gossips - on renvoie le résultat
end
🤓 QUESTION RÉCURRENTE
Mais dis donc Jamy, c'est quoi la différence entre def truc et def self.truc ? Excellente question car cela peut porter à confusion la première fois qu'on l'utilise.

On en a parlé dans le cours de POO: une méthode def self.truc est une méthode de classe qui s'appelle sur une classe entière (en faisant NomDeTaClasse.truc). Une méthode def truc est une méthode d'instance qui s'appelle sur une instance (en faisant nom_de_l_instance.truc).

Prenons l'exemple de ton potin : si tu veux sauvegarder un potin mon_potin pour le mettre en base, tu ne vas pas faire Gossip.save, mais plutôt mon_potin.save (tu l'exécute sur l'instance que tu veux sauver). La sauvegarde est plutôt une méthode d'instance.
Idem pour retourner la liste des potins que tu as en base, tu ne vas pas faire mon_potin.all, mais plutôt Gossip.all (tu l'exécute sur la classe entière dont tu veux obtenir toutes les instances). Récupérer toutes les instances en base est plutôt une méthode de classe.

Deuxième exemple (et on passe à la suite promis), si tu devais recoder la méthode new (à ne jamais faire), et bien tu ferais self.new car tu crées un potin en faisant Gossip.new, et non pas en faisant mon_potin.new.

2.3.4. La view
Maintenant que tu as un array qui contient tous les potins de ta base, tu as juste à la donner à la view, pour qu'elle les affiche. Une méthode index_gossips(gossips) qui contient l'array de tes potins en entrée (gossips) fera très bien l'affaire. En faisant faire à cette méthode un petit .each sur ton array, tu pourras puts chaque potin du array. Et voilà, tu as affiché les potins de ta base !

2.3.5. Index terminé !
Pfiou ! Tu es en grande forme aujourd'hui ! Tu commences à maîtriser super bien le MVC, et maintenant tu vas pouvoir passer à la fonctionnalité suivante : la possibilité de détruire un potin. 💣

2.4. Destroy
Pour cette dernière méthode, un peu plus complexe que les deux autres, nous allons te laisser gérer le truc, comme un grand. Il existe plein de méthodes différentes, mais en gros le programme va demander à l'utilisateur quel potin il veut supprimer, puis le programme le retirera ce potin du CSV. Et pas les autres 😝

2.5. Et voilà
Et bien bravo, tu as réussi à faire une application qui propose à l'utilisateur de balancer ses potins sur THP, en mode MVC. Bien joué, et on espère que tu débordes de fierté face à cette belle étape !

3. Rendu attendu
Tu devras rendre une application qui demande en boucle à l'utilisateur s'il veut afficher, créer, ou détruire des potins. Si tu fermes l'application, les données restent sauvegardées grâce à un système de gestion de base de données en CSV ou en JSON.

Voici l'arborescence du programme :

.
├── lib
│    ├── controller.rb
│    ├── gossip.rb
│    ├── router.rb
│    └── view.rb
├── db
│   └── gossip.csv
├── app.rb
├── Gemfile
└── Gemfile.lock
