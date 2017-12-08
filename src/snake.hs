module Snake where

eat_target :: [(Int,Int)] -> [(Int,Int)] -> Bool
eat_target snake targets = do
    let eaten = True -- without condition snake will not grow
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

