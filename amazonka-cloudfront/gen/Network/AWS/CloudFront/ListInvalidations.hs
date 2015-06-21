{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.CloudFront.ListInvalidations
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

-- | List invalidation batches.
--
-- <http://docs.aws.amazon.com/AmazonCloudFront/latest/APIReference/ListInvalidations.html>
module Network.AWS.CloudFront.ListInvalidations
    (
    -- * Request
      ListInvalidations
    -- ** Request constructor
    , listInvalidations
    -- ** Request lenses
    , liMaxItems
    , liMarker
    , liDistributionId

    -- * Response
    , ListInvalidationsResponse
    -- ** Response constructor
    , listInvalidationsResponse
    -- ** Response lenses
    , lirInvalidationList
    ) where

import Network.AWS.CloudFront.Types
import Network.AWS.Pagers
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | /See:/ 'listInvalidations' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'liMaxItems'
--
-- * 'liMarker'
--
-- * 'liDistributionId'
data ListInvalidations = ListInvalidations'{_liMaxItems :: Maybe Text, _liMarker :: Maybe Text, _liDistributionId :: Text} deriving (Eq, Read, Show)

-- | 'ListInvalidations' smart constructor.
listInvalidations :: Text -> ListInvalidations
listInvalidations pDistributionId = ListInvalidations'{_liMaxItems = Nothing, _liMarker = Nothing, _liDistributionId = pDistributionId};

-- | The maximum number of invalidation batches you want in the response
-- body.
liMaxItems :: Lens' ListInvalidations (Maybe Text)
liMaxItems = lens _liMaxItems (\ s a -> s{_liMaxItems = a});

-- | Use this parameter when paginating results to indicate where to begin in
-- your list of invalidation batches. Because the results are returned in
-- decreasing order from most recent to oldest, the most recent results are
-- on the first page, the second page will contain earlier results, and so
-- on. To get the next page of results, set the Marker to the value of the
-- NextMarker from the current page\'s response. This value is the same as
-- the ID of the last invalidation batch on that page.
liMarker :: Lens' ListInvalidations (Maybe Text)
liMarker = lens _liMarker (\ s a -> s{_liMarker = a});

-- | The distribution\'s id.
liDistributionId :: Lens' ListInvalidations Text
liDistributionId = lens _liDistributionId (\ s a -> s{_liDistributionId = a});

instance AWSPager ListInvalidations where
        page rq rs
          | stop (rs ^. lirInvalidationList . ilIsTruncated) =
            Nothing
          | otherwise =
            Just $
              rq &
                liMarker .~ rs ^. lirInvalidationList . ilNextMarker

instance AWSRequest ListInvalidations where
        type Sv ListInvalidations = CloudFront
        type Rs ListInvalidations = ListInvalidationsResponse
        request = get
        response
          = receiveXML
              (\ s h x ->
                 ListInvalidationsResponse' <$>
                   (x .@ "InvalidationList"))

instance ToHeaders ListInvalidations where
        toHeaders = const mempty

instance ToPath ListInvalidations where
        toPath ListInvalidations'{..}
          = mconcat
              ["/2014-11-06/distribution/",
               toText _liDistributionId, "/invalidation"]

instance ToQuery ListInvalidations where
        toQuery ListInvalidations'{..}
          = mconcat
              ["MaxItems" =: _liMaxItems, "Marker" =: _liMarker]

-- | /See:/ 'listInvalidationsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lirInvalidationList'
newtype ListInvalidationsResponse = ListInvalidationsResponse'{_lirInvalidationList :: InvalidationList} deriving (Eq, Read, Show)

-- | 'ListInvalidationsResponse' smart constructor.
listInvalidationsResponse :: InvalidationList -> ListInvalidationsResponse
listInvalidationsResponse pInvalidationList = ListInvalidationsResponse'{_lirInvalidationList = pInvalidationList};

-- | Information about invalidation batches.
lirInvalidationList :: Lens' ListInvalidationsResponse InvalidationList
lirInvalidationList = lens _lirInvalidationList (\ s a -> s{_lirInvalidationList = a});
