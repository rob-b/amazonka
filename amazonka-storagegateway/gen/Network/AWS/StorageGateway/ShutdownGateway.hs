{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.StorageGateway.ShutdownGateway
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

-- | This operation shuts down a gateway. To specify which gateway to shut
-- down, use the Amazon Resource Name (ARN) of the gateway in the body of
-- your request.
--
-- The operation shuts down the gateway service component running in the
-- storage gateway\'s virtual machine (VM) and not the VM.
--
-- If you want to shut down the VM, it is recommended that you first shut
-- down the gateway component in the VM to avoid unpredictable conditions.
--
-- After the gateway is shutdown, you cannot call any other API except
-- StartGateway, DescribeGatewayInformation, and ListGateways. For more
-- information, see ActivateGateway. Your applications cannot read from or
-- write to the gateway\'s storage volumes, and there are no snapshots
-- taken.
--
-- When you make a shutdown request, you will get a @200 OK@ success
-- response immediately. However, it might take some time for the gateway
-- to shut down. You can call the DescribeGatewayInformation API to check
-- the status. For more information, see ActivateGateway.
--
-- If do not intend to use the gateway again, you must delete the gateway
-- (using DeleteGateway) to no longer pay software charges associated with
-- the gateway.
--
-- <http://docs.aws.amazon.com/storagegateway/latest/APIReference/API_ShutdownGateway.html>
module Network.AWS.StorageGateway.ShutdownGateway
    (
    -- * Request
      ShutdownGateway
    -- ** Request constructor
    , shutdownGateway
    -- ** Request lenses
    , shuGatewayARN

    -- * Response
    , ShutdownGatewayResponse
    -- ** Response constructor
    , shutdownGatewayResponse
    -- ** Response lenses
    , sgrGatewayARN
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response
import Network.AWS.StorageGateway.Types

-- | /See:/ 'shutdownGateway' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'shuGatewayARN'
newtype ShutdownGateway = ShutdownGateway'{_shuGatewayARN :: Text} deriving (Eq, Read, Show)

-- | 'ShutdownGateway' smart constructor.
shutdownGateway :: Text -> ShutdownGateway
shutdownGateway pGatewayARN = ShutdownGateway'{_shuGatewayARN = pGatewayARN};

-- | FIXME: Undocumented member.
shuGatewayARN :: Lens' ShutdownGateway Text
shuGatewayARN = lens _shuGatewayARN (\ s a -> s{_shuGatewayARN = a});

instance AWSRequest ShutdownGateway where
        type Sv ShutdownGateway = StorageGateway
        type Rs ShutdownGateway = ShutdownGatewayResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ShutdownGatewayResponse' <$> (x .?> "GatewayARN"))

instance ToHeaders ShutdownGateway where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("StorageGateway_20130630.ShutdownGateway" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ShutdownGateway where
        toJSON ShutdownGateway'{..}
          = object ["GatewayARN" .= _shuGatewayARN]

instance ToPath ShutdownGateway where
        toPath = const "/"

instance ToQuery ShutdownGateway where
        toQuery = const mempty

-- | /See:/ 'shutdownGatewayResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'sgrGatewayARN'
newtype ShutdownGatewayResponse = ShutdownGatewayResponse'{_sgrGatewayARN :: Maybe Text} deriving (Eq, Read, Show)

-- | 'ShutdownGatewayResponse' smart constructor.
shutdownGatewayResponse :: ShutdownGatewayResponse
shutdownGatewayResponse = ShutdownGatewayResponse'{_sgrGatewayARN = Nothing};

-- | FIXME: Undocumented member.
sgrGatewayARN :: Lens' ShutdownGatewayResponse (Maybe Text)
sgrGatewayARN = lens _sgrGatewayARN (\ s a -> s{_sgrGatewayARN = a});
