module Database.PostgreSQL.Pool
  ( defaultConfiguration
  , Database
  , idleCount
  , new
  , Configuration
  , parseURI
  , PGConnectionURI
  , Pool
  , totalCount
  , waitingCount
  )
  where

import Prelude

import Data.Either (hush)
import Data.Int (fromString)
import Data.Tuple (Tuple(..))
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Nullable (Nullable, toNullable, toMaybe)
import Data.String as String
import Data.String.CodeUnits (singleton)
import Data.Traversable (foldMap)
import Effect (Effect)
import Node.URL as URL

-- | PostgreSQL connection pool.
foreign import data Pool :: Type

type Database
  = String

-- | Configuration which we actually pass to FFI.
type Configuration'
  = { user :: Nullable String
    , password :: Nullable String
    , host :: Nullable String
    , port :: Nullable Int
    , database :: String
    , max :: Nullable Int
    , idleTimeoutMillis :: Nullable Int
    }

-- | PostgreSQL connection pool configuration.
type Configuration
  = { database :: Database
    , host :: Maybe String
    , idleTimeoutMillis :: Maybe Int
    , max :: Maybe Int
    , password :: Maybe String
    , port :: Maybe Int
    , user :: Maybe String
    }

type PGConnectionURI
  = String

-- | Get the default pool configuration from postgres connection uri
-- | TODO:
-- | * Do we really want to keep parsing dependency to handle config string?
-- | * In such a case we should improve parsing (validate port etc.)
parseURI :: PGConnectionURI -> Maybe Configuration
parseURI uri = do
  path <- toMaybe pathname
  let database = String.drop 1 path
  pure
    { database
    , host: toMaybe hostname
    , idleTimeoutMillis: Nothing
    , max: Nothing
    , password: passwordM
    , port: bind (toMaybe port) fromString
    , user: userM
    }
  where
  {auth, hostname, port, pathname} = URL.parse uri
  authParts = String.split (String.Pattern ":") $ fromMaybe "" $ toMaybe auth
  Tuple userM passwordM = case authParts of
                            [user] -> Tuple (Just user) Nothing
                            [user, password] -> Tuple (Just user) (Just password)
                            _ -> Tuple Nothing Nothing



defaultConfiguration :: Database -> Configuration
defaultConfiguration database =
  { database
  , host: Nothing
  , idleTimeoutMillis: Nothing
  , max: Nothing
  , password: Nothing
  , port: Nothing
  , user: Nothing
  }

foreign import ffiNew ::
  Configuration' ->
  Effect Pool

-- | Create a new connection pool.
new :: Configuration -> Effect Pool
new cfg = ffiNew $ cfg'
  where
  cfg' =
    { user: toNullable cfg.user
    , password: toNullable cfg.password
    , host: toNullable cfg.host
    , port: toNullable cfg.port
    , database: cfg.database
    , max: toNullable cfg.max
    , idleTimeoutMillis: toNullable cfg.idleTimeoutMillis
    }

foreign import totalCount :: Pool -> Effect Int

foreign import idleCount :: Pool -> Effect Int

foreign import waitingCount :: Pool -> Effect Int
