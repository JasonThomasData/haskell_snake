--Poll keys
--Add targets to board
--Update view with targets
--On target, add length to snake
--On touching snake or edge, kill snake, end game

module Snake where

import Control.Concurrent
import System.Console.ANSI
import System.IO

start_game :: IO ()
start_game = do
    let snake = [(10, 10)] :: [(Int,Int)]
    let direction = (0, -1) :: (Int,Int)
    let board_limits = (20, 20) :: (Int,Int)
    let targets = [] :: [(Int,Int)]
    let delay = 200000 :: Int
    create_display_buffer (snd board_limits)
    game_loop snake direction board_limits targets delay


game_loop :: [(Int,Int)] -> (Int,Int) -> (Int,Int) -> [(Int,Int)] -> Int -> IO ()
game_loop snake direction board_limits targets delay = do
    -- let key = poll_inputs
    let has_eaten = eat_target snake targets
    let updated_snake = update_snake snake direction has_eaten
    render updated_snake board_limits targets
    threadDelay delay
    game_loop updated_snake direction board_limits targets delay

render :: [(Int,Int)] -> (Int,Int) -> [(Int,Int)] -> IO ()
render snake board_x_y targets = do
    let board_view = create_board [] (fst board_x_y) (snd board_x_y) snake targets
    cursorUpLine 20
    display_board board_view

--GameLogic

eat_target :: [(Int,Int)] -> [(Int,Int)] -> Bool
eat_target snake targets = do
    let eaten = False -- without condition snake will not grow
    eaten

update_snake :: [(Int,Int)] -> (Int,Int) -> Bool -> [(Int,Int)]
update_snake snake direction has_eaten = do
    let head = create_new_head snake direction
    let tail = create_new_tail snake has_eaten
    head : tail

create_new_head :: [(Int,Int)] -> (Int,Int) -> (Int,Int)
create_new_head snake direction = do
    let current_head = head snake
    let new_head_x = (fst current_head) + (fst direction)
    let new_head_y = (snd current_head) + (snd direction)
    (new_head_x, new_head_y)

create_new_tail :: [(Int,Int)] -> Bool -> [(Int,Int)]
create_new_tail snake eaten
    | eaten == True = snake
    | otherwise     = init snake

--View

create_board :: [[Char]] -> Int -> Int -> [(Int,Int)] -> [(Int,Int)] -> [[Char]]
create_board rows row_number column_number snake targets
    | row_number == 0 = rows
    | otherwise       = create_board (rows ++ [row]) (row_number - 1) column_number snake targets
    where
        snake_in_row = get_objects_in_row snake [] row_number
        targets_in_row = get_objects_in_row targets [] row_number
        row = create_row [] column_number snake_in_row targets_in_row

get_objects_in_row :: [(Int,Int)] -> [(Int,Int)] -> Int -> [(Int,Int)]
get_objects_in_row to_check in_row row_number
    | length to_check == 0           = in_row
    | row_number == (fst one_object) = get_objects_in_row (tail to_check) (in_row ++ [one_object]) row_number
    | otherwise                      = get_objects_in_row (tail to_check) in_row row_number
    where
        one_object = head to_check

create_row :: [Char] -> Int -> [(Int,Int)] -> [(Int,Int)] -> [Char]
create_row row column_number snake_in_row targets_in_row
    | column_number == 0 = row
    | snake_here         = create_row ('O' : row) (column_number - 1) snake_in_row targets_in_row
    | target_here        = create_row ('X' : row) (column_number - 1) snake_in_row targets_in_row
    | otherwise          = create_row ('.' : row) (column_number - 1) snake_in_row targets_in_row
    where
        snake_here = check_column_occupied snake_in_row column_number
        target_here = check_column_occupied targets_in_row column_number

check_column_occupied :: [(Int,Int)] -> Int -> Bool
check_column_occupied in_row column_number
    | length in_row == 0                = False
    | column_number == (snd one_object) = True
    | otherwise                         = check_column_occupied (tail in_row) column_number
    where
        one_object = head in_row

--IO

create_display_buffer :: Int -> IO ()
create_display_buffer row_number
    | row_number > 1 = print row_number >> create_display_buffer (row_number - 1)
    | otherwise      = print row_number

display_board :: [[Char]] -> IO ()
display_board rows
    | length rows > 1 = putStrLn (head rows) >> display_board (tail rows)
    | otherwise       = putStrLn (head rows)
