function make_waves()
    waves={}
end

function addwave(x,y,col,maxr)
    add(waves,{
        x=x,
        y=y,
        col=col,
        r=10,
        t0=time(),
        spd=2,
        maxr=maxr
    })
end

function update_waves()
    for w in all(waves) do
        local t=time()-w.t0        
        w.r+=w.spd
        if w.r>w.maxr then
            del(waves,w)
        end
    end
end

function draw_waves()
    for w in all(waves) do
        circ(w.x,w.y,w.r,w.col)
    end
end