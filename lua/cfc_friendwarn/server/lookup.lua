require("steamlookup")
local name = "PlayerFriends"
local route = "ISteamUser/GetFriendList/v1"
local getUrl
getUrl = function(s)
  return {
    steamid = s
  }
end
local lookup = SteamLookup(name, route, getUrl)
SteamCheckQueue:addLookup(lookup)
return hook.Add("CFC_SteamLookup_SuccessfulPlayerData", "HandlePlayerFriends", function(stepName, ply, data)
  if not (stepName == name) then
    return 
  end
  if not (data and data.friendslist) then
    return 
  end
  local friends = data.friendslist.friends
  return FriendChecker:check(ply, friends)
end)
