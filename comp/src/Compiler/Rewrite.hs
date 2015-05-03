{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections     #-}

-- Module      : Compiler.Rewrite
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

module Compiler.Rewrite where

import           Compiler.AST
import           Compiler.Rewrite.Default
import           Compiler.Rewrite.Override
import           Compiler.Rewrite.Prefix
import           Compiler.Rewrite.Subst
import           Compiler.Rewrite.TypeOf
import           Compiler.Types
import           Control.Error
import           Control.Lens
import           Control.Monad
import           Data.Functor.Identity
import qualified Data.HashMap.Strict       as Map
import qualified Data.HashSet              as Set
import           Data.List                 (sort)
import           Data.Monoid
import           Data.Text                 (Text)
import qualified Data.Text.Lazy            as LText

-- FIXME:
-- Constraint solving
-- Add a rename step which renames the acronyms in enums/structs
-- to the correct casing.

createLibrary :: Monad m
              => Versions
              -> Config
              -> Service Maybe Ref Shape
              -> EitherT LazyText m Library
createLibrary v x y = do
    ps     <- prefixes (y ^. shapes)
    (c, s) <- do
        let (c, s) = substitute x y
        (c,) <$> (defaulted (override c s) >>= typed ps)

    let ns     = NS ["Network", "AWS", s ^. serviceAbbrev]
        other  = c ^. operationImports ++ c ^. typeImports
        expose = ns
               : ns <> "Types"
               : ns <> "Waiters"
               : map (mappend ns . textToNS)
                     (s ^.. operations . ifolded . asIndex)

    return $! Library v c s ns
        (sort expose)
        (sort other)
