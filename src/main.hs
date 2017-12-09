--Add targets to board
--Update view with targets
--On touching snake or edge, kill snake, end game

import System.IO
import Control.Concurrent (threadDelay)
import System.Console.ANSI (cursorUpLine)

import InOut (createDisplayBuffer, displayBoard, getKeyPressed, setBufferSettings, getDirection, displayInstructions)
import Snake (eatTarget, updateSnake)
import View (createBoard)

startGame :: IO ()
startGame = do
    let snake = [(10, 10)] :: [(Int,Int)]
    let direction = (0, -1) :: (Int,Int)
    let board_limits = (25, 25) :: (Int,Int)
    let targets = [] :: [(Int,Int)]
    let delay = 300000 :: Int
    setBufferSettings
    displayInstructions
    createDisplayBuffer (snd board_limits)
    gameLoop snake direction board_limits targets delay

gameLoop :: [(Int,Int)] -> (Int,Int) -> (Int,Int) -> [(Int,Int)] -> Int -> IO ()
gameLoop snake current_direction board_limits targets delay = do
    key_down <- getKeyPressed
    let new_direction = getDirection key_down current_direction
    let has_eaten = eatTarget snake targets
    let updated_snake = updateSnake snake new_direction has_eaten
    render updated_snake board_limits targets
    threadDelay delay
    gameLoop updated_snake new_direction board_limits targets delay

render :: [(Int,Int)] -> (Int,Int) -> [(Int,Int)] -> IO ()
render snake board_limits targets = do
    let board_view = createBoard [] (fst board_limits) (snd board_limits) snake targets
    cursorUpLine (fst board_limits)
    displayBoard board_view

main = start_game
