module View where

create_board :: [[Char]] -> Int -> Int -> [(Int,Int)] -> [(Int,Int)] -> [[Char]]
create_board rows row_number column_number snake targets
    | row_number == 0 = rows
    | otherwise       = create_board (rows ++ [row]) (row_number - 1) column_number snake targets
    where
        snake_in_row = get_objects_in_row snake [] row_number
        targets_in_row = get_objects_in_row targets [] row_number
        row = create_row [] column_number snake_in_row targets_in_row

get_objects_in_row :: [(Int,Int)] -> [(Int,Int)] -> Int -> [(Int,Int)]
get_objects_in_row to_check in_row row_number
    | length to_check == 0           = in_row
    | row_number == (fst one_object) = get_objects_in_row (tail to_check) (in_row ++ [one_object]) row_number
    | otherwise                      = get_objects_in_row (tail to_check) in_row row_number
    where
        one_object = head to_check

create_row :: [Char] -> Int -> [(Int,Int)] -> [(Int,Int)] -> [Char]
create_row row column_number snake_in_row targets_in_row
    | column_number == 0 = row
    | snake_here         = create_row ('O' : row) (column_number - 1) snake_in_row targets_in_row
    | target_here        = create_row ('X' : row) (column_number - 1) snake_in_row targets_in_row
    | otherwise          = create_row ('.' : row) (column_number - 1) snake_in_row targets_in_row
    where
        snake_here = check_column_occupied snake_in_row column_number
        target_here = check_column_occupied targets_in_row column_number

check_column_occupied :: [(Int,Int)] -> Int -> Bool
check_column_occupied in_row column_number
    | length in_row == 0                = False
    | column_number == (snd one_object) = True
    | otherwise                         = check_column_occupied (tail in_row) column_number
    where
        one_object = head in_row