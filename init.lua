local S = minetest.get_translator("j_mute")

minetest.register_chatcommand("mute", {
   params = S("<playername>"),
   description = S("Mute a player"),
   privs = {mute = true},
   func = function(name, param)
      local playername = param
      minetest.chat_send_all(S("@1 has been muted.", playername))
      local privs = minetest.get_player_privs(playername)
      privs.shout = nil
      minetest.set_player_privs(playername, privs)
   end,
})

minetest.register_chatcommand("unmute", {
   params = S("<playername>"),
   description = S("Unmute a player"),
   privs = {mute = true},
   func = function(name, param)
      local playername = param
      minetest.chat_send_all(S("@1 has been unmuted.", playername))
      local privs = minetest.get_player_privs(playername)
      privs.shout = true
      minetest.set_player_privs(playername, privs)
   end,
})

minetest.register_chatcommand("mutesec", {
   params = S("<playername> <seconds>"),
   description = S("Temporarily mute a player"),
   privs = {mute = true},
   func = function(name, param)
      local playername = param:split(" ")[1]
      local seconds = tonumber(param:split(" ")[2])
      minetest.chat_send_all(S("@1 has been temporarily muted.", playername))
      local privs = minetest.get_player_privs(playername)
      privs.shout = nil
      minetest.set_player_privs(playername, privs)
      minetest.after(seconds, function()
         privs.shout = true
         minetest.set_player_privs(playername, privs)
         minetest.chat_send_all(S("@1 has been unmuted.", playername))
      end)
   end,
})

minetest.register_privilege("mute", S("Player can mute others."))
