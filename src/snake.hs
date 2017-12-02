--Write some tests to assert this works
--Poll keys
--Update player position
--Update view with player
--Add targets to board
--Update view with targets
--On target, add length to body
--Update view with body
--On touching body or edge, kill snake, end game

module Snake where

import Control.Concurrent
import System.Console.ANSI

start_game = do
    let player_head = (10, 10) :: (Int,Int)
    let player_tail = [] :: [(Int,Int)]
    let board_x_y = (20,20) :: (Int,Int)
    let targets = [] :: [(Int,Int)]
    let delay = 1000000 :: Int
    game_loop player_head player_tail board_x_y targets delay

game_loop :: (Int,Int) -> [(Int,Int)] -> (Int,Int) -> [(Int,Int)] -> Int -> IO ()
game_loop player_head player_tail board_x_y targets delay = do
    -- let key = poll_inputs
    threadDelay delay
    render player_head player_tail board_x_y targets
    if (fst player_head) > 0
        then game_loop player_head player_tail board_x_y targets (delay - 5000)
        else print "bummer, snake bit the dust"

render :: (Int,Int) -> [(Int,Int)] -> (Int,Int) -> [(Int,Int)] -> IO ()
render player_head player_tail board_x_y targets = do
    clearScreen --Find a way to clear without actually doing the clear screen
    let board_view = create_board_view board_x_y
    let populated_board = populate_board_view player_head player_tail board_view targets
    display_board_view populated_board

create_board_view :: (Int,Int) -> [[Char]]
create_board_view board_x_y = do
    let row_number = (fst board_x_y)
    let column_number = (snd board_x_y)
    let board = create_all_rows [] row_number column_number
    board

create_all_rows :: [[Char]] -> Int -> Int -> [[Char]]
create_all_rows rows row_number column_number = do
    if row_number > 0
        then do
            let row = ['.' | x <- [1 .. column_number]]
            create_all_rows (rows ++ [row]) (row_number - 1) column_number
        else do
           rows

populate_board_view :: (Int,Int) -> [(Int,Int)] -> [[Char]] -> [(Int,Int)] -> [[Char]]
populate_board_view player_head player_tail board targets = do
    board

display_board_view :: [[Char]] -> IO ()
display_board_view rows = do
    if (length rows) > 1
        then do
            putStrLn (head rows)
            display_board_view (tail rows)
        else do
            putStrLn (head rows)
