import Test.HUnit

import Interact (checkOffBoard, checkOnBoard, checkCollision, checkPosVacant)
import InOut (getDirection)
import Snake (createNewHead, createNewTail, updateSnake)
import View (createBoard, getObjectsInRow, checkColumnOccupied, createRow)

test_createNewHead_1 :: Test
test_createNewHead_1 = TestCase (assertEqual "_" (13,12) (createNewHead [(12,13),(12,12),(11,12)] (1,-1)))

test_createNewHead_2 :: Test
test_createNewHead_2 = TestCase (assertEqual "_" (11,13) (createNewHead [(12,13),(12,12),(11,12)] (-1,0)))

test_createNewTail_1 :: Test
test_createNewTail_1 = TestCase (assertEqual "_" [(12,13),(12,12),(11,12)] (createNewTail [(12,13),(12,12),(11,12)] True))

test_createNewTail_2 :: Test
test_createNewTail_2 = TestCase (assertEqual "_" [(12,13),(12,12)] (createNewTail [(12,13),(12,12),(11,12)] False))

test_updateSnake :: Test
test_updateSnake = TestCase (assertEqual "_" [(12,12),(12,13),(12,12)] (updateSnake [(12,13),(12,12),(11,12)] (0,-1) False))

test_getObjectsInRow :: Test
test_getObjectsInRow = TestCase (assertEqual "_" [(5,1),(5,7)] (getObjectsInRow [(5,1),(8,5),(5,7)] [] 5))

test_createRow :: Test
test_createRow = TestCase (assertEqual "_" "...O.O.XOX." (createRow [] 10 [(2,3),(6,5),(4,8)] [(3,7),(1,9)]))

test_checkColumnOccupied_1 :: Test
test_checkColumnOccupied_1 = TestCase (assertEqual "_" True (checkColumnOccupied [(5,1),(8,5),(5,7)] 7))

test_checkColumnOccupied_2 :: Test
test_checkColumnOccupied_2 = TestCase (assertEqual "_" False (checkColumnOccupied [(5,1),(8,5),(5,7)] 8))

test_createBoard :: Test
test_createBoard = TestCase (assertEqual "_" ["...","...","..."] (createBoard [] 2 2 [] []))

test_getDirection_1 :: Test
test_getDirection_1 = TestCase (assertEqual "_" ( 0,-1) (getDirection 'h' ( 1, 0)))

test_getDirection_2 :: Test
test_getDirection_2 = TestCase (assertEqual "_" (-1, 0) (getDirection 'j' ( 1, 0)))

test_getDirection_3 :: Test
test_getDirection_3 = TestCase (assertEqual "_" ( 1, 0) (getDirection 'k' ( 1, 0)))

test_getDirection_4 :: Test
test_getDirection_4 = TestCase (assertEqual "_" ( 0, 1) (getDirection 'l' ( 1, 0)))

test_getDirection_5 :: Test
test_getDirection_5 = TestCase (assertEqual "_" ( 1, 0) (getDirection 'd' ( 1, 0)))

test_checkOffBoard_1 :: Test
test_checkOffBoard_1 = TestCase (assertEqual "_" False (checkOffBoard 0 1 2))

test_checkOffBoard_2 :: Test
test_checkOffBoard_2 = TestCase (assertEqual "_" False (checkOffBoard 0 0 2))

test_checkOffBoard_3 :: Test
test_checkOffBoard_3 = TestCase (assertEqual "_" False (checkOffBoard 0 2 2))

test_checkOffBoard_4 :: Test
test_checkOffBoard_4 = TestCase (assertEqual "_" True (checkOffBoard 0 (-1) 2))

test_checkOffBoard_5 :: Test
test_checkOffBoard_5 = TestCase (assertEqual "_" True (checkOffBoard 0 3 2))

test_checkOnBoard_1 :: Test
test_checkOnBoard_1 = TestCase (assertEqual "_" True (checkOnBoard (4,4) (0,4)))

test_checkOnBoard_2 :: Test
test_checkOnBoard_2 = TestCase (assertEqual "_" True (checkOnBoard (4,4) (4,0)))

test_checkOnBoard_3 :: Test
test_checkOnBoard_3 = TestCase (assertEqual "_" False (checkOnBoard (4,4) ((-1),5)))

test_checkOnBoard_4 :: Test
test_checkOnBoard_4 = TestCase (assertEqual "_" False (checkOnBoard (4,4) (4,5)))

test_checkCollision_1 :: Test
test_checkCollision_1 = TestCase (assertEqual "_" True (checkCollision [(2,2),(2,3),(3,3)] (2,3)))

test_checkCollision_2 :: Test
test_checkCollision_2 = TestCase (assertEqual "_" False (checkCollision [(3,4),(4,4),(4,5)] (2,3)))

test_checkPosVacant_1 :: Test
test_checkPosVacant_1 = TestCase (assertEqual "_" False (checkPosVacant [(2,2),(2,3),(3,3)] (2,3)))

test_checkPosVacant_2 :: Test
test_checkPosVacant_2 = TestCase (assertEqual "_" True (checkPosVacant [(3,4),(4,4),(4,5)] (2,3)))

tests :: Test
tests = TestList [TestLabel "Snake" test_createNewHead_1,
                  TestLabel "Snake" test_createNewHead_2,
                  TestLabel "Snake" test_createNewTail_1,
                  TestLabel "Snake" test_createNewTail_2,
                  TestLabel "Snake" test_updateSnake,
                  TestLabel "View" test_getObjectsInRow,
                  TestLabel "View" test_createRow,
                  TestLabel "View" test_checkColumnOccupied_1,
                  TestLabel "View" test_checkColumnOccupied_2,
                  TestLabel "View" test_createBoard,
                  TestLabel "InOut" test_getDirection_1,
                  TestLabel "InOut" test_getDirection_2,
                  TestLabel "InOut" test_getDirection_3,
                  TestLabel "InOut" test_getDirection_4,
                  TestLabel "InOut" test_getDirection_5,
                  TestLabel "Interact" test_checkOffBoard_1,
                  TestLabel "Interact" test_checkOffBoard_2,
                  TestLabel "Interact" test_checkOffBoard_3,
                  TestLabel "Interact" test_checkOffBoard_4,
                  TestLabel "Interact" test_checkOffBoard_5,
                  TestLabel "Interact" test_checkOnBoard_1,
                  TestLabel "Interact" test_checkOnBoard_2,
                  TestLabel "Interact" test_checkOnBoard_3,
                  TestLabel "Interact" test_checkOnBoard_4,
                  TestLabel "Interact" test_checkCollision_1,
                  TestLabel "Interact" test_checkCollision_2,
                  TestLabel "Interact" test_checkPosVacant_1,
                  TestLabel "Interact" test_checkPosVacant_2]


main :: IO Counts
main = runTestTT tests
