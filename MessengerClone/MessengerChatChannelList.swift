//
//  Created by Marek Fořt on 08.03.2021.
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import SwiftUI
import StreamChat
import StreamChatUI

struct MessengerChatChannelList: View {
    var body: some View {
        NavigationView {
            ChatChannelList(
                controller: ChatClient
                    .shared
                    .channelListController(
                        query: ChannelListQuery(
                            filter: .containMembers(
                                userIds: [ChatClient.shared.currentUserId!]
                            )
                        )
                    )
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Chat")
        }
    }
}
