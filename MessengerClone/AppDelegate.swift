//
//  AppDelegate.swift
//  MessengerClone
//

import UIKit
import StreamChat
import StreamChatUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIConfig.default.channelList.itemView = ChatChannelListItemView.SwiftUIWrapper<MessengerChatChannelListItem>.self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

extension ChatClient {
    /// The singleton instance of `ChatClient`
    static let shared: ChatClient = {
        let config = ChatClientConfig(apiKey: APIKey("q95x9hkbyd6p"))
        return ChatClient(config: config, tokenProvider: .static("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiY2lsdmlhIn0.jHi2vjKoF02P9lOog0kDVhsIrGFjuWJqZelX5capR30"))
    }()
}
