{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.SQS.PurgeQueue
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | Deletes the messages in a queue specified by the __queue URL__.
--
-- When you use the @PurgeQueue@ API, the deleted messages in the queue
-- cannot be retrieved.
--
-- When you purge a queue, the message deletion process takes up to 60
-- seconds. All messages sent to the queue before calling @PurgeQueue@ will
-- be deleted; messages sent to the queue while it is being purged may be
-- deleted. While the queue is being purged, messages sent to the queue
-- before @PurgeQueue@ was called may be received, but will be deleted
-- within the next minute.
--
-- <http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_PurgeQueue.html>
module Network.AWS.SQS.PurgeQueue
    (
    -- * Request
      PurgeQueue
    -- ** Request constructor
    , purgeQueue
    -- ** Request lenses
    , pqQueueURL

    -- * Response
    , PurgeQueueResponse
    -- ** Response constructor
    , purgeQueueResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response
import Network.AWS.SQS.Types

-- | /See:/ 'purgeQueue' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'pqQueueURL'
newtype PurgeQueue = PurgeQueue'{_pqQueueURL :: Text} deriving (Eq, Read, Show)

-- | 'PurgeQueue' smart constructor.
purgeQueue :: Text -> PurgeQueue
purgeQueue pQueueURL = PurgeQueue'{_pqQueueURL = pQueueURL};

-- | The queue URL of the queue to delete the messages from when using the
-- @PurgeQueue@ API.
pqQueueURL :: Lens' PurgeQueue Text
pqQueueURL = lens _pqQueueURL (\ s a -> s{_pqQueueURL = a});

instance AWSRequest PurgeQueue where
        type Sv PurgeQueue = SQS
        type Rs PurgeQueue = PurgeQueueResponse
        request = post
        response = receiveNull PurgeQueueResponse'

instance ToHeaders PurgeQueue where
        toHeaders = const mempty

instance ToPath PurgeQueue where
        toPath = const "/"

instance ToQuery PurgeQueue where
        toQuery PurgeQueue'{..}
          = mconcat
              ["Action" =: ("PurgeQueue" :: ByteString),
               "Version" =: ("2012-11-05" :: ByteString),
               "QueueUrl" =: _pqQueueURL]

-- | /See:/ 'purgeQueueResponse' smart constructor.
data PurgeQueueResponse = PurgeQueueResponse' deriving (Eq, Read, Show)

-- | 'PurgeQueueResponse' smart constructor.
purgeQueueResponse :: PurgeQueueResponse
purgeQueueResponse = PurgeQueueResponse';
