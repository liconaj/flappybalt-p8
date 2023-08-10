bgcol=0

cartdata("liconaj_flappybalt")
--dset(10,0)

debug=false
gravity=0.15
boost=2.5

bgstr="`ト`トoナoナoナoナoナoナoナoナoナoナoナoナoナoナoナoナoナoナoろmfovoれmgovoるmhovolmmoたmhovolmmoそmiovosmfoせmjovosmfoすmkoomcodosmfoしmloomcodosmfoさmmonmeocmgokmgoこmnonmeocmhoimhoけmoolmhobmiofmjoけmookmiobmyoくmpojmkoamyoきm♥myoかm☉myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうm⬅️myoうmwalmhmyogmvo○mwalmhmyogmvo○mwalmhmyogmvo○mwalmhmyogmio😐mwalmhmyogmio○m░almhmyogmio○m░almhmyogmio~m✽almhmyogmio~m✽almhmyogmio~m✽atmyogmjo}msa●myogmkormaoimsa●myogmloqmaohmta●armjodmmopmaohmta●arm|oomaogmua●arm}onmaofmva●arm~ommaoem▒a|arm⬇️ohmaodm🐱a|arm⬇️ohmaodm🐱a|arm░ogmaocm⬇️a|armのa|armのa|armのa|armのa|armのa|armのa|armのa|a|mそa|a}mせa|a▒mこa|a▒mこa|a▒mこa|a▒mこa|a▒mこa|a▒mこa|a▒mこa|azmちa|azmちa|azmちa|a▒mこa|a▒mこa|a▒mこa|a▒mこa|a▒m◆almha|a▒m◆almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|a|m⬆️almha|azm∧almha|azm∧almha|aym❎almha|axm▤almha|awmqa🐱mfalmha|avmra🐱mfalmha|aumsa🐱mfalmha|a~mja▒mgalmha|a~mja█mhalmha|a█mha~mjalmha|a○mia~mjalmha|aumgacmia~mjalmha|aumhaamja~mjalmha|aumsa○mialmha|avmraまaumtaほaumtaほaumuaへa}mmaへa♥mcaへa☉mbaへa웃mbaふa웃mbaふa⌂maaふaナaナaナaナaナaナaナaナ"

function _init()
    t=0
	game={}    
	btnrel=true
	chsaws=nil
	highscore=geths()
    make_parts()
	make_waves()
	restart()
	lsaws=make_saws(1,-1,7,false)	
	rsaws=make_saws(1,121,113,true)	
	bgtbl=s2t(bgstr)
end

function _update60()
	if btn(4) or btn(5) then
		if not game.started then
			game.started=true
			plyr.anim=true			
		elseif btnrel and not game.lose then
			flyplyr()
		end
		btnrel=false
	else
		btnrel=true
	end

	if game.lose then
        t+=1
		if score > highscore then
			seths(score)
		end
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
	pal(9,0)	
	rle2(bgtbl,0,0)
	draw_saws(lsaws)
	draw_saws(rsaws)
	draw_waves()
	map(0,0,0,0,16,16)		
	if game.started then
		cprint(score,75,1,true)
	end	
	draw_pads()
    draw_parts()
	if highscore>0 then
		cprint(highscore,23,13)
	end
	if not game.lose then
		draw_player()
	end

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

function cprint(txt,y,c,big)	
	txt=tostr(txt)
	local f=big and 2 or 1
	local x=63-f*(#txt*3-1)/2
	if big then
		print("\^w\^t"..txt,x,y,c)
	else
		print(txt,x,y,c)
	end
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

function geths()
	return dget(10)
end

function seths(hs)
	highscore=hs
	dset(10,hs)
end

function s2t(s)
 local t={}
 for i=2,#s,2 do
  add(t,ord(s,i-1)*256+ord(s,i)-24672)
 end
 return t
end

function rle2(t,x0,y0,tr)
 local x,y,mw=x0,y0,x0+t[1]
  for i=3,#t do
   local v=t[i]
   local col,len=v\256,v&255
   if(col!=tr) line(x,y,x+len-1,y,col)
   x+=len
  if(x>mw) x=x0 y+=1
 end
end