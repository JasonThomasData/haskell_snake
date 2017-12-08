module InOut where

import System.IO

import System.Console.ANSI
import Control.Concurrent
import Control.Monad
import Data.Maybe

set_buffer_settings :: IO ()
set_buffer_settings = do
    hSetEcho stdin False
    hSetBuffering stdin NoBuffering

display_instructions :: IO ()
display_instructions = do
    print "--SNAKE--"
    print "h - left"
    print "j - down"
    print "k - up"
    print "l - right"

create_display_buffer :: Int -> IO ()
create_display_buffer row_number
    | row_number > 1 = print row_number >> create_display_buffer (row_number - 1)
    | otherwise      = print row_number

display_board :: [[Char]] -> IO ()
display_board rows
    | length rows > 1 = putStrLn (head rows) >> display_board (tail rows)
    | otherwise       = putStrLn (head rows)

get_key_pressed :: IO Char
get_key_pressed = do
    ready <- hReady stdin
    if ready
        then getChar
        else return '.'

get_direction :: Char -> (Int,Int) -> (Int,Int)
get_direction key_pressed current_direction
    | key_pressed == 'h' = ( 0,-1)
    | key_pressed == 'j' = (-1, 0)
    | key_pressed == 'k' = ( 1, 0)
    | key_pressed == 'l' = ( 0, 1)
    | otherwise          = current_direction

