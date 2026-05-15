(
(
SynthDef.new(\id1, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=240/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,1/1,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
			pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id2, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=240/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,1/1,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
			pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id3, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=320/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,3/4,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar((pan.rand)),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
			pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id4, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=320/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,3/4,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar((pan.rand)),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
			pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id5, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=320/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,3/4,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
			pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id6, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=360/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,3/4,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
			pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id7, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=360/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,2/3,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
			pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id8, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=360/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,2/3,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
			pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id9, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=360/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,2/3,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
			envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
			pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id10, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=480/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,1/2,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
		pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id11, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=480/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,1/2,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
		pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id12, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=480/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,1/2,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
		pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
);
(
SynthDef.new(\id13, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1;
	var sig,x=0,amp=1,audio=0,fund=480/2;
	var env,freq=4,envd,envf,pan=1;
	   envd=EnvGen.ar(Env.perc(attack,10,1/2,[-4,-4]),doneAction:2);
		24.do{
		env=EnvGen.ar(Env.perc(attack,10,1/amp,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(6,SinOsc.ar(fund+envf,mul:env),LFNoise0.ar(pan.rand),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+interval)/x;
		fund=(fund*freq+detune);
		amp=(amp*freq+detune);
		pan=pan*freq;
	};
	Out.ar(0,audio*envd);
}).add;
)
)


//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
(

( Pdef(\1, Pbind(\instrument, \id1,
			\dur,Pexprand(1,8,inf),
				\attack,Pexprand(0.01,1,inf),
	\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
	\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\2, Pbind(\instrument, \id2,
		\dur,Pexprand(1,8,inf),
			\attack,Pexprand(0.01,1,inf),
		\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
	\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\3, Pbind(\instrument, \id3,
		\dur,Pexprand(1,8,inf),
					\attack,Pexprand(0.01,1,inf),
	\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\4, Pbind(\instrument, \id4,
		\dur,Pexprand(1,8,inf),
								\attack,Pexprand(0.01,1,inf),
		\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
	\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\5, Pbind(\instrument, \id5,
		\dur,Pexprand(1,8,inf),
				\attack,Pexprand(0.01,1,inf),
		\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\6, Pbind(\instrument, \id6,
		\dur,Pexprand(1,8,inf),
		\attack,Pexprand(0.01,1,inf),
	\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
	\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\7, Pbind(\instrument, \id7,
		\dur,Pexprand(1,8,inf),
				\attack,Pexprand(0.01,1,inf),
	\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
	\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\8, Pbind(\instrument, \id8,
		\dur,Pexprand(1,8,inf),
				\attack,Pexprand(0.01,1,inf),
	\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
	\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\9, Pbind(\instrument, \id9,
		\dur,Pexprand(1,8,inf),
			\attack,Pexprand(0.01,1,inf),
		\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
	\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\10, Pbind(\instrument, \id10,
		\dur,Pexprand(1,8,inf),
					\attack,Pexprand(0.01,1,inf),
	\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\11, Pbind(\instrument, \id11,
		\dur,Pexprand(1,8,inf),
					\attack,Pexprand(0.01,1,inf),
	\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\12, Pbind(\instrument, \id12,
		\dur,Pexprand(1,8,inf),
					\attack,Pexprand(0.01,1,inf),
		\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
\detune,Pexprand(1,8,inf);
)).play(quant:1));

( Pdef(\13, Pbind(\instrument, \id13,
		\dur,Pexprand(1,8,inf),
					\attack,Pexprand(0.01,1,inf),
		\interval,Pbrown(1,4,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
\detune,Pexprand(1,8,inf);
)).play(quant:1));

)


s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=6
TempoClock.default.tempo_(60/120);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;