# Seabase Delta

## Introduction
Hello there! This is the source code of an implementation of the Amstrad CPC464 game 
[Seabase Delta](http://cpcwiki.eu/index.php/Seabase_Delta). I loved playing this
game back in the mid 80s and it was really my first foray into Adventure games.

The game was built to run on the [IF](http://github.com/lee-jon/if) game engine
built in ruby. 

## Installation
You will need the current version of the IF engine and this game, the current build is located in the `bin` directory. Then create a games directory in the games directory within the if folder and copy the game to that folder. Alternatively you can build the game from scratch using:

    git clone http://github.com/lee-jon/if.git
    git clone http://github.com/lee-jon/seabase-delta.git
    
    mkdir if/games
    cd seabase-delta
    rake build
    ln -s bin/seabase-delta.game.rb ../games/seabase-delta.rb
    
Then play the game with
    
    cd ../if
    ruby

## License
Seabase Delta is licensed to Firebird Software (C) 1985

For use of the IF engine see its own LICENSE
For use of these files see LICENSE