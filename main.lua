bgcol=0

debug=false
gravity=0.15
boost=2.5

bgstr="`ト`ト`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ナ`ろag`u`れaa`faa`u`るaa`gaa`u`kao`せaa`haa`u`kaa`maa`せaa`haa`u`kaa`maa`すaa`iaa`nab`e`kah`faa`しaa`jaa`mad`d`raa`faa`さaa`kaa`maa`caa`c`raa`faa`こaa`laa`lab`cab`bah`iab`faa`けaa`maa`laa`eaa`b`gab`gab`gaa`くaa`naa`jac`eab`a`hab`dac`haa`きaa`oaa`iab`haa`a`iaf`jaa`きaa`oaa`iaa`iab`yaa`かaa`paj`kaa`yaa`おaa`♥`yaa`あad`☉`yaa`あaa`⬅️`yaa`あaa`⬅️`yaa`あaa`⬅️`yaa`あaa`⬅️`yaa`あaa`⬅️`yaa`あaa`⬅️`yaa`あaa`⬅️`yaa`あaa`⬅️`yaa`あaa`⬅️`yaa`iax`yaa`⬅️`yaa`iaa`vaa`yaa`wal`h`yaa`iaa`vaa`yaa`waa`jaa`h`yaa`iaa`vaa`yaa`waa`jaa`h`yaa`iaa`ian`yaa`waa`jaa`h`yaa`iaa`iaa`~ai`waa`jaa`h`yaa`iaa`iaa`|ac`○aa`jaa`h`yaa`iaa`iaa`|aa`▒aa`jaa`h`yaa`iaa`iaa`|aa`▒aa`jaa`h`yaa`iaa`iab`{aa`▒aa`jaa`h`yaa`iaa`jab`pac`gaa`▒aa`jai`yaa`iaa`kab`oaa`aaa`fab`oas`s`yaa`iaa`lab`naa`aaa`faa`paa`✽`yak`mab`maa`aaa`eab`paa`✽ar`█aa`maa`aaa`dab`qaa`✽`qaa`▒ab`kaa`aaa`cab`raa`✽`qaa`🐱ae`gaa`aaa`bab`sak`{`qaa`♥aa`faa`aaa`baa`~aa`{`qaa`♥ab`eaa`aaa`aab`~aa`{`qaa`☉ag`aac`○aa`{`qaa`のaa`{`qaa`のaa`{`qaa`のaa`{`qaa`のaa`{`qaa`のaa`{`qaa`のaa`{`qaa`のaa`{`qaa`のaa`{`qap`こaa`{`█aa`こaa`{`█aa`こaa`{`█aa`こaa`{`█aa`こaa`{`█aa`こaa`{`█aa`こaa`{`█aa`こaa`{`yah`こaa`{`yaa`ちaa`{`yaa`ちaa`{`yaa`ちaa`{`yah`こaa`{`█aa`こaa`{`█aa`こaa`{`█aa`こaa`{`█aa`◆al`haa`{`{af`◆aa`jaa`haa`{`{aa`⬆️aa`jaa`haa`{`{aa`⬆️aa`jaa`haa`{`{aa`⬆️aa`jaa`haa`{`{aa`⬆️aa`jaa`haa`{`{aa`⬆️aa`jaa`haa`{`{aa`⬆️aa`jaa`haa`{`{aa`⬆️aa`jaa`haa`{`zab`⬆️aa`jaa`haa`{`yaa`∧aa`jaa`haa`{`xab`∧aa`jaa`haa`{`wab`❎aa`jaa`haa`{`waa`▤aa`jaa`haa`{`uab`qa🐱`faa`jaa`haa`{`tab`raa`█aa`faa`jaa`haa`{`taa`saa`○ab`faa`jaa`haa`{`taj`jaa`~ab`gaa`jaa`haa`{`}aa`jaa`|ac`haa`jaa`haa`{`~ab`haa`|aa`jaa`jaa`haa`{`tah`baa`iaa`|aa`jaa`jaa`haa`{`taa`gac`iaa`|aa`jaa`jaa`haa`{`taa`haa`jaa`|aa`jaa`jaa`haa`{`taa`saa`|ab`iaa`jaa`haa`{`tab`rab`|ak`jaj`{`taa`taa`へ`taa`tab`ふ`taa`uaa`ふ`tai`maa`ふ`|ak`caa`ふ`●ab`bab`ひ`♥ab`baa`ひ`☉aa`bab`は`☉ab`aab`は`⬅️ab`は`⌂ab`ひ`ナ`ナ`ナ`ナ`ナ`ナ"

function _init()
    t=0
	game={}    
	btnrel=true
	chsaws=nil
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
	rle1(bgstr,0,0)
	draw_saws(lsaws)
	draw_saws(rsaws)
	draw_waves()
	map(0,0,0,0,16,16)	
	if not game.lose then
		draw_player()		
	end
	if game.started then
		cprint(score,75,13,true)
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

function cprint(txt,y,c,big)	
	txt=tostr(txt)
	local x=big and 63-(#txt*6-2)/2	or 63-2*#txt
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


function rle1(s,x0,y,tr)
 local x,mw=x0,x0+ord(s,2)-96
 for i=5,#s,2do
  local col,len=ord(s,i)-96,ord(s,i+1)-96
  if(col!=tr) line(x,y,x+len-1,y,col)
  x+=len if(x>mw) x=x0 y+=1
 end
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