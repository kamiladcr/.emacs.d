(utils-install-packages '(
                          haskell-mode
                          tidal
                          ))

(setq tidal-interpreter "ghci -package tidal")
(setq tidal-boot-script-path "/nix/store/45qpy1vdgijq6hrsfwf3bn8ppzizaghn-tidal-1.4.8-data/share/ghc-8.8.3/x86_64-linux-ghc-8.8.3/tidal-1.4.8/BootTidal.hs")

(provide 'tidal-layer)
