module InOut where

import System.IO

create_display_buffer :: Int -> IO ()
create_display_buffer row_number
    | row_number > 1 = print row_number >> create_display_buffer (row_number - 1)
    | otherwise      = print row_number

display_board :: [[Char]] -> IO ()
display_board rows
    | length rows > 1 = putStrLn (head rows) >> display_board (tail rows)
    | otherwise       = putStrLn (head rows)