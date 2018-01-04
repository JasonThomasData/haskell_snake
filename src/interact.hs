module Interact where

checkOffBoard :: Int -> Int -> Int -> Bool
checkOffBoard min pos max
    | min > pos = True
    | pos > max = True
    | otherwise = False

checkOnBoard :: (Int,Int) -> (Int,Int) -> Bool
checkOnBoard board_limits snake_pos
    | checkOffBoard 0 snake_row row_max = False
    | checkOffBoard 0 snake_col col_max = False
    | otherwise                         = True
    where
        snake_row = fst snake_pos
        snake_col = snd snake_pos
        row_max = fst board_limits
        col_max = snd board_limits

checkCollision :: [(Int,Int)] -> (Int,Int) -> Bool
checkCollision obstacles pos
    | length obstacles < 1  = False
    | head obstacles == pos = True
    | otherwise             = checkCollision (tail obstacles) pos

checkPosVacant :: [(Int,Int)] -> (Int,Int) -> Bool
checkPosVacant snake pos
    | checkCollision snake pos = False
    | otherwise                = True
