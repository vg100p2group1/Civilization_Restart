# Change Log

### [0.5.0] - 2020-07-26

#### Added:

* Add attributes of clip, attack, hp, armor, and shootSpeed to the player.
* The skills of Berserker upgrading can be applied to actual behaviors in the game.
* Add the function of Pause and Resume for the game by pressing **Blank Space**.
* Add the death window reminder for the player after his HP becomes 0.
* Refine the shooting patterns of the monsters.
* Add the active skill of dualWield in the game that player can shoot two bullets at one time by pressing **1**.
* Add the door that can be closed or opened in the game.
* Add package System and Synthesis System.
* Different pictures for this game including guns and walls.

#### Fixed:

* Fix the bug that the shootSpeed of the weapons can not be correctly updated.
* Fix the bug that the corner of the minimap will vanish.
* Fix the bug that when player is upgrading the skill tree, the game still goes on instead of pausing.
* Fix the bug there sometimes exist disorderly pictures.

#### Deprecated:

* The The simple dialogues will be replaced by more advanced ones to push the story.
* The blank and ugly background will be replaced.
* The treasure box pictures will be replaced by pictures instead of simple colorful rectangles.

#### Removed: 

* The connection line between the mouse position and players' guns.
* The original small and simple guns.
* Changing weapon by pressing **1, 2, 3, 4**
* Delete one of the skill trees.

### [0.2.0] - 2020-07-19

#### Added:

* Add treasures to the map and they will be activated when the monsters are eliminated.
* Design the weapon system so that the player can change their guns by pressing **Q** or **1, 2, 3, 4**
* Add the explosion effect when the bullets hit the obstacles.
* Add the animation for the player when he moves or shoots.
* Add the skill tree system by pressing **B**, so that players can upgrade their skills to get more interesting experience.
* Refine the monsters' behaviors so that the level of difficulty is more proper.
* The dialogues between player and bosses can be automatically presented when he moves to a new stage.

#### Fixed:

* Fix the bug that some of the monsters will collide with the wall.
* Fix the bug that the player's gun will be automatically changed when he enters a new room.
* Fix the bug that the shooting rate of the monsters are too fast and several bullets are shot at one time.
* Fix the bug that there exist blank space between player and walls when he approaches them.
* Fix the bug that the bullets will go through the walls.

#### Deprecated:

* The connection line between the mouse position and players' guns.

* The simple dialogues will be replaced by more advanced ones to push the story.

* The background will be replaced by scenes.

* The gun and player pictures will be replaced by more delicate and different ones.

  

### [0.1.0] - 2020-07-13

#### Added:

* Add the random behaviors of the AI monsters. 
* Update the status of the monsters after they are hit by players. The monsters will lose HP and finally die.
* Add screen adaptations to the project.
* Devise the minimap of the whole big map so that so the players can get a rough idea where they are.
* Add the basic interface of the interactions between players and bosses.
* Update the status of bullets after they hit entities.
* Add the weapon system.
* Display the whole map including walls, monsters, players, doors, and gateways. etc.
* Complete the whole map generator including different kinds of walls, monsters, doors, and gateways. etc.
* Add the basic view interface of the game.
* Design the basic frame of the game.

#### Fixed:

* The bug that players can cross through the walls.
* The bug that monsters will not HP after they are shot by bullets.
* The bug that minimap cannot accurately corresponds to the real map the players are in.
* The bug that players are not in the center of the screen.

#### Deprecated:

* Players will no more need to press **G** to show the dialogues during interactions with bosses. The interface of dialogues will automatically pop out once the players enter a new boss room

* The random tremble of the monsters will be replaced by more advanced and intelligent monsters behaviors towards players.






