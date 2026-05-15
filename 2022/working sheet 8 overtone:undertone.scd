(
(
SynthDef.new(\id1, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr;
	var sig,x=0,amp=1,audio=0,fund=600;
	var env,freq=1,envd,envf,pan=1;
		var x1=0,x2=1,x3,y;
	   envd=EnvGen.ar(Env.perc(attack,6,1/1,[-4,-4]),doneAction:2);
		3.do{
				x3=x1+x2;
		x1=x2;
		x2=x3;
		env=EnvGen.ar(Env.perc(attack,10,amp/freq,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar((fund*freq)+envf,mul:env),LFNoise1.ar(1/x2),width:1);
		audio = audio +sig;
		x=x+1;
			freq=(x+1)/1;
	};
	Out.ar(0,audio*envd*pr);
}).add;
);

(
SynthDef.new(\id2, {


		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr;
	var sig,x=0,amp=1,audio=0,fund=800;
	var env,freq=1,envd,envf,pan=1;
		var x1=0,x2=1,x3,y;
	   envd=EnvGen.ar(Env.perc(attack,6,1/1,[-4,-4]),doneAction:2);
		3.do{
				x3=x1+x2;
		x1=x2;
		x2=x3;
		env=EnvGen.ar(Env.perc(attack,10,amp/freq,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar((fund*freq)+envf,mul:env),LFNoise1.ar(1/x2),width:1);
		audio = audio +sig;
		x=x+1;
			freq=(x+1)/1;
	};
	Out.ar(0,audio*envd*pr);
}).add;
);
(
SynthDef.new(\id3, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr;
	var sig,x=0,amp=1,audio=0,fund=900;
	var env,freq=1,envd,envf,pan=1;
		var x1=0,x2=1,x3,y;
	   envd=EnvGen.ar(Env.perc(attack,6,1/1,[-4,-4]),doneAction:2);
		3.do{
				x3=x1+x2;
		x1=x2;
		x2=x3;
		env=EnvGen.ar(Env.perc(attack,10,amp/freq,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar((fund*freq)+envf,mul:env),LFNoise1.ar(1/x2),width:1);
		audio = audio +sig;
		x=x+1;
			freq=(x+1)/1;

	};
	Out.ar(0,audio*envd*pr);
}).add;
);
(
SynthDef.new(\id4, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr;
	var sig,x=0,amp=1,audio=0,fund=1200;
	var env,freq=1,envd,envf,pan=1;
		var x1=0,x2=1,x3,y;
	   envd=EnvGen.ar(Env.perc(attack,6,1/1,[-4,-4]),doneAction:2);
		3.do{
				x3=x1+x2;
		x1=x2;
		x2=x3;
		env=EnvGen.ar(Env.perc(attack,10,amp/freq,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar((fund*freq)+envf,mul:env),LFNoise1.ar(1/x2),width:1);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/1;
	};
	Out.ar(0,audio*envd*pr);
}).add;
);
(
SynthDef.new(\id5, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr;
	var sig,x=0,amp=1,audio=0,fund=1200;
	var env,freq=1,envd,envf,pan=1;
		var x1=0,x2=1,x3,y;
	   envd=EnvGen.ar(Env.perc(attack,6,1/1,[-4,-4]),doneAction:2);
		6.do{
				x3=x1+x2;
		x1=x2;
		x2=x3;
		env=EnvGen.ar(Env.perc(attack,10,amp/freq,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar((fund*freq)+envf,mul:env),LFNoise1.ar(1/x2),width:1);
		audio = audio +sig;
		x=x+1;
			freq=1/(x+1);
	};
	Out.ar(0,audio*envd*pr);
}).add;
);
(
SynthDef.new(\id6, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr;
	var sig,x=0,amp=1,audio=0,fund=1600;
	var env,freq=1,envd,envf,pan=1;
		var x1=0,x2=1,x3,y;
	   envd=EnvGen.ar(Env.perc(attack,6,1/1,[-4,-4]),doneAction:2);
		6.do{
				x3=x1+x2;
		x1=x2;
		x2=x3;
		env=EnvGen.ar(Env.perc(attack,10,amp/freq,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar((fund*freq)+envf,mul:env),LFNoise1.ar(1/x2),width:1);
		audio = audio +sig;
		x=x+1;
		freq=1/(x+1);
	};
	Out.ar(0,audio*envd*pr);
}).add;
);
(
SynthDef.new(\id7, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr;
	var sig,x=0,amp=1,audio=0,fund=1800;
	var env,freq=1,envd,envf,pan=1;
		var x1=0,x2=1,x3,y;
	   envd=EnvGen.ar(Env.perc(attack,6,1/1,[-4,-4]),doneAction:2);
		6.do{
				x3=x1+x2;
		x1=x2;
		x2=x3;
		env=EnvGen.ar(Env.perc(attack,10,amp/freq,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar((fund*freq)+envf,mul:env),LFNoise1.ar(1/x2),width:1);
		audio = audio +sig;
		x=x+1;
		freq=1/(x+1);
	};
	Out.ar(0,audio*envd*pr);
}).add;
);
(
SynthDef.new(\id8, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr;
	var sig,x=0,amp=1,audio=0,fund=2400;
	var env,freq=1,envd,envf,pan=1;
		var x1=0,x2=1,x3,y;
	   envd=EnvGen.ar(Env.perc(attack,6,1/1,[-4,-4]),doneAction:2);
		6.do{
				x3=x1+x2;
		x1=x2;
		x2=x3;
		env=EnvGen.ar(Env.perc(attack,10,amp/freq,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar((fund*freq)+envf,mul:env),LFNoise1.ar(1/x2),width:1);
		audio = audio +sig;
		x=x+1;
		freq=1/(x+1);
	};
	Out.ar(0,audio*envd*pr);
}).add;
);

)


//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

(
( Pdef(\1, Pbind(\instrument, \id1,
			\dur,Pexprand(1,8,inf),
					\attack,Pexprand(0.01,1,inf),
		\interval,Pbrown(1,8,1,inf),
	\a,Pexprand(1,8,inf),
	\b,Pexprand(1,8,inf),
	\c,Pexprand(1,8,inf),
	\d,Pexprand(1,8,inf),
	\e,Pexprand(1,8,inf),
	\f,Pexprand(1,8,inf),
	\g,Pexprand(1,8,inf),
	\k,Pexprand(1,8,inf),
	\l,Pexprand(1,8,inf),
	\m,Pexprand(1,8,inf),
	\n,Pexprand(1,8,inf),
	\o,Pexprand(1,8,inf),
		\p,Pexprand(1,8,inf),
	\q,Pexprand(1,8,inf),
		\r,Pexprand(1,8,inf),
	\s,Pexprand(1,8,inf),
	\t,Pexprand(1,8,inf),
		\u,Pexprand(1,8,inf),
	\v,Pexprand(1,8,inf),
	\w,Pexprand(1,8,inf),
	\pr,Pexprand(0.1,1,inf);
)).play(quant:1));

( Pdef(\2, Pbind(\instrument, \id2,
		\dur,Pexprand(1,8,inf),
					\attack,Pexprand(0.01,1,inf),
			\interval,Pbrown(1,8,1,inf),
	\a,Pexprand(1,8,inf),
	\b,Pexprand(1,8,inf),
	\c,Pexprand(1,8,inf),
	\d,Pexprand(1,8,inf),
	\e,Pexprand(1,8,inf),
	\f,Pexprand(1,8,inf),
	\g,Pexprand(1,8,inf),
	\k,Pexprand(1,8,inf),
	\l,Pexprand(1,8,inf),
	\m,Pexprand(1,8,inf),
	\n,Pexprand(1,8,inf),
	\o,Pexprand(1,8,inf),
		\p,Pexprand(1,8,inf),
	\q,Pexprand(1,8,inf),
		\r,Pexprand(1,8,inf),
	\s,Pexprand(1,8,inf),
	\t,Pexprand(1,8,inf),
		\u,Pexprand(1,8,inf),
	\v,Pexprand(1,8,inf),
	\w,Pexprand(1,8,inf),
	\pr,Pexprand(0.1,1,inf);
)).play(quant:1));

( Pdef(\3, Pbind(\instrument, \id3,
		\dur,Pexprand(1,8,inf),
							\attack,Pexprand(0.01,1,inf),
			\interval,Pbrown(1,8,1,inf),
	\a,Pexprand(1,8,inf),
	\b,Pexprand(1,8,inf),
	\c,Pexprand(1,8,inf),
	\d,Pexprand(1,8,inf),
	\e,Pexprand(1,8,inf),
	\f,Pexprand(1,8,inf),
	\g,Pexprand(1,8,inf),
	\k,Pexprand(1,8,inf),
	\l,Pexprand(1,8,inf),
	\m,Pexprand(1,8,inf),
	\n,Pexprand(1,8,inf),
	\o,Pexprand(1,8,inf),
		\p,Pexprand(1,8,inf),
	\q,Pexprand(1,8,inf),
		\r,Pexprand(1,8,inf),
	\s,Pexprand(1,8,inf),
	\t,Pexprand(1,8,inf),
		\u,Pexprand(1,8,inf),
	\v,Pexprand(1,8,inf),
	\w,Pexprand(1,8,inf),
	\pr,Pexprand(0.1,1,inf);
)).play(quant:1));

( Pdef(\4, Pbind(\instrument, \id4,
		\dur,Pexprand(1,8,inf),
											\attack,Pexprand(0.01,1,inf),
		\interval,Pbrown(1,8,1,inf),
	\a,Pexprand(1,8,inf),
	\b,Pexprand(1,8,inf),
	\c,Pexprand(1,8,inf),
	\d,Pexprand(1,8,inf),
	\e,Pexprand(1,8,inf),
	\f,Pexprand(1,8,inf),
	\g,Pexprand(1,8,inf),
	\k,Pexprand(1,8,inf),
	\l,Pexprand(1,8,inf),
	\m,Pexprand(1,8,inf),
	\n,Pexprand(1,8,inf),
	\o,Pexprand(1,8,inf),
		\p,Pexprand(1,8,inf),
	\q,Pexprand(1,8,inf),
		\r,Pexprand(1,8,inf),
	\s,Pexprand(1,8,inf),
	\t,Pexprand(1,8,inf),
		\u,Pexprand(1,8,inf),
	\v,Pexprand(1,8,inf),
	\w,Pexprand(1,8,inf),
	\pr,Pexprand(0.1,1,inf);
)).play(quant:1));

( Pdef(\5, Pbind(\instrument, \id5,
		\dur,Pexprand(1,8,inf),
							\attack,Pexprand(0.01,1,inf),
				\interval,Pbrown(1,8,1,inf),
	\a,Pexprand(1,8,inf),
	\b,Pexprand(1,8,inf),
	\c,Pexprand(1,8,inf),
	\d,Pexprand(1,8,inf),
	\e,Pexprand(1,8,inf),
	\f,Pexprand(1,8,inf),
	\g,Pexprand(1,8,inf),
	\k,Pexprand(1,8,inf),
	\l,Pexprand(1,8,inf),
	\m,Pexprand(1,8,inf),
	\n,Pexprand(1,8,inf),
	\o,Pexprand(1,8,inf),
		\p,Pexprand(1,8,inf),
	\q,Pexprand(1,8,inf),
		\r,Pexprand(1,8,inf),
	\s,Pexprand(1,8,inf),
	\t,Pexprand(1,8,inf),
		\u,Pexprand(1,8,inf),
	\v,Pexprand(1,8,inf),
	\w,Pexprand(1,8,inf),
	\pr,Pexprand(0.1,1,inf);
)).play(quant:1));

( Pdef(\6, Pbind(\instrument, \id6,
		\dur,Pexprand(1,8,inf),
					\attack,Pexprand(0.01,1,inf),
			\interval,Pbrown(1,8,1,inf),
	\a,Pexprand(1,8,inf),
	\b,Pexprand(1,8,inf),
	\c,Pexprand(1,8,inf),
	\d,Pexprand(1,8,inf),
	\e,Pexprand(1,8,inf),
	\f,Pexprand(1,8,inf),
	\g,Pexprand(1,8,inf),
	\k,Pexprand(1,8,inf),
	\l,Pexprand(1,8,inf),
	\m,Pexprand(1,8,inf),
	\n,Pexprand(1,8,inf),
	\o,Pexprand(1,8,inf),
		\p,Pexprand(1,8,inf),
	\q,Pexprand(1,8,inf),
		\r,Pexprand(1,8,inf),
	\s,Pexprand(1,8,inf),
	\t,Pexprand(1,8,inf),
		\u,Pexprand(1,8,inf),
	\v,Pexprand(1,8,inf),
	\w,Pexprand(1,8,inf),
	\pr,Pexprand(0.1,1,inf);
)).play(quant:1));

( Pdef(\7, Pbind(\instrument, \id7,
		\dur,Pexprand(1,8,inf),
							\attack,Pexprand(0.01,1,inf),
			\interval,Pbrown(1,8,1,inf),
	\a,Pexprand(1,8,inf),
	\b,Pexprand(1,8,inf),
	\c,Pexprand(1,8,inf),
	\d,Pexprand(1,8,inf),
	\e,Pexprand(1,8,inf),
	\f,Pexprand(1,8,inf),
	\g,Pexprand(1,8,inf),
	\k,Pexprand(1,8,inf),
	\l,Pexprand(1,8,inf),
	\m,Pexprand(1,8,inf),
	\n,Pexprand(1,8,inf),
	\o,Pexprand(1,8,inf),
		\p,Pexprand(1,8,inf),
	\q,Pexprand(1,8,inf),
		\r,Pexprand(1,8,inf),
	\s,Pexprand(1,8,inf),
	\t,Pexprand(1,8,inf),
		\u,Pexprand(1,8,inf),
	\v,Pexprand(1,8,inf),
	\w,Pexprand(1,8,inf),
	\pr,Pexprand(0.1,1,inf);
)).play(quant:1));

( Pdef(\8, Pbind(\instrument, \id8,
		\dur,Pexprand(1,8,inf),
						\attack,Pexprand(0.01,1,inf),
			\interval,Pbrown(1,8,1,inf),
	\a,Pexprand(1,8,inf),
	\b,Pexprand(1,8,inf),
	\c,Pexprand(1,8,inf),
	\d,Pexprand(1,8,inf),
	\e,Pexprand(1,8,inf),
	\f,Pexprand(1,8,inf),
	\g,Pexprand(1,8,inf),
	\k,Pexprand(1,8,inf),
	\l,Pexprand(1,8,inf),
	\m,Pexprand(1,8,inf),
	\n,Pexprand(1,8,inf),
	\o,Pexprand(1,8,inf),
		\p,Pexprand(1,8,inf),
	\q,Pexprand(1,8,inf),
		\r,Pexprand(1,8,inf),
	\s,Pexprand(1,8,inf),
	\t,Pexprand(1,8,inf),
		\u,Pexprand(1,8,inf),
	\v,Pexprand(1,8,inf),
	\w,Pexprand(1,8,inf),
	\pr,Pexprand(0.1,1,inf);
)).play(quant:1));

)


s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=6
TempoClock.default.tempo_(120/120);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:6) ;