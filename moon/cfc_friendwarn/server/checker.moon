import SteamIDFrom64 from util
util.AddNetworkString "CFC_FriendWarn_BannedFriends"

shouldAlert = {
    sentinel: true
    moderator: true
    admin: true
    superadmin: true
    owner: true
    director: true
}

export FriendChecker = {
    getPlayersToAlert: =>
        [ply for ply in *player.GetAll! when shouldAlert[ply\GetUserGroup!]]

    extractBanInfo: (ban) => {
        name: ban.name
        reason: ban.reason
        time: ban.time
        unban: ban.unban
    }

    handleBannedFriends: (ply, bannedFriends) =>
        net.Start "CFC_FriendWarn_BannedFriends"
        net.WriteEntity ply
        net.WriteTable bannedFriends
        net.Send @getPlayersToAlert!

    check: (ply, friends) =>
        bannedFriends = {}

        for friend in *friends
            steamId = SteamIDFrom64 friend.steamid

            ban = ULib.bans[steamId]
            continue unless ban

            bannedFriends[steamId] = @extractBanInfo ban

        return unless #bannedFriends > 0

        @handleBannedFriends ply, bannedFriends
}
