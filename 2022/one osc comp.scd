(
SynthDef.new(\id1, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=2000,l=1;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,dur,dur,[-4,-4]),doneAction:2);
		100.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*(1/dur),mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq;
		amp=amp*freq
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,LeakDC.ar(audio*env));
}).add;
)


( Pdef(\1, Pbind(\instrument, \id1,
	\dur,Prand([6,8,9,12],inf),
	\l,Pbrown(440,3000,100,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,0.05,0.01,inf);

)).play(quant:1))


TempoClock.default.tempo_(60/20);