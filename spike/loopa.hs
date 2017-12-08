import System.IO
import Control.Concurrent

get_direction :: Char -> (Int,Int)
get_direction key_pressed
    | key_pressed == 'h'  = ( 0,-1)
    | key_pressed == 'j'  = (-1, 0)
    | key_pressed == 'k'  = ( 1, 0)
    | key_pressed == 'l'  = ( 0, 1)
    | otherwise           = ( 0, 0)


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
    print pressed
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

