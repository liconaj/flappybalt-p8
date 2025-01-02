bgcol = 0

cartdata("liconaj_flappybalt")
--dset(10,0)

debug = false
gravity = 0.15
boost = 2.5
sawsize = 16
minyl = 12
maxyr = 116

bgstr = "`ト`トoナoナoナoナoナoナoナoナoナoナoナoナoナoナoナoナoナoナoろmfovoれmgovoるmhovolmmoたmhovolmmoそmiovosmfoせmjovosmfoすmkoomcodosmfoしmloomcodosmfoさmmonmeocmgokmgoこmnonmeocmhoimhoけmoolmhobmiofmjoけmookmiobmyoくmpojmkoamyoきm♥myoかm☉myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうmwalmhmyogmvo○mwalmhmyogmvo○mwalmhmyogmvo○mwalmhmyogmio😐mwalmhmyogmio○m░almhmyogmio○m░almhmyogmio~m✽almhmyogmio~m✽almhmyogmio~m✽atmyogmjo}msa●myogmkormaoimsa●myogmloqmaohmta●armjodmmopmaohmta●arm|oomaogmua●arm}onmaofmva●arm~ommaoem▒a|arm⬇️ohmaodm🐱a|arm⬇️ohmaodm🐱a|arm░ogmaocm⬇️a|armのa|armのa|armのa|armのa|armのa|armのa|armのa|a|mそa|a}mせa|a▒mこa|a▒mこa|a▒mこa|a▒mこa|a▒mこa|a▒mこa|a▒mこa|azmちa|azmちa|azmちa|a▒mこa|a▒mこa|a▒mこa|a▒mこa|a▒m◆almha|a▒m◆almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|azm∧almha|azm∧almha|aym❎almha|axm▤almha|awmqa🐱mfalmha|avmra🐱mfalmha|aumsa🐱mfalmha|a~mja▒mgalmha|a~mja█mhalmha|a█mha~mjalmha|a○mia~mjalmha|aumgacmia~mjalmha|aumhaamja~mjalmha|aumsa○mialmha|avmraまaumtaほaumtaほaumuaへa}mmaへa♥mcaへa☉mbaへa웃mbaふa웃mbaふa⌂maaふaナaナaナaナaナaナaナaナ"
updscores = {  5, 10, 20, 25, 40, 45 }
dwnscores = { 50, 55, 65, 70, 80, 85, 95, 100}

sawsprs = { 32, 34, 36, 38, 40 }

notes = "c#2,d2,a2,b-2,d2,c#2,c#3,b-2,a2,d3,b-2,g2,e2,f2,a2,c#2,f1,c#2,d2,a1,a2,b-2,g1,d2,c#2,c#2,b-2,a2,d2,c#2,d2,a1,a2,b-2,g1,d2,c#2,c2#,b-2,a2,f1,d1,a1,c#1,e2,a1,d1,f1,d2,e2,g2,c#2,f2,a2,f2,b1,b1,e2,e2,c2,a2,g2,d2,g2,g2,e-2,c2,c2,e2,c2,c2,f2,c2,e-2,f#2,a1,d2,g2,g1,f2,g#2,g#1,f2,a2,a1,e2,a1,a1,e1,a1,b-1,a2,d2,a1,f2,d2,g1,b-1,d2,e2,a1,a1,c#2,d2,b-1,e-2,e-1,b-1,g2,e-2,b-1,e-2,f1,b-1,d2,b-1,d2,a1,d2,d1,d2,f2,e2,f1,f2,f1,b-1,d2,g#2,f2,g#2,d2,g2,f#2,c2,f#2,g1,c2,e2,b-2,e2,b-2,b-1,e2,a2,g2,e2,g2,a1,d2,f2,d3,f1,b2,f2,c2,f1,d2,f1,d2,f1,d2,f1,c2,f1,b1,f1,b1,g1,b1,g1,c2,e1,d2,f1,c2,f2,b1,d2,f2,a1,d3,b2,c3,a2,b-2,g2,f1,f2,f1,f2,f1,f2,a1,c2,f2,f2,f1,b-1,d2,b1,c2,c3,a2,b2,g2,f1,e2,f2,d2,c#3,d3,b-1,d2,c#,a1,a2,c#2,f1,c#2,d2,a1"

