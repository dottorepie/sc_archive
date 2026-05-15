(
SynthDef.new(\id1, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,1,pr/6,[-4,-4]),doneAction:2);
		100.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*6,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
);

(
SynthDef.new(\id2, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,1,pr/6,[-4,-4]),doneAction:2);
		100.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*6,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
)
(
SynthDef.new(\id3, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,1,pr/6,[-4,-4]),doneAction:2);
		100.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*6,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
)

(
( Pdef(\1, Pbind(\instrument, \id1,
	\dur,0.2,
	\l,Pexprand(440,3000,inf),
		\pr,Pexprand(0.8,1,inf),
	\a,Pbrown(0.01,0.05,0.01,inf),
	\f,Pseq([10,20,30],inf);

)).play(quant:1));

( Pdef(\2, Pbind(\instrument, \id2,
	\dur,0.4,
	\l,Pexprand(440,3000,inf),
		\pr,Pexprand(0.8,1,inf),
	\a,Pbrown(0.01,0.05,0.01,inf),
	\f,Pseq([40,60,20,50,30,80],inf);

)).play(quant:1));

( Pdef(\3, Pbind(\instrument, \id3,
	\dur,0.8,
	\l,Pexprand(440,3000,inf),
		\pr,Pexprand(0.8,1,inf),
	\a,Pbrown(0.01,0.05,0.01,inf),
	\f,Pseq([40,60,20,50,30,80],inf);

)).play(quant:1))
)