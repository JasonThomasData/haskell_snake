import System.IO
import Control.Concurrent

get_direction :: Char -> IO (Int,Int)
get_direction key_pressed
    | key_pressed == 'h'  = return ( 0,-1)
    | key_pressed == 'j'  = return (-1, 0)
    | key_pressed == 'k'  = return ( 1, 0)
    | key_pressed == 'l'  = return ( 0, 1)
    | otherwise           = return ( 0, 0)

--BETTER--

get_key_press :: IO Char
get_key_press = do
    ready <- hReady stdin
    if ready
        then getChar
        else return '.'

loop_better :: IO ()
loop_better = do
    threadDelay 200000
    pressed <- get_key_press
    direction <- get_direction pressed
    print pressed
    print direction 
    loop_better

main = do
    hSetEcho stdin False
    hSetBuffering stdin NoBuffering
    loop_better

--BASIC--

{-
loop :: Char -> IO ()
loop last_pressed = do
    threadDelay 200000
    hSetBuffering stdin NoBuffering
    ready <- hReady stdin
    if ready == True
        then do
            pressed <- getChar
            print pressed
            loop pressed
        else do
            print last_pressed
            loop last_pressed

main = do
    loop '.'
-}

