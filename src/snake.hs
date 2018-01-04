module Snake where

import Interact (checkCollision, checkOnBoard)

checkAlive :: [(Int,Int)] -> (Int,Int) -> Bool
checkAlive snake board_limits
    | has_eaten_self  = False
    | not is_on_board = False
    | otherwise       = True
    where
        has_eaten_self = eatObject (head snake) (tail snake)
        is_on_board = checkOnBoard board_limits (head snake)

eatObject :: (Int,Int) -> [(Int,Int)] -> Bool
eatObject snake_head objects = checkCollision objects snake_head

updateSnake :: [(Int,Int)] -> (Int,Int) -> Bool -> [(Int,Int)]
updateSnake snake direction has_eaten = do
    let head = createNewHead snake direction
    let tail = createNewTail snake has_eaten
    head : tail

createNewHead :: [(Int,Int)] -> (Int,Int) -> (Int,Int)
createNewHead snake direction = do
    let current_head = head snake
    let new_head_x = fst current_head + fst direction
    let new_head_y = snd current_head + snd direction
    (new_head_x, new_head_y)

createNewTail :: [(Int,Int)] -> Bool -> [(Int,Int)]
createNewTail snake eaten
    | eaten         = snake
    | otherwise     = init snake

getDirection :: Char -> (Int,Int) -> (Int,Int)
getDirection key_pressed current_direction
    | key_pressed == 'h' = ( 0,-1)
    | key_pressed == 'j' = (-1, 0)
    | key_pressed == 'k' = ( 1, 0)
    | key_pressed == 'l' = ( 0, 1)
    | otherwise          = current_direction
