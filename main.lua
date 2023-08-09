bgcol=0

debug=false
gravity=0.15
boost=2.5

function _init()
    t=0
	game={}    
	btnrel=true
	chsaws=nil
    make_parts()
	make_waves()
	make_background()
	restart()	
	lsaws=make_saws(1,-1,7,false)	
	rsaws=make_saws(1,121,113,true)	
end

function _update60()	
	if btn(4) or btn(5) then
		if not game.started then
			game.started=true
			plyr.anim=true
			addwave(plyr.x,plyr.y,7,200)
		elseif btnrel and not game.lose then
			flyplyr()
		end
		btnrel=false
	else
		btnrel=true
	end

	if game.lose then
        t+=1
		if (t>80) restart()
	elseif game.started then
		update_player()
	end
	if chsaws=="l" and not lsaws.mov then
		lsaws=make_saws(lsaws.num+1,-1,7,false)
		lsaws.mov=true
		showsaws(lsaws)
		chsaws=nil
	elseif chsaws=="r" and not rsaws.mov then
		rsaws=make_saws(rsaws.num+1,121,113,true)	
		rsaws.mov=true
		showsaws(rsaws)
		chsaws=nil
	end
	if game.lose and not (lsaws.mov or rsaws.mov) then
		lsaws=make_saws(1,-1,7,false)	
		rsaws=make_saws(1,121,113,true)	
	end
	update_pads()
    update_parts()
	update_waves()
	update_saws(lsaws)
	update_saws(rsaws)
end

function _draw()
	cls(bgcol)	
	pal(6,0)
	--pal(9,8)
	draw_background()
	draw_saws(lsaws)
	draw_saws(rsaws)
	draw_waves()
	map(0,0,0,0,16,16)	
	if not game.lose and game.started then
		draw_player()		
	end
	if not game.started then
		print("press x to start",33,70,7)
	else
		cprint(score,32,5)
	end
	draw_pads()
    draw_parts()

	if debug then
	draw_coll(plyr.coll,10)
	draw_coll(lsaws.coll,15)
	draw_coll(rsaws.coll,15)
	print(lsaws.mov,0,0,10)	
	print(rsaws.mov,0,9,10)	
	end
end

function restart()
	t=0
	score=0
	game.started=false
	game.lose=false	
	make_player()
	make_pads()	
end

function zfill(txt,n)
	txt=tostr(txt)
	return "\*"..(n-#txt).."0"..txt
end

function cprint(txt,y,c)
	txt=tostr(txt)
	local x=63-(#txt*6-2)/2	
	print("\^w\^t"..txt,x,y,c)
end

function rndr(l,r)
	return flr(rnd(1+r-l))+l
end

function collide(a,b)
	return a.x < b.x+b.w
		and a.x+a.w > b.x
		and a.y-2 < b.y+b.h
		and a.y+a.h > b.y 
end

function easinout(t)
	return 3*t^2-2*t^3
end

function lerp(a,b,t)
	return a*(1-t)+b*t
end

function draw_coll(o,col)	
	rectfill(o.x,o.y,o.x+o.w,o.y+o.h,col)
end

function make_background()
	background={}
	for _=1,5 do
		add(background,{
			x=rndr(20,100),
			y=rndr(20,100),
			r=rndr(20,80),
			col=1
		})
	end
end

function draw_background()
	for obj in all(background) do
		circ(obj.x,obj.y,obj.r,obj.col)
	end
end