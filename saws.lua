function addsaw(ss)
    local y
    local x = ss.xi
    if #ss == 0 then
        y = rndr(ss.yl, ss.yr - 15)
    else
        y = newypos(ss)
    end
    local ns = {
        xi = ss.xi,
        xf = ss.xf,
        x = x,
        y = y,
        yf = 0,
        spr = rndr(1, #sawsprs),
        coll = { x = x + 2, y = y + 2, w = sawsize - 6, h = sawsize - 6 },
        moving = true,
        hidden = true
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

function update_saws(s)
    if s.moving then
        s.moving = not s.mfunc()
    end
    s.coll.x = s.x + 2
    s.coll.y = s.y + 2
end

function draw_saws(ss)
    i = 1
    for s in all(ss) do
        local n = sawsprs[flr(s.spr + time() * ss.rot * 10) % #sawsprs + 1]
        local offset = ss.flp and -1 or 0
        spr(n, s.x + offset, s.y, 2, 2, ss.flp)
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

function movesaws(ss)
    if #ss == 0 then
        addsaw(ss)
    elseif issupd <= #updscores and score == updscores[issupd] then
        issupd += 1
        addsaw(ss)
    else
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