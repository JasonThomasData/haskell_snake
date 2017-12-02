# Dependencies

    sudo apt-get install ghc
    sudo apt-get install cabal-install
    cabal update
    cabal install ansi-terminal
    cabal install hUnit

# Build

    ghc --make src/snake.hs -hidir build -odir build src/main.hs -o bin/snake_game
    ghc --make src/snake.hs -hidir build -odir build src/tests.hs -o bin/tests

# Run

    ./bin/snake_game
    ./bin/tests