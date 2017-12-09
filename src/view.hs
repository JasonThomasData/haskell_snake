module View where

createBoard :: [[Char]] -> Int -> Int -> [(Int,Int)] -> [(Int,Int)] -> [[Char]]
createBoard rows row_number column_number snake targets
    | row_number == 0 = rows
    | otherwise       = createBoard (rows ++ [row]) (row_number - 1) column_number snake targets
    where
        snake_in_row = getObjectsInRow snake [] row_number
        targets_in_row = getObjectsInRow targets [] row_number
        row = createRow [] column_number snake_in_row targets_in_row

getObjectsInRow :: [(Int,Int)] -> [(Int,Int)] -> Int -> [(Int,Int)]
getObjectsInRow to_check in_row row_number
    | null to_check                = in_row
    | row_number == fst one_object = getObjectsInRow (tail to_check) (in_row ++ [one_object]) row_number
    | otherwise                    = getObjectsInRow (tail to_check) in_row row_number
    where
        one_object = head to_check

createRow :: [Char] -> Int -> [(Int,Int)] -> [(Int,Int)] -> [Char]
createRow row column_number snake_in_row targets_in_row
    | column_number == 0 = row
    | snake_here         = createRow ('O' : row) (column_number - 1) snake_in_row targets_in_row
    | target_here        = createRow ('X' : row) (column_number - 1) snake_in_row targets_in_row
    | otherwise          = createRow ('.' : row) (column_number - 1) snake_in_row targets_in_row
    where
        snake_here = checkColumnOccupied snake_in_row column_number
        target_here = checkColumnOccupied targets_in_row column_number

checkColumnOccupied :: [(Int,Int)] -> Int -> Bool
checkColumnOccupied in_row column_number
    | null in_row                     = False
    | column_number == snd one_object = True
    | otherwise                       = checkColumnOccupied (tail in_row) column_number
    where
        one_object = head in_row
