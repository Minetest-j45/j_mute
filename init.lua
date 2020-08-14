minetest.register_chatcommand("mute", {
   params = "<playername>",
   description = "Mute a player",
   privs = {mute = true},
   func = function(name, param)
      local playername = param
      minetest.chat_send_all(playername .. " has been muted.")
      local privs = minetest.get_player_privs(playername)
      privs.shout = nil
      minetest.set_player_privs(playername, privs)
   end,
})

minetest.register_chatcommand("unmute", {
   params = "<playername>",
   description = "Unmute a player",
   privs = {mute = true},
   func = function(name, param)
      local playername = param
      minetest.chat_send_all(playername .. " has been unmuted.")
      local privs = minetest.get_player_privs(playername)
      privs.shout = true
      minetest.set_player_privs(playername, privs)
   end,
})

minetest.register_chatcommand("mutesec", {
   params = "<playername> <seconds>",
   description = "Temporarily mute a player",
   privs = {mute = true},
   func = function(name, param)
      local playername = param:split(" ")[1]
      local seconds = tonumber(param:split(" ")[2])
      minetest.chat_send_all(playername .. " has been temporarily muted.")
      local privs = minetest.get_player_privs(playername)
      privs.shout = nil
      minetest.set_player_privs(playername, privs)
      minetest.after(seconds, function()
         privs.shout = true
         minetest.set_player_privs(playername, privs)
         minetest.chat_send_all(playername .. " has been unmuted.")
      end)
   end,
})

minetest.register_privilege("mute", "Player can mute others.")
