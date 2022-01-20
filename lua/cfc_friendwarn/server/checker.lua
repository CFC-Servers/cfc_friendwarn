local SteamIDFrom64
SteamIDFrom64 = util.SteamIDFrom64
util.AddNetworkString("CFC_FriendWarn_BannedFriends")
local shouldAlert = {
  sentinel = true,
  moderator = true,
  admin = true,
  superadmin = true,
  owner = true,
  director = true
}
FriendChecker = {
  getPlayersToAlert = function(self)
    local _accum_0 = { }
    local _len_0 = 1
    local _list_0 = player.GetAll()
    for _index_0 = 1, #_list_0 do
      local ply = _list_0[_index_0]
      if shouldAlert[ply:GetUserGroup()] then
        _accum_0[_len_0] = ply
        _len_0 = _len_0 + 1
      end
    end
    return _accum_0
  end,
  extractBanInfo = function(self, ban)
    return {
      name = ban.name,
      reason = ban.reason,
      time = ban.time,
      unban = ban.unban
    }
  end,
  handleBannedFriends = function(self, ply, bannedFriends)
    net.Start("CFC_FriendWarn_BannedFriends")
    net.WriteEntity(ply)
    net.WriteTable(bannedFriends)
    return net.Send(self:getPlayersToAlert())
  end,
  check = function(self, ply, friends)
    local bannedFriends = { }
    for _index_0 = 1, #friends do
      local _continue_0 = false
      repeat
        local friend = friends[_index_0]
        local steamId = SteamIDFrom64(friend.steamid)
        local ban = ULib.bans[steamId]
        if not (ban) then
          _continue_0 = true
          break
        end
        bannedFriends[steamId] = self:extractBanInfo(ban)
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    if not (#bannedFriends > 0) then
      return 
    end
    return self:handleBannedFriends(ply, bannedFriends)
  end
}
