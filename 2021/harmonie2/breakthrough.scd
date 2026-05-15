

s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=8
TempoClock.default.tempo_(60/15);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;
~a= Buffer.read(s,path:"/Users/petrostatsiopoulos/Desktop/9/studio projects/recordings final/339326__inspectorj__bird-whistling-a mono.wav");
~a.query;
~a.numFrames

(
{
	var freq=1,audio=0,sig,x=0,f=110,amp=1;

12.do{
		sig=PanAz.ar(2,BLowPass.ar(SinOsc.ar(f,mul:(1/amp)*SinOsc.ar(f)),1200),LFSaw.ar(amp));
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq;
		amp=amp*freq;
		amp.postln
	};
	Out.ar(0,audio);
}.play
)

(
{
	var freq=1,audio=0,sig,x=0,f=110,amp=1;

32.do{
		sig=SinOsc.ar(f.postln,mul:1/amp);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq;
		amp=amp*freq;
	};
	Out.ar(0,audio!2);
}.play
)
{LFSaw.ar(100)!2}.play
(
SynthDef.new(\id1, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=110,l=440;
	var sig;
	var env;
	var freq=1,audio=0,x=0,amp=1;

	//freq=n*6*f;
	    env=EnvGen.ar(Env.perc(a,4,0.5,[-4,-4]),doneAction:2);
		200.do{
		sig=PanAz.ar(2,BLowPass.ar(SinOsc.ar(f*2,mul:1/amp),l),LFSaw.ar(1/amp),width:2);
		//sig=BLowPass.ar(SinOsc.ar(f*2,mul:1/amp),l);
		audio = audio +sig;
		x=x+1;
		freq=(x+n)/x;
		f=f*freq;
		amp=amp*freq;
	};
		//+BBandPass.ar(PlayBuf.ar(1,b,BufRateScale.kr(0),startPos:sp),freq,pass,mul:(0.1/pass)),LFSaw.ar(2/6),width:2);

		Out.ar(0,audio*env);
}).add;
);
(
( Pdef(\1, Pbind(\instrument, \id1,
	\dur,Pbrown(1,6,2,inf),
	\l,Pbrown(220,2400,100,inf),
	\sp,Pbrown(1,20324015,10000,inf),
		\pr,Pexprand(1,1,inf),
	\a,Pbrown(0.01,2,0.1,inf),
	\f,Prand([60,60*(9/8),60*(9/8)*(9/8),80,90,90*(9/8),90*(9/8)*(9/8),120],inf),
	\pass,Pexprand(0.0005,5,inf),
	\n,Pbrown(1,1,1,inf);)).play(quant:1))

)

(
SynthDef.new(\id1, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=110,l=440;
	var sig,x=100,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,8,pr/6,[-4,-4]),doneAction:2);
		30.do{
		sig=PanAz.ar(2,SinOsc.ar((f*x*n).postln,mul:(1/(amp*x*n)).postln,phase:x*pi),LFSaw.ar(x),width:2);
		audio = audio +sig;
		x=(x.squared-(x/2).squared).sqrt;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
)
( Pdef(\1, Pbind(\instrument, \id1,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
	\sp,Pbrown(0,7701000,100,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.1,0.05,0.01,inf),
	\f,Prand([60,80,90,120],inf),
	\pass,Pexprand(0.0005,10,inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1))


(
{
var  x=100, f=110,audio=0,sig,amp=1;
	30.do{
		sig=PanAz.ar(2,SinOsc.ar((f*x).postln,mul:(1/(amp*x)).postln,phase:x*pi),LFSaw.ar(x),width:2);
		audio = audio +sig;
		x=(x.squared-(x/2).squared).sqrt;
	};
Out.ar(0,audio);
}.play
)

(
{
	var freq=1,audio=0,sig,x=0,f=220,amp=1;

100.do{
		sig=PanAz.ar(2,BLowPass.ar(SinOsc.ar(f,mul:(1/amp)),1200),0);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq;
		amp=amp*freq;
	};
	Out.ar(0,audio);
}.play
)



////////////////////////////

(
{
	var freq=1,audio=0,sig,x=0,f=90,amp=1;

6.do{
		x=x+1;
		freq=(x+1)/x;
		f=freq;
		//f=f*freq;
		f.postln;
		//amp=amp*freq;
		sig=PanAz.ar(2,SinOsc.ar(f*1200,mul:(1/f)),LFSaw.ar(1/f));
		audio = audio +sig;
	};
	Out.ar(0,audio);
}.play
)
////////////////////////////////////////////////////////////////////////fibonacci
(
{
	var x=0,y=1,z,audio=0,sig;

24.do{
		sig=SinOsc.ar(220*y,mul:1/(1*y));
		audio = audio +sig;
		z=x+y;
		x=y;
		y=z;
		y.postln;
	};
	Out.ar(0,audio!2);
}.play
)