function make_player(x, y)
	local x = x or 60
	local y = y or 60
	plyr = {}
	plyr.x = x
	plyr.y = y
	plyr.dx = rnd { 1, -1 }
	plyr.dy = -boost
	plyr.anim = false
	plyr.sprt = 0
	plyr.coll = { x = x + 1, y = y + 2, w = 5, h = 4 }
end

function update_player()
	plyr.dy += gravity
	plyr.x += plyr.dx
	plyr.y += plyr.dy

	local cutted = plyrsawscoll(lsaws) or plyrsawscoll(rsaws)
	if plyr.y < 4 or plyr.y > 116 or cutted then
		game.lose = true
		foreach(lsaws, hidesaws)
		foreach(rsaws, hidesaws)
		explode(15, plyr.x, plyr.y)
	end
	if (plyr.x > 112 or plyr.x < 8) and not game.lose then
		local ss, isright
		if plyr.dx > 0 then
			isright = true
			ss = lsaws
		else
			isright = false
			ss = rsaws
		end
		touchpads(isright)
		movesaws(ss)
		plyr.dx *= -1
	end
	if plyr.anim then
		plyr.sprt += 0.2
		if plyr.sprt >= 2 then
			plyr.anim = false
			plyr.sprt = 0
		end
	end
	plyr.coll.x = plyr.x + 1
	plyr.coll.y = plyr.y + 2
end

function draw_player()
	local n = plyr.anim and flr(plyr.sprt) + 1 or 3
	spr(n, plyr.x, plyr.y, 1, 1, plyr.dx < 0)
end

function plyrsawscoll(ss)
	for s in all(ss) do
		if collide(plyr.coll, s.coll) then
			return true
		end
	end
	return false
end

function flyplyr()
	plyr.dy = -boost
	plyr.anim = true
end