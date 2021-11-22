require "cfc_steamlookup"

name = "PlayerFriends"
route = "ISteamUser/GetFriendList/v1"
getUrl = (s) -> {steamid: s}

lookup = SteamLookup name, route, getUrl
SteamCheckQueue\addLookup lookup

hook.Add "CFC_SteamLookup_SuccessfulPlayerData", "HandlePlayerFriends", (stepName, ply, data) ->
    return unless stepName == name

    friends = data.friendslist.friends
    FriendChecker\check ply, friends
