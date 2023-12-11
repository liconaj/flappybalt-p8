function make_pads()
	pads = {}
	pads.l = { c = 11, on = false }
	pads.r = { c = 12, on = false }
	pads.t = 0
end

function touchpads(isright)
	score += 1
	pads.l.on = not isright
	pads.r.on = isright
	pads.t = 7
end

function update_pads()
	if pads.t > 0 then
		pads.t -= 1
		if pads.t == 0 then
			pads.l.on = false
			pads.r.on = false
		end
	end
end

function swcol(pad)
	if pad.on then
		pal(pad.c, 7)
	else
		pal(pad.c, 5)
	end
end

function draw_pads()
	swcol(pads.l)
	swcol(pads.r)
end