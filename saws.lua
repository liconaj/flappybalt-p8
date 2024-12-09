function addsaw(ss)
    local y
    local x = ss.xi
    if #ss == 0 then
        y = rndr(ss.yl, ss.yr - 15)
    else
        y = newypos(ss)
    end
    local ns = {
        flp = ss.flp,
        rot = ss.rot,
        xi = ss.xi,
        xf = ss.xf,
        x = x,
        y = y,
        yf = 0,
        spr = rndr(1, #sawsprs),
        coll = { x = x + 2, y = y + 2, w = sawsize - 6, h = sawsize - 6 },
        moving = true,
        hidden = true,
        delete = false
    }
    ns.mfunc = lerpsaw(ns, "xi", "xf", "x", 2)

    local isfirst = #ss == 0 or y < ss[1].y
    add(ss, ns, isfirst and 1 or #ss + 1)
    local th = sawsize * #ss - 1
    ss.yr = maxyr - th
end

function newypos(ss)
    local newypos = {}
    local uppos = ss[1].y - sawsize
    local downpos = ss[1].y + sawsize * #ss
    mydownpos = downpos
    if uppos >= ss.yl then
        add(newypos, uppos)
    end
    if downpos < maxyr - 15 then
        add(newypos, downpos)
    end
    return rnd(newypos)
end

function make_saws(xi, xf, flp)
    local ss = {
        first = true,
        dx = xf - xi,
        xi = xi,
        xf = xf,
        yl = minyl,
        yr = maxyr,
        rot = 4.5,
        flp = flp or false
    }
    return ss
end

function reset_saws(ss)
    ss.yr = maxyr
    for s in all(ss) do
        del(ss, s)
    end
end

function update_saws(ss)
    for saw in all(ss) do
        local todel = updatesaw(saw)
        if (todel) del(ss, saw)
    end
end

function updatesaw(s)
    if s.moving then
        s.moving = not s.mfunc()
        s.coll.x = s.x + 2
        s.coll.y = s.y + 2
    end
    return s.delete
end

function draw_saws(ss)
    i = 1
    for s in all(ss) do
        local n = sawsprs[flr(s.spr + time() * s.rot * 10) % #sawsprs + 1]
        local offset = s.flp and -1 or 0
        spr(n, s.x + offset, s.y, 2, 2, s.flp)
        i += 1
    end
end

function lerpsaw(s, a, b, var, f)
    local t0 = time()
    s.moving = true
    return function()
        local t = time() - t0
        t = f * t
        s[var] = lerp(s[a], s[b], easinout(t))
        return s[var] == s[b]
    end
end

function shootsaw(ss)
    local v0 = 2.5 --4
    local ids = rnd{1,#ss}
    local saw = ss[ids]
    local t0 = time()
    local x = saw.x
    local y = saw.y
    add(ssaws, saw)
    del(ss, saw)
    saw.delete = false
    saw.moving = true
    saw.calcd = false
    saw.mfunc = function()
        local t = time() - t0
        if t < 0.5 then
            saw.x = x + rndr(-2,2)
            saw.y = y + rndr(-2,2)
        elseif t < 5 then
            if not saw.calcd then
                saw.calcd = true
                local ca = plyr.x - saw.x
                local co = plyr.y - saw.y
                local a = atan2(ca, co)

                saw.dx = v0 * cos(a)
                saw.dy = v0 * sin(a)
            end
            saw.dx *= 0.999
            saw.dy += gravity*0.1 --0.5
            saw.x += saw.dx
            saw.y += saw.dy
        else
            saw.delete = true
            return false
        end
    end
end

function movesaws(ss)
    local toupdate = (score == updscores[issupd]) or (score > 103 and score % 3 == 0)
    local toshoot = (score == dwnscores[isshoot]) or (score > 100 and score % 3 == 2)
    if (toupdate or #ss == 0) and #ss < 4 then
        if (#ss>0) issupd += 1
        if #ss==0 and score >= 100 then
            addsaw(ss)
            addsaw(ss)
            addsaw(ss)
        end
        addsaw(ss)
    elseif toshoot then
        isshoot += 1
        shootsaw(ss)
    elseif #ss > 0 then
        local y, yf, dy
        y = ss[1].y
        yf = y
        while abs(dy or 0) < 4 do
            yf = y + rnd { 1, -1 } * rndr(20, 50)
            yf = mid(yf, ss.yl, ss.yr)
            dy = yf - y
        end
        for s in all(ss) do
            s.yf = s.y + dy
            s.mfunc = lerpsaw(s, "y", "yf", "y", 0.3)
        end
    end
end

function hidesaws(s)
    s.mfunc = lerpsaw(s, "xf", "xi", "x", 2)
end