function restart()
	t = 0
	score = 0
	game.started = false
	game.lose = false
	make_player()
	make_pads()
	issupd = 1
	isshoot = 1
end

function _init()
	t = 0
	game = {}
	btnrel = true
	chsaws = nil
	highscore = geths()
	make_parts()
	make_waves()
	restart()
	ssaws = {}
	lsaws = make_saws(-9, 0)
	rsaws = make_saws(121, 113, true)
	bgtbl = s2t(bgstr)
	menuitem(1, "reset highscore", function()
		seths(0)
	end)
end

function _update60()
	if btn(4) or btn(5) then
		if not game.started then
			game.started = true
			plyr.anim = true
		elseif btnrel and not game.lose then
			flyplyr()
		end
		btnrel = false
	else
		btnrel = true
	end

	if game.lose then
		if t==0 then
			sfx(0)
		end
		t += 1
		if score > highscore then
			seths(score)
		end
		if t > 80 then
			restart()
			reset_saws(lsaws)
			reset_saws(rsaws)
		end
	elseif game.started then
		update_player()
	end
	update_pads()
	update_parts()
	update_waves()
	update_saws(lsaws)
	update_saws(rsaws)
	update_saws(ssaws)
end

function _draw()
	cls(bgcol)
	pal(9, 0)
	pal(15, 12)
	rle2(bgtbl, 0, 0)
	draw_saws(lsaws)
	draw_saws(rsaws)
	draw_saws(ssaws)
	draw_waves()
	map(0, 0, 0, 0, 16, 16)
	if game.started then
		cprint(score, 75, 1, true)
	end
	draw_pads()
	draw_parts()
	if highscore > 0 then
		cprint(highscore, 23, 13)
	end
	if not game.lose then
		draw_player()
	end

	if debug then
		draw_coll(plyr.coll, 10)
		for s in all(lsaws) do
			draw_coll(s.coll, 15)
		end
		for s in all(rsaws) do
			draw_coll(s.coll, 15)
		end
		for s in all(ssaws) do
			draw_coll(s.coll, 15)
		end
		print("#lsaws:"..#lsaws, 0, 0, 10)
		print("#rsaws:"..#rsaws, 0, 10, 10)
		print("#ssaws:"..#ssaws, 0, 20, 10)
	end
end

function zfill(txt, n)
	txt = tostr(txt)
	return "\*" .. n - #txt .. "0" .. txt
end

function cprint(txt, y, c, big)
	txt = tostr(txt)
	local f = big and 2 or 1
	local x = 63 - f * (#txt * 3 - 1) / 2
	if big then
		print("\^w\^t" .. txt, x, y, c)
	else
		print(txt, x, y, c)
	end
end

function rndr(l, r)
	return flr(rnd(1 + r - l)) + l
end

function collide(a, b)
	return a.x < b.x + b.w
		and a.x + a.w > b.x
		and a.y - 2 < b.y + b.h
		and a.y + a.h > b.y
end

function easinout(t)
	return 3 * t ^ 2 - 2 * t ^ 3
end

function lerp(a, b, t)
	return a * (1 - t) + b * t
end

function draw_coll(o, col)
	rectfill(o.x, o.y, o.x + o.w, o.y + o.h, col)
end

function geths()
	return dget(10)
end

function seths(hs)
	highscore = hs
	dset(10, hs)
end

function s2t(s)
	local t = {}
	for i = 2, #s, 2 do
		add(t, ord(s, i - 1) * 256 + ord(s, i) - 24672)
	end
	return t
end

function rle2(t, x0, y0, tr)
	local x, y, mw = x0, y0, x0 + t[1]
	for i = 3, #t do
		local v = t[i]
		local col, len = v \ 256, v & 255
		if (col != tr) line(x, y, x + len - 1, y, col) x += len
		if (x > mw) x = x0 y += 1
	end
end

function rndc(tabl)
	local i = rndr(1,#tabl)
	return tabl[i]
end
