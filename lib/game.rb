require_relative 'player'

class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize(name)
    @human_player = HumanPlayer.new(name)

    # nombre total d'ennemis à éliminer dans la partie
    @players_left = 10

    # ennemis actuellement "en vue"
    @enemies_in_sight = []

    # on commence avec 4 ennemis déjà en vue
    @enemy_id_counter = 0
    4.times { add_new_enemy }
  end

  # Supprimer un ennemi (quand il est tué)
  def kill_player(player)
    if @enemies_in_sight.include?(player)
      @enemies_in_sight.delete(player)
      @players_left -= 1
    end
  end

  # Le jeu continue tant que :
  # - l'humain est vivant
  # - il reste au moins un ennemi à éliminer
  def is_still_ongoing?
    @human_player.life_points > 0 && @players_left > 0
  end

  # Affiche l'état du joueur humain + nombre d'ennemis restants
  def show_players
    puts "-------------------------"
    puts "État du joueur :"
    @human_player.show_state
    puts ""
    puts "Il reste #{@players_left} ennemis à éliminer."
    puts "Dont #{@enemies_in_sight.size} actuellement en vue."
    puts "-------------------------"
  end

  # Affiche le menu des actions possibles
  def menu
    puts ""
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts ""
    puts "attaquer un joueur en vue :"

    @enemies_in_sight.each_with_index do |enemy, index|
      next if enemy.life_points <= 0

      print "#{index} - "
      enemy.show_state
    end
  end

  # Applique l'action choisie par l'utilisateur
  def menu_choice(choice)
    case choice
    when "a"
      @human_player.search_weapon

    when "s"
      @human_player.search_health_pack

    else
      index = choice.to_i
      enemy = @enemies_in_sight[index]

      if enemy && enemy.life_points > 0
        @human_player.attacks(enemy)
        if enemy.life_points <= 0
          kill_player(enemy)
        end
      else
        puts "Aucun ennemi valide à cette position."
      end
    end
  end

  # Tous les ennemis en vue attaquent l'humain
  def enemies_attack
    puts ""
    puts "Les autres joueurs t'attaquent !"

    @enemies_in_sight.each do |enemy|
      if enemy.life_points > 0
        enemy.attacks(@human_player)
      end
    end
  end

  # Affichage de fin de partie
  def end
    puts ""
    puts "La partie est finie."

    if @human_player.life_points > 0
      puts "BRAVO ! TU AS GAGNE ! 🎉"
    else
      puts "Loser ! Tu as perdu ! 💀"
    end
  end

  # ===============================
  #   Gestion des nouveaux ennemis
  # ===============================

  # Ajoute de nouveaux ennemis en vue selon un jet de dé
  def new_players_in_sight
    # Si tous les joueurs restants sont déjà en vue, on n'en rajoute pas
    if @enemies_in_sight.size >= @players_left
      puts "Tous les joueurs sont déjà en vue."
      return
    end

    dice = rand(1..6)

    case dice
    when 1
      puts "Aucun nouvel ennemi n'arrive."

    when 2..4
      puts "Un nouvel ennemi arrive en vue !"
      add_new_enemy_if_possible(1)

    when 5..6
      puts "Deux nouveaux ennemis arrivent en vue !"
      add_new_enemy_if_possible(2)
    end
  end

  private

  # Crée un ennemi avec un nom unique de type "joueur_3"
  def add_new_enemy
    @enemy_id_counter += 1
    enemy = Player.new("joueur_#{@enemy_id_counter}")
    @enemies_in_sight << enemy
  end

  # Ajoute au maximum `count` ennemis sans dépasser @players_left
  def add_new_enemy_if_possible(count)
    remaining_not_in_sight = @players_left - @enemies_in_sight.size
    to_add = [count, remaining_not_in_sight].min
    to_add.times { add_new_enemy }
  end
end
