function make_saws(n,xi,xf,flp)    
    local ss={} 
    ss.num=n
    ss.sh=16
    ss.h=ss.sh*ss.num-1
    ss.xi=xi
    ss.xf=xf
    ss.yf=nil
    ss.yl=12
    ss.yr=116-ss.h
    local x=ss.xi
    local y=rndr(ss.yl,ss.yr)
    ss.x=x
    ss.y=y        
    ss.sprs={16,17,18,19,20}
    ss.rot=4.5
    ss.flp=flp or false
    ss.on=false
    ss.mov=false
    ss.mfunc=nil
    for i=1,ss.num do
        add(ss,rndr(0,#ss.sprs-1))
    end    
    ss.coll={x=nil,y=nil,w=6,h=ss.h-5}
    return ss
end

function update_saws(ss)
    if ss.mov then
        ss.mov=not ss.mfunc()
    end
    ss.coll.y=ss.y+2
    ss.coll.x=ss.flp and ss.x+1 or ss.x
end

function draw_saws(ss)    
    for i=1,ss.num do
        local n=ss.sprs[flr((ss[i]+time()*ss.rot*10))%#ss.sprs+1]
        local y=ss.y+ss.sh*(i-1)
        spr(n,ss.x,y,1,2,ss.flp)
    end
end

function change_saws(dx)
    local ss
    if dx>0 then
        ss=lsaws
    else
        ss=rsaws        
    end
    if score%5==0 and ss.num<4 then
        chsaws=ss==lsaws and "l" or "r"
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
    ss.mov=true
    if not ss.on then
        showsaws(ss)
    else
        local old=ss.yf
        while ss.yf==old do
            ss.yf=ss.y+rnd{1,-1}*rndr(20,50)
            ss.yf=mid(ss.yf,ss.yl,ss.yr)
        end
        ss.mfunc=lerpsaws(ss,"y","yf","y")
    end    
end

function showsaws(ss)
    ss.on=true        
    ss.mfunc=lerpsaws(ss,"xi","xf","x")
end

function hidesaws(ss)
    if not ss.on then
        return
    end
    ss.mov=true
    ss.on=false    
    ss.mfunc=lerpsaws(ss,"xf","xi","x")
end