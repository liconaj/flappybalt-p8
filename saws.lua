function addsaw(ss)
    add(ss, {
        x=nil,
        y=nil,     
        spr=rndr(1,#sawsprs),
        coll={x=nil,y=nil,w=sawsize-6,h=sawsize-6}
    })
    newsspos(ss)
end


function make_saws(xi,xf,flp)
    local ss={
        x=xi,
        dx=xf-xi,
        xi=xi,
        xf=xf,
        y=nil,
        yf=nil,
        yl=12,
        yr=nil,
        rot=4.5,
        flp=flp or false,
        moving=false,  
        mfunc=nil,
        hidden=false,
        adding=false
    }
    addsaw(ss)
    return ss
end


function reset_saws(ss)
    for s in all(ss) do
        del(ss,s)
    end
    addsaw(ss)
end

function update_saws(ss)
    if ss.moving then
        ss.moving=not ss.mfunc()
        updatespos(ss)
    elseif ss.adding then
        addsaw(ss)
        ss.moving=true
        ss.adding=false
        showsaws(ss)
    end
end

function draw_saws(ss)
    for s in all(ss) do
       local n=sawsprs[flr(s.spr+time()*ss.rot*10)%#sawsprs+1]
       spr(n,s.x,s.y,2,2,ss.flp) 
    end
end

function newsspos(ss)
    local th=sawsize*#ss-1
    ss.yr=116-th
    ss.y=rndr(ss.yl,ss.yr)
    updatespos(ss)
end

function updatespos(ss)
    for i=1,#ss do
        local s=ss[i]
        local offset=ss.flp and 1 or 0
        s.x=ss.x-offset
        s.y=ss.y+sawsize*(i-1)        
        s.coll.x=ss.x+2
        s.coll.y=s.y+2
    end
end

function changesaws(dx)
    local ss
    if dx>0 then
        ss=lsaws
    else
        ss=rsaws
    end
    
    if issupd <= #updscores and score==updscores[issupd] then
        issupd+=1
        ss.adding=true
        hidesaws(ss)
    end
end

function lerpsaws(ss,a,b,var)
    local t0=time()
    return function()
        local t=time()-t0
        t=var=="y" and t/2.5 or 2*t
        ss[var]=lerp(ss[a],ss[b],easinout(t))
        return ss[var]==ss[b]
    end    
end

function movesaws(dx)
    local ss
    if dx>0 then        
        ss=lsaws
    else
        ss=rsaws        
    end
    ss.moving=true
    if not ss.hidden then
        showsaws(ss)
    else
        ss.yf=ss.y
        while abs(ss.yf-ss.y)<8 do
            ss.yf=ss.y+rnd{1,-1}*rndr(20,50)
            ss.yf=mid(ss.yf,ss.yl,ss.yr)
        end
        ss.mfunc=lerpsaws(ss,"y","yf","y")
    end
end

function showsaws(ss)
    ss.hidden=true        
    ss.mfunc=lerpsaws(ss,"xi","xf","x")
end

function hidesaws(ss)
    if not ss.hidden then
        return
    end
    ss.moving=true
    ss.hidden=false    
    ss.mfunc=lerpsaws(ss,"xf","xi","x")
end
