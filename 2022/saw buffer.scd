(
{
	var freq=1,audio=0,sig,x=0,f=110,amp=1,pass=0.001,env;
// env=EnvGen.ar(Env.perc(0.01,8,1,[-4,-4]),doneAction:2);
32.do{
		sig=PanAz.ar(2,BBandPass.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0),f,pass,mul:(0.1/pass)/amp),SinOsc.ar(freq),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq;
		amp=amp*freq;
	};
		audio=BLowPass.ar(audio,1200);
	Out.ar(0,8*audio!2);
}.play
)

(
SynthDef.new(\id1, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=110,l=440;
	var sig;
	var env;
	var freq=1,audio=0,x=0,amp=1;

	    env=EnvGen.ar(Env.perc(a,4,pr/6,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,BBandPass.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0),f,pass,mul:(0.1/pass)/amp),SinOsc.ar(freq),width:2);
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

s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=8
TempoClock.default.tempo_(60/30);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;
~a= Buffer.read(s,path:"/Users/petrostatsiopoulos/Desktop/9/studio projects/recordings final/339326__inspectorj__bird-whistling-a mono.wav");
~a.query;
~a.numFrames

(
(
SynthDef.new(\id1, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=110,l=440;
	var sig;
	var env;
	var freq=1,audio=0,x=0,amp=1;

	    env=EnvGen.ar(Env.perc(a,4,pr/6,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*6,mul:1/amp),LFSaw.ar(freq),width:2);
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

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=110,l=440;
	var sig;
	var env;
	var freq=1,audio=0,x=0,amp=1;

	    env=EnvGen.ar(Env.perc(a,8,pr/8,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*8,mul:1/amp),LFSaw.ar(freq),width:2);
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
SynthDef.new(\id3, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=110,l=440;
	var sig;
	var env;
	var freq=1,audio=0,x=0,amp=1;

	    env=EnvGen.ar(Env.perc(a,8,pr/9,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*9,mul:1/amp),LFSaw.ar(freq),width:2);
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
SynthDef.new(\id4, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=110,l=440;
	var sig;
	var env;
	var freq=1,audio=0,x=0,amp=1;

	    env=EnvGen.ar(Env.perc(a,8,pr/12,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*12,mul:1/amp),LFSaw.ar(freq),width:2);
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
)


(

( Pdef(\1, Pbind(\instrument, \id1,
	\dur,Pbrown(1,8,1,inf),
	\l,Pbrown(440,1200,20,inf),
		\pr,Pexprand(0.5,1,inf),
		\a,Pgauss(0.5,0.49,inf),
	\f,Prand([60/4,80/4,90/4,120/4],inf),
		\pass,Pexprand(0.0005,10,inf),
		\sp,Pbrown(0,1000000,10000,inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\2, Pbind(\instrument, \id2,
	\dur,Pbrown(1,2,1,inf),
	\l,Pbrown(440,1200,20,inf),
		\pr,Pexprand(0.5,1,inf),
		\a,Pgauss(0.5,0.49,inf),
	\f,Prand([60/4,80/4,90/4,120/4],inf),
		\pass,Pexprand(0.0005,10,inf),
		\sp,Pbrown(0,1000000,10000,inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\3, Pbind(\instrument, \id3,
	\dur,Pbrown(1,2,1,inf),
	\l,Pbrown(440,1200,20,inf),
		\pr,Pexprand(0.5,1,inf),
		\a,Pgauss(0.5,0.49,inf),
	\f,Prand([60/4,80/4,90/4,120/4],inf),
		\pass,Pexprand(0.0005,10,inf),
		\sp,Pbrown(0,1000000,10000,inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\4, Pbind(\instrument, \id4,
	\dur,Pbrown(1,2,1,inf),
	\l,Pbrown(440,1200,20,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pgauss(0.5,0.49,inf),
	\f,Prand([60/4,80/4,90/4,120/4],inf),
		\pass,Pexprand(0.0005,10,inf),
		\sp,Pbrown(0,1000000,10000,inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

)