import Test.HUnit

import Snake (create_new_head, create_new_tail, update_snake)
import View (create_board, get_objects_in_row, check_column_occupied, create_row)

test_create_new_head_1 :: Test
test_create_new_head_1 = TestCase (assertEqual "." (13,12) (create_new_head [(12,13),(12,12),(11,12)] (1,-1)))

test_create_new_head_2 :: Test
test_create_new_head_2 = TestCase (assertEqual "." (11,13) (create_new_head [(12,13),(12,12),(11,12)] (-1,0)))

test_create_new_tail_1 :: Test
test_create_new_tail_1 = TestCase (assertEqual "." [(12,13),(12,12),(11,12)] (create_new_tail [(12,13),(12,12),(11,12)] True))

test_create_new_tail_2 :: Test
test_create_new_tail_2 = TestCase (assertEqual "." [(12,13),(12,12)] (create_new_tail [(12,13),(12,12),(11,12)] False))

test_update_snake :: Test
test_update_snake = TestCase (assertEqual "." [(12,12),(12,13),(12,12)] (update_snake [(12,13),(12,12),(11,12)] (0,-1) False))

test_get_objects_in_row :: Test
test_get_objects_in_row = TestCase (assertEqual "." [(5,1),(5,7)] (get_objects_in_row [(5,1),(8,5),(5,7)] [] 5))

test_create_row :: Test
test_create_row = TestCase (assertEqual "." "..O.O.XOX." (create_row [] 10 [(2,3),(6,5),(4,8)] [(3,7),(1,9)]))

test_check_column_occupied_1 :: Test
test_check_column_occupied_1 = TestCase (assertEqual "." True (check_column_occupied [(5,1),(8,5),(5,7)] 7))

test_check_column_occupied_2 :: Test
test_check_column_occupied_2 = TestCase (assertEqual "." False (check_column_occupied [(5,1),(8,5),(5,7)] 8))

test_create_board :: Test
test_create_board = TestCase (assertEqual "." ["...","..."] (create_board [] 2 3 [] []))

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
                  TestLabel "View" test_create_board]

main :: IO Counts
main = runTestTT tests