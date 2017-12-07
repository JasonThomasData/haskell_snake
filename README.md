I've been learning Haskell and having fun with it. This is a snake game and my first decent
crack at making a Haskell program. The program is modular enough to use a different view in
future but for now it's a terminal game.

This game assumes you have a qwerty keyboard

    h - left
    j - down
    k - up
    l - right

# Dependencies

    sudo apt-get install ghc
    sudo apt-get install cabal-install
    cabal update
    cabal install ansi-terminal
    cabal install hUnit

# Build

    ghc src/snake.hs src/view.hs src/io.hs -hidir build -odir build src/main.hs -o bin/snake_game
    ghc src/snake.hs src/view.hs src/io.hs -hidir build -odir build src/tests.hs -o bin/tests

# Run

    ./bin/tests
    ./bin/snake_game
