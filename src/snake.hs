module Snake where

eatTarget :: [(Int,Int)] -> [(Int,Int)] -> Bool
eatTarget snake targets = do
    let eaten = True -- without condition snake will not grow
    eaten

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

