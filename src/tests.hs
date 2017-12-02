import Test.HUnit
import Snake (create_all_rows)

test1 :: Test
test1 = TestCase (assertEqual "create_all_rows" ["...","..."] (create_all_rows [] 2 3))

tests :: Test
tests = TestList [TestLabel "test1" test1]

main :: IO Counts
main = runTestTT tests