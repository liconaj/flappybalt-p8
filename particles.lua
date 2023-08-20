function make_parts()
    parts={t=0}
end

function update_parts()    
    for p in all(parts) do
        p.dy+=0.005
        p.x+=p.dx
        p.y+=p.dy
        if parts.t>p.life then
            del(parts,p)
        end
    end
    if #parts>0 then
        parts.t+=1
    else
        parts.t=0
    end
end

function draw_parts()
    for p in all(parts) do
        spr(p.spr,p.x,p.y,1,1,p.flip)
    end
end

function mkpart(x,y,v,a)
    dx=v*sin(a)
    dy=v*cos(a)
    return {
        x=x,
        y=y,      
        dx=dx,
        dy=dy,
        spr=10,
        flip=rnd{0,1}==0,
        life=rndr(200,300)
    }
end

function explode(n,x,y)
    for i=1,n do
        a=i*(1/n)+rnd()/10*sgn(rnd{1,-1})
        v=rndr(3,8)/10
        add(parts,mkpart(x,y,v,a))
    end
end
