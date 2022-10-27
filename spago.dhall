{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "postgresql-client"
, license = "BSD-3-Clause"
, dependencies =
  [ "aff"
  , "argonaut"
  , "arrays"
  , "assert"
  , "bifunctors"
  , "datetime"
  , "decimals"
  , "dotenv"
  , "effect"
  , "either"
  , "enums"
  , "exceptions"
  , "foldable-traversable"
  , "foreign"
  , "foreign-object"
  , "identity"
  , "integers"
  , "js-date"
  , "lists"
  , "maybe"
  , "newtype"
  , "node-process"
  , "node-url"
  , "nullable"
  , "numbers"
  , "ordered-collections"
  , "partial"
  , "prelude"
  , "psci-support"
  , "string-parsers"
  , "strings"
  , "test-unit"
  , "transformers"
  , "tuples"
  , "typelevel-prelude"
  , "validation"
  ]
, packages = ./packages.dhall
, repository = "https://github.com/rightfold/purescript-postgresql-client.git"
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
