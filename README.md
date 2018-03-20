This repo exhibits a program which benefits from the `-flate-specialise` pass
which was added in https://phabricator.haskell.org/D4457.

# Compiling

```
nix-shell
cabal configure
cabal build
# Run executable
cabal configure -flate-spec
cabal build
```

```
cabal new-build
time <the executable>
cabal new-build -flate-spec
time <the executable>
```

On my machine, the results are..

```
time benchmarks
()
real	0m0.112s
```

With plugin (comparable to hand-written code)

```
time benchmarks
()
real	0m0.049s
```

