s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=8
TempoClock.default.tempo_(60/8);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;
~a= Buffer.read(s,path:"/Users/petrostatsiopoulos/Dokuments/portfolio/studies/acg/9/studio projects/recordings final/339326__inspectorj__bird-whistling-a mono.wav");
~a.query;
~a.numFrames

(
(
SynthDef.new(\id1, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,12,pr/6,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*6,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*(1/dur);
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

	    env=EnvGen.ar(Env.perc(a,9,pr/8,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*8,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*(1/dur);
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
);
(
SynthDef.new(\id3, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,8,pr/9,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*9,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*(1/dur);
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
);
(
SynthDef.new(\id4, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,6,pr/12,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*12,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*(1/dur);
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
)
)


//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
(

( Pdef(\1, Pbind(\instrument, \id1,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
	\sp,Pbrown(0,7701000,100,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,0.05,0.01,inf),
	\f,Prand([60,80,90,120],inf),
	\pass,Pexprand(0.0005,10,inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\2, Pbind(\instrument, \id2,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
	\sp,Pbrown(0,7701000,10000,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,0.05,0.01,inf),
\f,Prand([60,80,90,120],inf),
	\pass,Pexprand(0.0005,10,inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\3, Pbind(\instrument, \id3,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
	\sp,Pbrown(0,7701000,10000,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
	\f,Prand([60,80,90,120],inf),
	\pass,Pexprand(0.0005,10,inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\4, Pbind(\instrument, \id4,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
	\sp,Pbrown(0,7701000,10000,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
\f,Prand([60,80,90,120],inf),
	\pass,Pexprand(0.0005,10,inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

)

s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=8
TempoClock.default.tempo_(60/30);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;
~a= Buffer.read(s,path:"/Users/petrostatsiopoulos/Dokuments/portfolio/studies/acg/9/studio projects/recordings final/339326__inspectorj__bird-whistling-a mono.wav");
~a.query;
~a.numFrames

(
(
SynthDef.new(\id5, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20;
	var sig,sum=0;
	var env,freq;

	freq=n*6*f;
	    env=EnvGen.ar(Env.perc(a,16,pr,[-4,-4]),doneAction:2);
		sig=PanAz.ar(2,BBandPass.ar(PlayBuf.ar(1,b,BufRateScale.kr(0),startPos:sp),freq,pass,mul:(0.1/pass)),LFSaw.ar(2/6),width:2);

		Out.ar(0,sig*env*8);
}).add;
);
(
SynthDef.new(\id6, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20;
	var sig,sum=0;
	var env,freq;


	freq=n*(6*(9/8))*f;
	    env=EnvGen.ar(Env.perc(a,16,pr,[-4,-4]),doneAction:2);
		sig=PanAz.ar(2,BBandPass.ar(PlayBuf.ar(1,b,BufRateScale.kr(0),startPos:sp),freq,pass,mul:(0.1/pass)),LFSaw.ar(2/8),width:2);

		Out.ar(0,sig*env*8);
}).add;
);
(
SynthDef.new(\id7, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20;
	var sig,sum=0;
	var env,freq;


	freq=n*(6*(9/8)*(9/8))*f;
	    env=EnvGen.ar(Env.perc(a,16,pr,[-4,-4]),doneAction:2);
		sig=PanAz.ar(2,BBandPass.ar(PlayBuf.ar(1,b,BufRateScale.kr(0),startPos:sp),freq,pass,mul:(0.1/pass)),LFSaw.ar(2/9),width:2);

		Out.ar(0,sig*env*8);
}).add;
);
(
SynthDef.new(\id8, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20;
	var sig,sum=0;
	var env,freq;


	freq=n*8*f;
	    env=EnvGen.ar(Env.perc(a,16,pr,[-4,-4]),doneAction:2);
		sig=PanAz.ar(2,BBandPass.ar(PlayBuf.ar(1,b,BufRateScale.kr(0),startPos:sp),freq,pass,mul:(0.1/pass)),LFSaw.ar(2/12),width:2);

		Out.ar(0,sig*env*8);
}).add;
);
)
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
(

( Pdef(\5, Pbind(\instrument, \id5,
	\dur,Pbrown(1,12,2,inf),
	\sp,Pbrown(0,1060000,10000,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
	\f,Prand([60/2,80/2,90/2,120/2],inf),
	\pass,Pexprand(0.0005,1,inf),
	\n,Pbrown(1,8,1,inf);)).play(quant:1));

( Pdef(\6, Pbind(\instrument, \id6,
	\dur,Pbrown(1,12,2,inf),
	\sp,Pbrown(0,1060000,10000,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
\f,Prand([60/2,80/2,90/2,120/2],inf),
	\pass,Pexprand(0.0005,1,inf),
	\n,Pbrown(1,8,1,inf);)).play(quant:1));

( Pdef(\7, Pbind(\instrument, \id7,
	\dur,Pbrown(1,12,2,inf),
	\sp,Pbrown(0,7701000,10000,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
	\f,Prand([60/2,80/2,90/2,120/2],inf),
	\pass,Pexprand(0.0005,1,inf),
	\n,Pbrown(1,8,1,inf);)).play(quant:1));

( Pdef(\8, Pbind(\instrument, \id8,
	\dur,Pbrown(1,12,2,inf),
	\sp,Pbrown(0,7701000,10000,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
\f,Prand([60/2,80/2,90/2,120/2],inf),
	\pass,Pexprand(0.0005,1,inf),
	\n,Pbrown(1,8,1,inf);)).play(quant:1));

)