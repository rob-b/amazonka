{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.S3.V2006_03_01.CreateBucket
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Creates a new bucket.
module Network.AWS.S3.V2006_03_01.CreateBucket where

import           Control.Applicative
import           Data.ByteString     (ByteString)
import           Data.Default
import           Data.HashMap.Strict (HashMap)
import           Data.Maybe
import           Data.Monoid
import           Data.Text           (Text)
import qualified Data.Text           as Text
import           GHC.Generics
import           Network.AWS.Data
import           Network.AWS.Response
import           Network.AWS.Request.RestS3
import           Network.AWS.Types   hiding (Error)
import           Network.AWS.S3.V2006_03_01.Types
import           Prelude             hiding (head)

type PutBucket = CreateBucket
type PutBucketResponse = Rs CreateBucket

-- | Default CreateBucket request.
createBucket :: BucketName -- ^ 'cbrBucket'
             -> CreateBucketConfiguration -- ^ 'cbrCreateBucketConfiguration'
             -> CreateBucket
createBucket p1 p2 = CreateBucket
    { cbrBucket = p1
    , cbrCreateBucketConfiguration = p2
    , cbrACL = Nothing
    , cbrGrantFullControl = Nothing
    , cbrGrantRead = Nothing
    , cbrGrantReadACP = Nothing
    , cbrGrantWrite = Nothing
    , cbrGrantWriteACP = Nothing
    }

data CreateBucket = CreateBucket
    { cbrBucket :: BucketName
    , cbrCreateBucketConfiguration :: CreateBucketConfiguration
    , cbrACL :: Maybe BucketCannedACL
      -- ^ The canned ACL to apply to the bucket.
    , cbrGrantFullControl :: Maybe Text
      -- ^ Allows grantee the read, write, read ACP, and write ACP
      -- permissions on the bucket.
    , cbrGrantRead :: Maybe Text
      -- ^ Allows grantee to list the objects in the bucket.
    , cbrGrantReadACP :: Maybe Text
      -- ^ Allows grantee to read the bucket ACL.
    , cbrGrantWrite :: Maybe Text
      -- ^ Allows grantee to create, overwrite, and delete any object in the
      -- bucket.
    , cbrGrantWriteACP :: Maybe Text
      -- ^ Allows grantee to write the ACL for the applicable bucket.
    } deriving (Eq, Show, Generic)

instance ToPath CreateBucket where
    toPath CreateBucket{..} = mconcat
        [ "/"
        , toBS cbrBucket
        ]

instance ToQuery CreateBucket

instance ToHeaders CreateBucket where
    toHeaders CreateBucket{..} = concat
        [ "x-amz-acl" =: cbrACL
        , "x-amz-grant-full-control" =: cbrGrantFullControl
        , "x-amz-grant-read" =: cbrGrantRead
        , "x-amz-grant-read-acp" =: cbrGrantReadACP
        , "x-amz-grant-write" =: cbrGrantWrite
        , "x-amz-grant-write-acp" =: cbrGrantWriteACP
        ]

instance ToBody CreateBucket where
    toBody = undefined -- toBody . cbrCreateBucketConfiguration

instance AWSRequest CreateBucket where
    type Sv CreateBucket = S3

    request  = put
    response = headerResponse $ \hs ->
        pure CreateBucketResponse
            <*> hs ~:? "Location"

data instance Rs CreateBucket = CreateBucketResponse
    { cboLocation :: Maybe Text
    } deriving (Eq, Show, Generic)
