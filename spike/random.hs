import System.Random (randomRIO)

randomPos :: (Int, Int) -> IO (Int, Int)
randomPos board_limits = do
    row_number <- randomRIO (0, fst board_limits :: Int) :: IO Int
    col_number <- randomRIO (0, snd board_limits :: Int) :: IO Int
    return (row_number, col_number)

checkValid :: (Int, Int) -> IO Bool
checkValid pos
    | pos == (1, 1) = return True
    | otherwise     = return False

getResults :: IO ()
getResults = do
    let board_limits = (2, 2)
    pos <- randomPos board_limits
    valid <- checkValid pos
    if valid
        then print "HIT" >> print pos 
        else print "MISS" >> print pos

main = getResults

