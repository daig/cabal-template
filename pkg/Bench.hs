import Criterion.Main

main = defaultMain
  [bgroup "main"
    [env (pure $ replicate @Int 1000 1) $ \ ~small -> bgroup "small"
      [bench "length" $ whnf length small
      ,bench "length . filter" $ whnf (length . filter (==1)) small
      ]
    ,env (map length . words <$> readFile "/usr/share/dict/words") $ \ ~big -> bgroup "big"
      [bench "length" $ whnf length big
      ,bench "length . filter" $ whnf (length . filter (==1)) big
      ]
    ]
  ]
