pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
#include main.lua
#include player.lua
#include paddles.lua
#include particles.lua
#include saws.lua
#include effects.lua

__gfx__
00000000000000000000000000000000666666660007600066666666666666660005555555555000666666b000000000666666b00c666666000000000c666666
00000000000000000000000000000000555555550007600066666665566666660056666666666500666666b0bbbbb000666666b00c666666000ccccc0c666666
00700700000000000000000070000007056666700076650066666650056666660566666666666650666666b066666b00666666b00c66666600c666660c666666
00077000000777007777777707700077056666700076650066666650056666660566666666666650666666b066666b00666666b00c66666600c666660c666666
00077000007777700777777007777770005667000766665066666650056666660566666666666650666666b0666666b066666b000c6666660c66666600c66666
00700700077777770077770000777700005667000766665066666650056666660566666666666650666666b0666666b066666b000c6666660c66666600c66666
00000000777700000777000000777700000670005555555566666500005666665666666666666665666666b0666666b0bbbbb0000c6666660c666666000ccccc
00000000000000000000000007770000000670006666666655555000000555556666666666666666666666b0666666b0000000000c6666660c66666600000000
77700000777000000070000000000000700000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60000000776770006677700066607000006000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60666000666000006677070066667700666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666600660666006660607066667770666667700000000000000000077998844550000000000000000000000000000000000000000000000000000000000000
66666600666666006666660066660070666667700000000000000000077998844550000000000000000000000000000000000000000000000000000000000000
66666677666666606666666066666607666660670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
56666677566666605666666056666660566666070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55666667556666775566666055666660556666070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
56666007566666775666666056666660566666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666607666606676666677766666660666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666600666660706666077066666600666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666600666660706666607066607770666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666000666660006666070066607700660770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
67700000766000006660700066077000006770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77700000700000000000000000700000777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000777770000000000000777000000000000000700000000000700000000000000077700000000000000000000000000000000000000000000000000000000
00000776000000000000066776770000000706666777000000077066660700000007760006000000000000000000000000000000000000000000000000000000
00066666066600000006666666000000007066666770700000770666666770000007706666660000000000000000000000000000000000000000000000000000
00666666666660000706666660666000070666666606070007770666666777000066666666667700000000000000000000000000000000000000000000000000
00666666666660000706666666666000077066666666600000666666666007000066666666667700000000000000000000000000000000000000000000000000
70666666666667707660666666666600777666666666660006666666666660700666666666660670000000000000000000000000000000000000000000000000
70066665666667707766666566666600066666656666660006666665666666000066666566666070000000000000000000000000000000000000000000000000
76666655566666707766665556666770066666555666660006666655566666007066665556666070000000000000000000000000000000000000000000000000
77666665666600700666666566666770066666656666660006666665666666007066666566666000000000000000000000000000000000000000000000000000
77666666666660700666666666606670066666666666777070666666666666007606666666666600000000000000000000000000000000000000000000000000
00666666666660000066666666660700006666666660770007006666666660000776666666666000000000000000000000000000000000000000000000000000
00666666666660000066606666660700070606666666070007776666660777000776666666666000000000000000000000000000000000000000000000000000
00066606666600000000066666660000007077666660700000776666660770000006666660770000000000000000000000000000000000000000000000000000
00000006770000000007767766000000000777666607000000070666607700000000060006770000000000000000000000000000000000000000000000000000
00000777770000000000077700000000000007000000000000000000070000000000000777000000000000000000000000000000000000000000000000000000
__map__
0604040404040404040404040404040700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b00000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c00000000000000000000000000000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0905050505050505050505050505050800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
