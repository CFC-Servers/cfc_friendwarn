# CFC FriendWarn
Warns staff when a player joins who is friends with a banned player.

![NVIDIA_Share_5kHJQ9Pssn](https://user-images.githubusercontent.com/7936439/142822592-d5862ea2-d98d-4371-a8ab-25f5772a123c.png)


## Requirements
 - [GM Steam Lookup](https://github.com/cfc-Servers/gm_steam_lookup)

## Installation
Simply download a copy of the zip, or clone the repository straight into your addons folder!

### Download
The latest pre-compiled versions are available in **[Releases](https://github.com/CFC-Servers/cfc_friendwarn/releases/)**

### Git Clone
Because this project uses Moonscript, keeping it updated via `git` is _slightly_ more involved.

The [`lua` branch](https://github.com/CFC-Servers/cfc_friendwarn/tree/lua) is a lua-only branch containing the compiled code from the most recent release. You can use this branch to keep `cfc_friendwarn` up to date.
```sh
git clone --single-branch --branch lua git@github.com:CFC-Servers/cfc_friendwarn.git
```

## Usage
Be sure to set your Steam API Key on the first startup:
```
cfc_steam_api_key "<api key here>"
```

After that, it just works!
