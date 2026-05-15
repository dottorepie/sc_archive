(
(
SynthDef.new(\id1, {

		arg dur=1,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr,i=1,y=1;
	var sig,x=0,amp=1,audio=0,fund=600;
	var env,freq=1,envd,envf;
		var x1=0,x2=1,x3;
	i=(y+interval)/interval;
	 envd=EnvGen.ar(Env.sine((dur*12000)/(fund*i),amp/i,[-4,-4]),doneAction:2);
		3.do{
		env=EnvGen.ar(Env.perc(attack,(dur*12000)/((fund*i)*freq),amp/freq,[-4,-4]));	envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar(((fund*i)*freq)+envf,mul:env,phase:pi),LFNoise1.ar(343/((fund*i)*freq)+envf),width:1);
		audio = audio +sig;
		x=x+1;
			freq=(x+y)/y;
	};
	Out.ar(0,audio*envd*pr);
}).add;
);
(
SynthDef.new(\id2, {

		arg dur=1,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr,i=1,y=1;
	var sig,x=0,amp=1,audio=0,fund=600;
	var env,freq=1,envd,envf;
		var x1=0,x2=1,x3;
	i=interval/(y+interval);
	    envd=EnvGen.ar(Env.sine((dur*12000)/(fund*i),amp/i,[-4,-4]),doneAction:2);
		3.do{
		env=EnvGen.ar(Env.perc(attack,(dur*12000)/((fund*i)*freq),amp/freq,[-4,-4]));
envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar(((fund*i)*freq)+envf,mul:env,phase:pi/2),LFNoise1.ar(343/((fund*i)*freq)+envf),width:1);
		audio = audio +sig;
		x=x+1;
			freq=(x+y)/y;
	};
	Out.ar(0,audio*envd*pr);
}).add;
);
(
SynthDef.new(\id3, {

		arg dur=1,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr,i=1,y=1;
	var sig,x=0,amp=1,audio=0,fund=600;
	var env,freq=1,envd,envf;
		var x1=0,x2=1,x3;
	i=(y+interval)/interval;
	 envd=EnvGen.ar(Env.sine((dur*12000)/(fund*i),amp/i,[-4,-4]),doneAction:2);
		3.do{
		env=EnvGen.ar(Env.perc(attack,(dur*12000)/((fund*i)*freq),amp/freq,[-4,-4]));	envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar(((fund*i)*freq)+envf,mul:env,phase:pi),LFNoise1.ar(343/((fund*i)*freq)+envf),width:1);
		audio = audio +sig;
		x=x+1;
			freq=y/(x+y);
	};
	Out.ar(0,audio*envd*pr);
}).add;
);
(
SynthDef.new(\id4, {

		arg dur=1,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr,i=1,y=1;
	var sig,x=0,amp=1,audio=0,fund=600;
	var env,freq=1,envd,envf;
		var x1=0,x2=1,x3;
	i=interval/(y+interval);
	   envd=EnvGen.ar(Env.sine((dur*12000)/(fund*i),amp/i,[-4,-4]),doneAction:2);
		3.do{
		env=EnvGen.ar(Env.perc(attack,((dur*12000)/((fund*i)*freq)),amp/freq,[-4,-4]));	envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand,((dur*1200)/((fund*i)*freq)).rand,((dur*12000)/((fund*i)*freq)).rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar(((fund*i)*freq)+envf,mul:env,phase:pi/2),LFNoise1.ar(343/((fund*i)*freq)+envf),width:1);
		audio = audio +sig;
		x=x+1;
			freq=y/(x+y);
	};
	Out.ar(0,audio*envd*pr);
}).add;
);
)


(
( Pdef(\1, Pbind(\instrument, \id1,
			\dur,Pexprand(1,2,inf),
					\attack,Pexprand(0.01,1,inf),
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
	\interval,Pbrown(1,5,1,inf),
	\y,Pbrown(1,5,1,inf),
	\pr,Pexprand(0.3,1,inf);
)).play(quant:1));

( Pdef(\2, Pbind(\instrument, \id2,
			\dur,Pexprand(1,2,inf),
					\attack,Pexprand(0.01,1,inf),
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
	\interval,Pbrown(1,5,1,inf),
	\y,Pbrown(1,5,1,inf),
	\pr,Pexprand(0.3,1,inf);
)).play(quant:1));

( Pdef(\3, Pbind(\instrument, \id3,
				\dur,Pexprand(1,2,inf),
				\attack,Pexprand(0.01,1,inf),
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
	\interval,Pbrown(1,5,1,inf),
	\y,Pbrown(1,5,1,inf),
	\pr,Pexprand(0.3,1,inf);
)).play(quant:1));

( Pdef(\4, Pbind(\instrument, \id4,
		\dur,Pexprand(1,2,inf),
					\attack,Pexprand(0.01,1,inf),
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
	\interval,Pbrown(1,5,1,inf),
	\y,Pbrown(1,5,1,inf),
	\pr,Pexprand(0.3,1,inf);
)).play(quant:1));

)




s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=6
TempoClock.default.tempo_(30/120);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:6) ;