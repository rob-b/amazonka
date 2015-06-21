{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.SQS.DeleteQueue
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

-- | Deletes the queue specified by the __queue URL__, regardless of whether
-- the queue is empty. If the specified queue does not exist, Amazon SQS
-- returns a successful response.
--
-- Use @DeleteQueue@ with care; once you delete your queue, any messages in
-- the queue are no longer available.
--
-- When you delete a queue, the deletion process takes up to 60 seconds.
-- Requests you send involving that queue during the 60 seconds might
-- succeed. For example, a SendMessage request might succeed, but after the
-- 60 seconds, the queue and that message you sent no longer exist. Also,
-- when you delete a queue, you must wait at least 60 seconds before
-- creating a queue with the same name.
--
-- We reserve the right to delete queues that have had no activity for more
-- than 30 days. For more information, see
-- <http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSConcepts.html How Amazon SQS Queues Work>
-- in the /Amazon SQS Developer Guide/.
--
-- <http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_DeleteQueue.html>
module Network.AWS.SQS.DeleteQueue
    (
    -- * Request
      DeleteQueue
    -- ** Request constructor
    , deleteQueue
    -- ** Request lenses
    , dqQueueURL

    -- * Response
    , DeleteQueueResponse
    -- ** Response constructor
    , deleteQueueResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response
import Network.AWS.SQS.Types

-- | /See:/ 'deleteQueue' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dqQueueURL'
newtype DeleteQueue = DeleteQueue'{_dqQueueURL :: Text} deriving (Eq, Read, Show)

-- | 'DeleteQueue' smart constructor.
deleteQueue :: Text -> DeleteQueue
deleteQueue pQueueURL = DeleteQueue'{_dqQueueURL = pQueueURL};

-- | The URL of the Amazon SQS queue to take action on.
dqQueueURL :: Lens' DeleteQueue Text
dqQueueURL = lens _dqQueueURL (\ s a -> s{_dqQueueURL = a});

instance AWSRequest DeleteQueue where
        type Sv DeleteQueue = SQS
        type Rs DeleteQueue = DeleteQueueResponse
        request = post
        response = receiveNull DeleteQueueResponse'

instance ToHeaders DeleteQueue where
        toHeaders = const mempty

instance ToPath DeleteQueue where
        toPath = const "/"

instance ToQuery DeleteQueue where
        toQuery DeleteQueue'{..}
          = mconcat
              ["Action" =: ("DeleteQueue" :: ByteString),
               "Version" =: ("2012-11-05" :: ByteString),
               "QueueUrl" =: _dqQueueURL]

-- | /See:/ 'deleteQueueResponse' smart constructor.
data DeleteQueueResponse = DeleteQueueResponse' deriving (Eq, Read, Show)

-- | 'DeleteQueueResponse' smart constructor.
deleteQueueResponse :: DeleteQueueResponse
deleteQueueResponse = DeleteQueueResponse';
