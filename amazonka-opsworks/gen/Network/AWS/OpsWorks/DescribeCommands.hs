{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE OverloadedStrings #-}

-- Module      : Network.AWS.OpsWorks.DescribeCommands
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

-- | Describes the results of specified commands.
--
-- You must specify at least one of the parameters.
--
-- __Required Permissions__: To use this action, an IAM user must have a
-- Show, Deploy, or Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see
-- <http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html Managing User Permissions>.
--
-- <http://docs.aws.amazon.com/opsworks/latest/APIReference/API_DescribeCommands.html>
module Network.AWS.OpsWorks.DescribeCommands
    (
    -- * Request
      DescribeCommands
    -- ** Request constructor
    , describeCommands
    -- ** Request lenses
    , dcInstanceId
    , dcDeploymentId
    , dcCommandIds

    -- * Response
    , DescribeCommandsResponse
    -- ** Response constructor
    , describeCommandsResponse
    -- ** Response lenses
    , dcrCommands
    ) where

import Network.AWS.OpsWorks.Types
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | /See:/ 'describeCommands' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dcInstanceId'
--
-- * 'dcDeploymentId'
--
-- * 'dcCommandIds'
data DescribeCommands = DescribeCommands'{_dcInstanceId :: Maybe Text, _dcDeploymentId :: Maybe Text, _dcCommandIds :: Maybe [Text]} deriving (Eq, Read, Show)

-- | 'DescribeCommands' smart constructor.
describeCommands :: DescribeCommands
describeCommands = DescribeCommands'{_dcInstanceId = Nothing, _dcDeploymentId = Nothing, _dcCommandIds = Nothing};

-- | The instance ID. If you include this parameter, @DescribeCommands@
-- returns a description of the commands associated with the specified
-- instance.
dcInstanceId :: Lens' DescribeCommands (Maybe Text)
dcInstanceId = lens _dcInstanceId (\ s a -> s{_dcInstanceId = a});

-- | The deployment ID. If you include this parameter, @DescribeCommands@
-- returns a description of the commands associated with the specified
-- deployment.
dcDeploymentId :: Lens' DescribeCommands (Maybe Text)
dcDeploymentId = lens _dcDeploymentId (\ s a -> s{_dcDeploymentId = a});

-- | An array of command IDs. If you include this parameter,
-- @DescribeCommands@ returns a description of the specified commands.
-- Otherwise, it returns a description of every command.
dcCommandIds :: Lens' DescribeCommands [Text]
dcCommandIds = lens _dcCommandIds (\ s a -> s{_dcCommandIds = a}) . _Default;

instance AWSRequest DescribeCommands where
        type Sv DescribeCommands = OpsWorks
        type Rs DescribeCommands = DescribeCommandsResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 DescribeCommandsResponse' <$>
                   (x .?> "Commands" .!@ mempty))

instance ToHeaders DescribeCommands where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("OpsWorks_20130218.DescribeCommands" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON DescribeCommands where
        toJSON DescribeCommands'{..}
          = object
              ["InstanceId" .= _dcInstanceId,
               "DeploymentId" .= _dcDeploymentId,
               "CommandIds" .= _dcCommandIds]

instance ToPath DescribeCommands where
        toPath = const "/"

instance ToQuery DescribeCommands where
        toQuery = const mempty

-- | /See:/ 'describeCommandsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dcrCommands'
newtype DescribeCommandsResponse = DescribeCommandsResponse'{_dcrCommands :: Maybe [Command]} deriving (Eq, Read, Show)

-- | 'DescribeCommandsResponse' smart constructor.
describeCommandsResponse :: DescribeCommandsResponse
describeCommandsResponse = DescribeCommandsResponse'{_dcrCommands = Nothing};

-- | An array of @Command@ objects that describe each of the specified
-- commands.
dcrCommands :: Lens' DescribeCommandsResponse [Command]
dcrCommands = lens _dcrCommands (\ s a -> s{_dcrCommands = a}) . _Default;
