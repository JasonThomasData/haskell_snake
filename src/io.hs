module InOut where

import System.IO
import System.Random (randomRIO)
import System.Console.ANSI
import Control.Monad
import Data.Maybe

setBufferSettings :: IO ()
setBufferSettings = do
    hSetEcho stdin False
    hSetBuffering stdin NoBuffering

displayInstructions :: IO ()
displayInstructions = do
    putStrLn "...SNAKE..."
    putStrLn ".h.left...."
    putStrLn ".j.down...."
    putStrLn ".k.up......"
    putStrLn ".l.right..."
    putStrLn "..........."

createDisplayBuffer :: Int -> IO ()
createDisplayBuffer row_number
    | row_number > 1 = print row_number >> createDisplayBuffer (row_number - 1)
    | otherwise      = print row_number

toTopOfDisplay :: (Int,Int) -> IO ()
toTopOfDisplay board_limits = do
    let number_of_rows = fst board_limits + 1
    cursorUpLine number_of_rows

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

getRandomPos :: (Int,Int) -> IO (Int,Int)
getRandomPos board_limits = do
    row_number <- randomRIO (0, fst board_limits)
    col_number <- randomRIO (0, snd board_limits)
    return (row_number, col_number)

