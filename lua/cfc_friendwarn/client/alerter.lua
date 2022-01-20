local Count
Count = table.Count
local WHITE = Color(250, 250, 250)
local GREY = Color(175, 175, 175)
local YELLOW = Color(240, 240, 0)
local RED = Color(240, 0, 0)
local fmtBanTime
fmtBanTime = function(ban)
  return ULib.secondsToStringTime(ban.unban - ban.time)
end
local fmtBanRemaining
fmtBanRemaining = function(ban)
  return ULib.secondsToStringTime(ban.unban - os.time())
end
local printBanToConsole
printBanToConsole = function(steamId, ban)
  local banTime = fmtBanTime(ban)
  local remaining = fmtBanRemaining(ban)
  MsgC(WHITE, "'", YELLOW, ban.name, WHITE, "' ", GREY, "(", RED, steamId, GREY, ")", WHITE, ":", "\n")
  MsgC(WHITE, "  Reason: ", YELLOW, ban.reason, "\n")
  MsgC(WHITE, "  Length: ", YELLOW, banTime, "\n")
  return MsgC(WHITE, "  Remaining: ", YELLOW, remaining, "\n\n")
end
return net.Receive("CFC_FriendWarn_BannedFriends", function()
  local ply = net.ReadEntity()
  local bans = net.ReadTable()
  local count = Count(bans)
  local players = count > 1 and "players" or "player"
  chat.AddText(YELLOW, "===== Player is friends with " .. tostring(count) .. " banned " .. tostring(players) .. " =====")
  chat.AddText(YELLOW, ply:Nick(), GREY, " (", RED, ply:SteamID(), GREY, ")")
  chat.AddText(GREY, "Check your console for more details")
  MsgC("\nThe player is friends with the following banned players:\n\n")
  for k, v in pairs(bans) do
    printBanToConsole(k, v)
  end
end)
