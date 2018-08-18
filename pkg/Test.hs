import Test.Tasty

import Test.Tasty.HUnit

import Test.Tasty.Hedgehog
import Hedgehog
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range

main = defaultMain tests

tests :: TestTree
tests = testGroup "All Tests"
      [ testGroup "HUnit"
        [ testCase "2+2=4" $ 2+2 @?= 4
        , testCase "7 is even" $ assertBool "Oops, 7 is odd" (even 7)]

      , testGroup "HedgeHog"
        [ testProperty "reverse involutive" . property $ do
              xs <- forAll $ Gen.list (Range.linear 0 100) Gen.alpha
              reverse (reverse xs) === xs
        , testProperty "0..100 all even" . property $ do
              n <- forAll $ Gen.int (Range.linear 0 100)
              Hedgehog.assert (even n)
        ]
      ]
