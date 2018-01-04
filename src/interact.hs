module Interact where

import InOut (getRandomPos)

-- For objects to interact with their world

checkOffBoard :: Int -> Int -> Int -> Bool
checkOffBoard min pos max
    | min > pos = True
    | pos > max = True
    | otherwise = False

checkOnBoard :: (Int,Int) -> (Int,Int) -> Bool
checkOnBoard board_limits pos
    | checkOffBoard 0 snake_row row_max = False
    | checkOffBoard 0 snake_col col_max = False
    | otherwise                         = True
    where
        snake_row = fst pos
        snake_col = snd pos
        row_max = fst board_limits
        col_max = snd board_limits

checkCollision :: [(Int,Int)] -> (Int,Int) -> Bool
checkCollision objects pos
    | length objects < 1  = False
    | head objects == pos = True
    | otherwise           = checkCollision (tail objects) pos

checkPosVacant :: [(Int,Int)] -> (Int,Int) -> Bool
checkPosVacant snake pos
    | checkCollision snake pos = False
    | otherwise                = True

getVacantRandomPos :: (Int,Int) -> [(Int,Int)] -> IO (Int,Int)
getVacantRandomPos board_limits snake = do
    potential_pos <- getRandomPos board_limits
    let vacant = checkPosVacant snake potential_pos
    if vacant
        then return potential_pos
        else getVacantRandomPos board_limits snake

updateTargets :: [(Int,Int)] -> [(Int,Int)] -> (Int,Int) -> Bool -> IO [(Int,Int)]
updateTargets snake targets board_limits has_eaten =
    if has_eaten
        then do
            new_target <- getVacantRandomPos board_limits snake
            return [new_target]
        else
            return targets
