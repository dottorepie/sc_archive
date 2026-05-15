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

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;
	 var an=360,pan=an.wrap(0,360);

	    env=EnvGen.ar(Env.perc(a,8,pr/6,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*6,mul:1/amp),LFSaw.ar(pan.linlin(0,360,0,1)),width:2);
		audio = audio +sig;
		x=x+1;
		freq=x/(x+1);
		f=f*freq*n;
		amp=amp*freq*n;
		 an=an+137.5;
		pan=an.wrap(0,360);
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
);
(
SynthDef.new(\id2, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;
		 var an=360,pan=an.wrap(0,360);

	    env=EnvGen.ar(Env.perc(a,8,pr/8,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*8,mul:1/amp),LFSaw.ar(pan.linlin(0,360,0,1)),width:2);
		audio = audio +sig;
		x=x+1;
		freq=x/(x+1);
		f=f*freq*n;
		amp=amp*freq*n;
			 an=an+137.5;
		pan=an.wrap(0,360);
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
);
(
SynthDef.new(\id3, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;
		 var an=360,pan=an.wrap(0,360);

	    env=EnvGen.ar(Env.perc(a,8,pr/9,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*9,mul:1/amp),LFSaw.ar(pan.linlin(0,360,0,1)),width:2);
		audio = audio +sig;
		x=x+1;
			freq=x/(x+1);
		f=f*freq*n;
		amp=amp*freq*n;
			 an=an+137.5;
		pan=an.wrap(0,360);
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
);
(
SynthDef.new(\id4, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;
		 var an=360,pan=an.wrap(0,360);

	    env=EnvGen.ar(Env.perc(a,8,pr/12,[-4,-4]),doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*12,mul:1/amp),LFSaw.ar(pan.linlin(0,360,0,1)),width:2);
		audio = audio +sig;
		x=x+1;
		freq=x/(x+1);
		f=f*freq;
		amp=amp*freq*n;
			 an=an+137.5;
		pan=an.wrap(0,360);
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
	\l,Pbrown(880,1200,20,inf),
	\sp,Pbrown(0,7701000,100,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,2,0.1,inf),
	\f,Prand([10,20,30,40],inf),
	\pass,Pexprand(0.0005,10,inf),
	\n,Pbrown(4,8,1,inf);)).play(quant:1));

( Pdef(\2, Pbind(\instrument, \id2,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(880,1200,20,inf),
	\sp,Pbrown(0,7701000,10000,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,2,0.1,inf),
\f,Prand([10,20,30,40],inf),
	\pass,Pexprand(0.0005,10,inf),
	\n,Pbrown(4,8,1,inf);)).play(quant:1));

( Pdef(\3, Pbind(\instrument, \id3,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(880,1200,20,inf),
	\sp,Pbrown(0,7701000,10000,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,2,0.1,inf),
\f,Prand([10,20,30,40],inf),
	\pass,Pexprand(0.0005,10,inf),
	\n,Pbrown(4,8,1,inf);)).play(quant:1));

( Pdef(\4, Pbind(\instrument, \id4,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(880,1200,20,inf),
	\sp,Pbrown(0,7701000,10000,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,2,0.1,inf),
\f,Prand([10,20,30,40],inf),
	\pass,Pexprand(0.0005,10,inf),
	\n,Pbrown(4,8,1,inf);)).play(quant:1));

)
////////////////////////
