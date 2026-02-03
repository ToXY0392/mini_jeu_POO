class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(damage_received)
    @life_points -= damage_received

    if @life_points <= 0
      @life_points = 0 if @life_points < 0
      puts "le joueur #{@name} a été tué !"
    end
  end

  def compute_damage
    rand(1..6)
  end

  def attacks(target_player)
    puts "#{@name} attaque #{target_player.name}"
    damage = compute_damage
    puts "il lui inflige #{damage} points de dommages"
    target_player.gets_damage(damage)
  end
end

# ==========================
#   HumanPlayer (V2)
# ==========================

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)          # garde le name
    @life_points = 100   # humain = 100 PV
    @weapon_level = 1    # arme de base niveau 1
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_level}"

    if new_level > @weapon_level
      @weapon_level = new_level
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    dice = rand(1..6)

    case dice
    when 1
      puts "Tu n'as rien trouvé..."
    when 2..5
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      @life_points += 50
      @life_points = 100 if @life_points > 100
    when 6
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
      @life_points += 80
      @life_points = 100 if @life_points > 100
    end
  end
end
