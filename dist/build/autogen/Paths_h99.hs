module Paths_h99 (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [1,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/serega/.cabal/bin"
libdir     = "/home/serega/.cabal/lib/x86_64-linux-ghc-7.6.3/h99-1.0"
datadir    = "/home/serega/.cabal/share/x86_64-linux-ghc-7.6.3/h99-1.0"
libexecdir = "/home/serega/.cabal/libexec"
sysconfdir = "/home/serega/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "h99_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "h99_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "h99_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "h99_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "h99_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
