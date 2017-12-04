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