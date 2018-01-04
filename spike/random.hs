import System.Random (randomRIO)

randomPos :: (Int, Int) -> IO (Int, Int)
randomPos board_limits = do
    row_number <- randomRIO (0, (fst board_limits) :: Int) :: IO Int
    col_number <- randomRIO (0, (snd board_limits) :: Int) :: IO Int
    return (row_number, col_number)

getResults :: IO ()
getResults = do
    let board_limits = (500,500)
    randomPos board_limits >>= print

main = getResults

