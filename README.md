# Build
sudo apt-get install ghc
sudo apt-get install cabal-install
cabal update
cabal install ansi-terminal
cabal install hUnit

# Make
ghc --make src/snake.hs src/main.hs -o snake_game -odir
ghc --make src/snake.hs src/tests.hs -o tests -odir