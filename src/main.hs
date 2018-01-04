import System.IO
import Control.Concurrent (threadDelay)
import System.Console.ANSI (cursorUpLine)
import System.Exit (exitSuccess)

import Interact (updateTargets, getVacantRandomPos)
import InOut (createDisplayBuffer, displayBoard, getKeyPressed, setBufferSettings, displayInstructions, toTopOfDisplay)
import Snake (checkAlive, eatObject, updateSnake, getDirection)
import View (createBoard)

startGame :: IO ()
startGame = do
    let snake = [(12, 12)] :: [(Int,Int)]
    let direction = (0, -1) :: (Int,Int)
    let board_limits = (14, 14) :: (Int,Int)
    firstTarget <- getVacantRandomPos board_limits snake
    let targets = [firstTarget] :: [(Int,Int)]
    let delay = 220000 :: Int
    setBufferSettings
    displayInstructions
    createDisplayBuffer (snd board_limits)
    gameLoop snake direction board_limits targets delay

gameLoop :: [(Int,Int)] -> (Int,Int) -> (Int,Int) -> [(Int,Int)] -> Int -> IO ()
gameLoop snake current_direction board_limits targets delay = do
    key_down <- getKeyPressed
    let new_direction = getDirection key_down current_direction
    let has_eaten = eatObject (head snake) targets
    let updated_snake = updateSnake snake new_direction has_eaten
    updated_targets <- updateTargets snake targets board_limits has_eaten
    let is_alive = checkAlive updated_snake board_limits
    render updated_snake board_limits updated_targets
    threadDelay delay
    if is_alive
        then gameLoop updated_snake new_direction board_limits updated_targets delay
        else gameFinish

gameFinish :: IO ()
gameFinish = do
    print "You are a dead snake"
    exitSuccess

render :: [(Int,Int)] -> (Int,Int) -> [(Int,Int)] -> IO ()
render snake board_limits targets = do
    toTopOfDisplay board_limits
    let board_view = createBoard [] (fst board_limits) (snd board_limits) snake targets
    displayBoard board_view

main = startGame
