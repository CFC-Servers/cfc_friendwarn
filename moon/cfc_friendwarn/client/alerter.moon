import Count from table

WHITE = Color 220, 220, 220
GREY = Color 180, 180, 180
YELLOW = Color 180, 180, 0
RED = Color 180, 0, 0

fmtBanTime = (ban) -> ULib.secondsToStringTime ban.unban - ban.time
fmtBanRemaining = (ban) -> ULib.secondsToStringTime os.time! - ban.unban

printBanToConsole = (steamId, ban) ->
    banTime = fmtBanTime ban
    remaining = fmtBanRemaining ban

    MsgC WHITE, "['", YELLOW, ban.name, WHITE, "' ", GREY, "(", RED, steamId, GREY, ")", WHITE, "]\n"
    MsgC WHITE, "  Reason: ", YELLOW, ban.reason, "\n"
    MsgC WHITE, "  Length: ", YELLOW, banTime, "\n"
    MsgC WHITE, "  Remaining: ", YELLOW, remaining, "\n"

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
