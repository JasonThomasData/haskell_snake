module InOut where

import System.IO

import System.Console.ANSI
import Control.Concurrent
import Control.Monad
import Data.Maybe

setBufferSettings :: IO ()
setBufferSettings = do
    hSetEcho stdin False
    hSetBuffering stdin NoBuffering

displayInstructions :: IO ()
displayInstructions = do
    putStrLn ".SNAKE."
    putStrLn ".h - left."
    putStrLn ".j - down."
    putStrLn ".k - up."
    putStrLn ".l - right."

createDisplayBuffer :: Int -> IO ()
createDisplayBuffer row_number
    | row_number > 1 = print row_number >> createDisplayBuffer (row_number - 1)
    | otherwise      = print row_number

displayBoard :: [[Char]] -> IO ()
displayBoard rows
    | length rows > 1 = putStrLn (head rows) >> displayBoard (tail rows)
    | otherwise       = putStrLn (head rows)

getKeyPressed :: IO Char
getKeyPressed = do
    ready <- hReady stdin
    if ready
        then getChar
        else return '.'

getDirection :: Char -> (Int,Int) -> (Int,Int)
getDirection key_pressed current_direction
    | key_pressed == 'h' = ( 0,-1)
    | key_pressed == 'j' = (-1, 0)
    | key_pressed == 'k' = ( 1, 0)
    | key_pressed == 'l' = ( 0, 1)
    | otherwise          = current_direction

