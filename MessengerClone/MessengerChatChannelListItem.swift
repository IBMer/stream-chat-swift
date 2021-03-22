import StreamChat
import StreamChatUI
import SwiftUI

struct MessengerChatChannelListItem: ChatChannelListItemView.SwiftUIView {
    @ObservedObject var dataSource: ChatChannelListItemView.ObservedObject<Self>
    init(dataSource: _ChatChannelListItemView<NoExtraData>.ObservedObject<MessengerChatChannelListItem>) {
        self.dataSource = dataSource
    }
    
    typealias ExtraData = NoExtraData
    
    var body: some View {
        HStack {
            ImageView(url: imageURL())
                .frame(width: 50, height: 50)
            if
                let channel = dataSource.content.channel,
                let currentUserId = dataSource.content.currentUserId,
                let channelName = UIConfig.default.channelList.channelNamer(channel, currentUserId) {
                Text(channelName)
            }
            
            Spacer()
        }
        .padding()
    }

    private func imageURL() -> URL? {
        guard let channel = dataSource.content.channel else { return nil }
        if let avatarURL = channel.imageURL {
            return avatarURL
        }

        let firstOtherMember = channel.cachedMembers
            .sorted { $0.memberCreatedAt < $1.memberCreatedAt }
            .first(where: { $0.id != dataSource.content.currentUserId })

        return firstOtherMember?.imageURL
    }
}
