import Count from table

WHITE = Color 250, 250, 250
GREY = Color 175, 175, 175
YELLOW = Color 240, 240, 0
RED = Color 240, 0, 0

fmtBanTime = (ban) -> ULib.secondsToStringTime ban.unban - ban.time
fmtBanRemaining = (ban) -> ULib.secondsToStringTime ban.unban - os.time!

printBanToConsole = (steamId, ban) ->
    banTime = fmtBanTime ban
    remaining = fmtBanRemaining ban

    MsgC WHITE, "'", YELLOW, ban.name, WHITE, "' ", GREY, "(", RED, steamId, GREY, ")", WHITE, ":", "\n"
    MsgC WHITE, "  Reason: ", YELLOW, ban.reason, "\n"
    MsgC WHITE, "  Length: ", YELLOW, banTime, "\n"
    MsgC WHITE, "  Remaining: ", YELLOW, remaining, "\n\n"

net.Receive "CFC_FriendWarn_BannedFriends", ->
    ply = net.ReadEntity!
    bans = net.ReadTable!
    count = Count bans

    players = count > 1 and "players" or "player"
    chat.AddText YELLOW, "===== Player is friends with #{count} banned #{players} ====="
    chat.AddText YELLOW, ply\Nick!, GREY, " (", RED, ply\SteamID!, GREY, ")"
    chat.AddText GREY, "Check your console for more details"

    MsgC "\nThe player is friends with the following banned players:\n\n"
    printBanToConsole(k, v) for k, v in pairs bans
