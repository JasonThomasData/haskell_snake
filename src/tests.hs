import Test.HUnit

import InOut (get_direction)
import Snake (create_new_head, create_new_tail, update_snake)
import View (create_board, get_objects_in_row, check_column_occupied, create_row)

test_create_new_head_1 :: Test
test_create_new_head_1 = TestCase (assertEqual "_" (13,12) (create_new_head [(12,13),(12,12),(11,12)] (1,-1)))

test_create_new_head_2 :: Test
test_create_new_head_2 = TestCase (assertEqual "_" (11,13) (create_new_head [(12,13),(12,12),(11,12)] (-1,0)))

test_create_new_tail_1 :: Test
test_create_new_tail_1 = TestCase (assertEqual "_" [(12,13),(12,12),(11,12)] (create_new_tail [(12,13),(12,12),(11,12)] True))

test_create_new_tail_2 :: Test
test_create_new_tail_2 = TestCase (assertEqual "_" [(12,13),(12,12)] (create_new_tail [(12,13),(12,12),(11,12)] False))

test_update_snake :: Test
test_update_snake = TestCase (assertEqual "_" [(12,12),(12,13),(12,12)] (update_snake [(12,13),(12,12),(11,12)] (0,-1) False))

test_get_objects_in_row :: Test
test_get_objects_in_row = TestCase (assertEqual "_" [(5,1),(5,7)] (get_objects_in_row [(5,1),(8,5),(5,7)] [] 5))

test_create_row :: Test
test_create_row = TestCase (assertEqual "_" "..O.O.XOX." (create_row [] 10 [(2,3),(6,5),(4,8)] [(3,7),(1,9)]))

test_check_column_occupied_1 :: Test
test_check_column_occupied_1 = TestCase (assertEqual "_" True (check_column_occupied [(5,1),(8,5),(5,7)] 7))

test_check_column_occupied_2 :: Test
test_check_column_occupied_2 = TestCase (assertEqual "_" False (check_column_occupied [(5,1),(8,5),(5,7)] 8))

test_create_board :: Test
test_create_board = TestCase (assertEqual "_" ["...","..."] (create_board [] 2 3 [] []))

test_get_direction_1 :: Test
test_get_direction_1 = TestCase (assertEqual "_" ( 0,-1) (get_direction 'h' ( 1, 0)))

test_get_direction_2 :: Test
test_get_direction_2 = TestCase (assertEqual "_" (-1, 0) (get_direction 'j' ( 1, 0)))

test_get_direction_3 :: Test
test_get_direction_3 = TestCase (assertEqual "_" ( 1, 0) (get_direction 'k' ( 1, 0)))

test_get_direction_4 :: Test
test_get_direction_4 = TestCase (assertEqual "_" ( 0, 1) (get_direction 'l' ( 1, 0)))

test_get_direction_5 :: Test
test_get_direction_5 = TestCase (assertEqual "_" ( 1, 0) (get_direction 'd' ( 1, 0)))

tests :: Test
tests = TestList [TestLabel "Snake" test_create_new_head_1,
                  TestLabel "Snake" test_create_new_head_2,
                  TestLabel "Snake" test_create_new_tail_1,
                  TestLabel "Snake" test_create_new_tail_2,
                  TestLabel "Snake" test_update_snake,
                  TestLabel "View" test_get_objects_in_row,
                  TestLabel "View" test_create_row,
                  TestLabel "View" test_check_column_occupied_1,
                  TestLabel "View" test_check_column_occupied_2,
                  TestLabel "View" test_create_board,
                  TestLabel "InOut" test_get_direction_1,
                  TestLabel "InOut" test_get_direction_2,
                  TestLabel "InOut" test_get_direction_3,
                  TestLabel "InOut" test_get_direction_4,
                  TestLabel "InOut" test_get_direction_5]

main :: IO Counts
main = runTestTT tests
