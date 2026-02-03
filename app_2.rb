require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# =============================
#   VERSION 2.0 : JEU INTERACTIF
# =============================

puts "------------------------------------------------"
puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "| Le but du jeu est d'être le dernier survivant !|"
puts "------------------------------------------------"
puts ""

print "Quel est ton prénom ? > "
user_name = gets.chomp
user = HumanPlayer.new(user_name)

player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]

puts ""
puts "Le combat commence !"
puts ""

while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)

  puts ""
  puts "----- Ton état -----"
  user.show_state
  puts ""

  puts "Quelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts ""
  puts "attaquer un joueur en vue :"

  if player1.life_points > 0
    print "0 - "
    player1.show_state
  end

  if player2.life_points > 0
    print "1 - "
    player2.show_state
  end

  print "> "
  choice = gets.chomp
  puts ""

  case choice
  when "a"
    user.search_weapon

  when "s"
    user.search_health_pack

  when "0"
    if player1.life_points > 0
      user.attacks(player1)
    else
      puts "Josiane est déjà morte..."
    end

  when "1"
    if player2.life_points > 0
      user.attacks(player2)
    else
      puts "José est déjà mort..."
    end

  else
    puts "Commande inconnue… tu perds ton tour."
  end

  puts ""
  puts "Les autres joueurs t'attaquent !"

  enemies.each do |enemy|
    if enemy.life_points > 0
      enemy.attacks(user)
    end
  end

end

puts ""
puts "La partie est finie."

if user.life_points > 0
  puts "BRAVO ! TU AS GAGNE ! 🎉"
else
  puts "Loser ! Tu as perdu ! 💀"
end
