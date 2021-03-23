//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

@testable import StreamChat
import XCTest

class TeamDTO_Tests: XCTestCase {
    var database: DatabaseContainerMock!

    override func setUp() {
        super.setUp()
        database = try! DatabaseContainerMock(kind: .inMemory)
    }

    override func tearDown() {
        AssertAsync.canBeReleased(&database)
        super.tearDown()
    }

    func test_teamsForUser_areStoredAndLoadedFromDB() {
        let teamIds: [TeamId] = [.unique, .unique, .unique]
        let userId: UserId = .unique

        let payload: UserPayload<NoExtraData> = .dummy(userId: userId, teams: teamIds)

        // Asynchronously save the user payload to the db, which should save teams for user as well.
        try! database.writeSynchronously { session in
            try! session.saveUser(payload: payload)
        }

        // Load the user from the db and check the fields are correct
        var loadedUserDTO: UserDTO? {
            database.viewContext.user(id: userId)
        }

        XCTAssertEqual(payload.teams.count, loadedUserDTO?.teams?.count)
        XCTAssertEqual(loadedUserDTO?.teams?.first?.users.first, loadedUserDTO)
    }

    func test_teamForChannel_isStoredAndLoadedFromDB() {
        let teamId: TeamId = .unique
        let channelId: ChannelId = .unique

        let channelDetailPayload: ChannelDetailPayload<NoExtraData> = .dummy(cid: channelId, teamId: teamId)

        // Asynchronously save the channel payload to the db, which should save the team for the channel as well.
        try! database.writeSynchronously { session in
            try! session.saveChannel(payload: channelDetailPayload, query: nil)
        }

        // Load the channel from the db and check the team is correct
        var loadedChannelDTO: ChannelDTO? {
            database.viewContext.channel(cid: channelId)
        }

        XCTAssertEqual(channelDetailPayload.team, loadedChannelDTO?.team?.id)
        XCTAssertEqual(loadedChannelDTO?.team?.channels.first, loadedChannelDTO)
    }
}
