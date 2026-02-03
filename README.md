🎮 Mini Game – “They All Want Your OOP”

A small Ruby project introducing Object-Oriented Programming concepts through a simple Fortnite-style battle simulation.

📌 Project Goal

Build a progressive mini-game across three versions, each adding new features and better structure:

Version 1: Basic combat between two players (Player)

Version 2: Interactive combat between a human player and two bots (HumanPlayer + Player)

Version 3: A full game architecture using a Game class, with enemy management and new enemies appearing over time

🗂 Project Structure
mini_jeu_POO
├── app.rb         # Version 1
├── app_2.rb       # Version 2
├── app_3.rb       # Version 3
├── lib
│   ├── player.rb  # Player + HumanPlayer
│   └── game.rb    # Game (used in Version 3)
├── Gemfile
└── README.md

🚀 Installation

Install all dependencies:

bundle install


Run the version you want:

Version 1

ruby app.rb


Version 2

ruby app_2.rb


Version 3

ruby app_3.rb

🧱 Version 1 – Basic Automatic Fight
Files:

app.rb

lib/player.rb

Description:

Creates two players (“José” and “Josiane”)

They attack each other automatically with random damage

The game ends when one player reaches 0 HP

🧩 Version 2 – Interactive Fight
Files:

app_2.rb

lib/player.rb (adds the HumanPlayer class)

Features:

Human player starts with 100 HP and weapon level 1

Player can choose between:

Searching for a better weapon

Searching for a health pack

Attacking one of the two enemies

Bots attack the human player after each turn

The game ends when the player or both enemies die

🧠 Version 3 – Game Class + Dynamic Enemies
Files:

app_3.rb

lib/game.rb

Features:

Introduces a Game class that manages:

The human player

All enemies

Enemies in sight

New enemies spawning depending on a dice roll

Player must eliminate a total of 10 enemies

Enemies appear gradually during the fight

app_3.rb becomes a clean controller that only calls Game methods

🧪 Running the Game
ruby app.rb
ruby app_2.rb
ruby app_3.rb

📝 Notes

Damage and enemy appearance are randomized using rand(1..6).

You can add binding.pry anywhere while developing to debug.

The project uses Bundler to load gems.