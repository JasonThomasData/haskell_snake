--Add targets to board
--Update view with targets
--On touching snake or edge, kill snake, end game

import System.IO
import Control.Concurrent (threadDelay)
import System.Console.ANSI (cursorUpLine)

import InOut (create_display_buffer, display_board, get_key_pressed, set_buffer_settings, get_direction, display_instructions)
import Snake (eat_target, update_snake)
import View (create_board)

start_game :: IO ()
start_game = do
    let snake = [(10, 10)] :: [(Int,Int)]
    let direction = (0, -1) :: (Int,Int)
    let board_limits = (25, 25) :: (Int,Int)
    let targets = [] :: [(Int,Int)]
    let delay = 300000 :: Int
    set_buffer_settings
    display_instructions
    create_display_buffer (snd board_limits)
    game_loop snake direction board_limits targets delay

game_loop :: [(Int,Int)] -> (Int,Int) -> (Int,Int) -> [(Int,Int)] -> Int -> IO ()
game_loop snake current_direction board_limits targets delay = do
    key_down <- get_key_pressed
    let new_direction = get_direction key_down current_direction
    let has_eaten = eat_target snake targets
    let updated_snake = update_snake snake new_direction has_eaten
    render updated_snake board_limits targets
    threadDelay delay
    game_loop updated_snake new_direction board_limits targets delay

render :: [(Int,Int)] -> (Int,Int) -> [(Int,Int)] -> IO ()
render snake board_limits targets = do
    let board_view = create_board [] (fst board_limits) (snd board_limits) snake targets
    cursorUpLine (fst board_limits)
    display_board board_view

main = start_game
