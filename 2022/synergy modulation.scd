~a= Buffer.read(s,path:"/Users/petrostatsiopoulos/Dokuments/portfolio/studies/acg/9/studio projects/recordings final/339326__inspectorj__bird-whistling-a mono.wav");

(
SynthDef.new(\id5, {

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=4,f=20;
	var sig,sum=0;
	var env,freq;

	freq=n*6*f;
	env=EnvGen.ar(Env.perc(a,16,(pr*20)/6,[-4,-4]),doneAction:2);
		sig=PlayBuf.ar(1,b,BufRateScale.kr(0),startPos:sp);

		Out.ar(2,sig*env);
}).add;
);
( Pdef(\5, Pbind(\instrument, \id5,
	\dur,Pbrown(1,12,2,inf),
	\sp,Pbrown(0,1060000,10000,inf),
		//\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
	\f,Prand([60,80,90,120],inf),
	\pass,Pexprand(0.0005,0.5,inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1))

(
(
SynthDef.new(\id1, {

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,12,pr/6,[-4,-4]),doneAction:2);
		48.do{
		sig=PanAz.ar(2,SinOsc.ar((f*6)+(InFeedback.ar(2)*1000000),mul:1/amp,phase:SinOsc.ar(6*amp)),LFSaw.ar(amp),width:2);
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

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,9,pr/8,[-4,-4]),doneAction:2);
		48.do{
		sig=PanAz.ar(2,SinOsc.ar((f*8)+(InFeedback.ar(2)*1000000),mul:1/amp,phase:SinOsc.ar(8*amp)),LFSaw.ar(amp),width:2);
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

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,8,pr/9,[-4,-4]),doneAction:2);
		48.do{
		sig=PanAz.ar(2,SinOsc.ar((f*9)+(InFeedback.ar(2)*1000000),mul:1/amp,phase:SinOsc.ar(9*amp)),LFSaw.ar(amp),width:2);
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

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,6,pr/12,[-4,-4]),doneAction:2);
		48.do{
		sig=PanAz.ar(2,SinOsc.ar((f*12)+(InFeedback.ar(2)*1000000),mul:1/amp,phase:SinOsc.ar(12*amp)),LFSaw.ar(amp),width:2);
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

{SinOsc.ar(InFeedback.ar(2),mul:100000)}.play
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
(

( Pdef(\1, Pbind(\instrument, \id1,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
			\pr,Pexprand(0.125,0.25,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
	\f,Prand([60,80,90,120],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\2, Pbind(\instrument, \id2,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
				\pr,Pexprand(0.125,0.25,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
\f,Prand([60,80,90,120],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\3, Pbind(\instrument, \id3,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
			\pr,Pexprand(0.125,0.25,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
	\f,Prand([60,80,90,120],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\4, Pbind(\instrument, \id4,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
		\pr,Pexprand(0.125,0.25,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
\f,Prand([60,80,90,120],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

)
///////////////////////////////////////////////////////
(
(
SynthDef.new(\id1, {

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,12,pr/6,[-4,-4]),doneAction:2);
		48.do{
		sig=PanAz.ar(2,SinOsc.ar((f*6)*InFeedback.ar(2),mul:10/amp),LFSaw.ar(amp),width:2);
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

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,9,pr/8,[-4,-4]),doneAction:2);
		48.do{
		sig=PanAz.ar(2,SinOsc.ar((f*8)*InFeedback.ar(2),mul:10/amp),LFSaw.ar(amp),width:2);
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

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,8,pr/9,[-4,-4]),doneAction:2);
		48.do{
		sig=PanAz.ar(2,SinOsc.ar((f*9)*InFeedback.ar(2),mul:10/amp),LFSaw.ar(amp),width:2);
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

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=4,f=100,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,6,pr/12,[-4,-4]),doneAction:2);
		48.do{
		sig=PanAz.ar(2,SinOsc.ar((f*12)*InFeedback.ar(2),mul:10/amp),LFSaw.ar(amp),width:2);
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

{SinOsc.ar(InFeedback.ar(2),mul:100000)}.play
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
(

( Pdef(\1, Pbind(\instrument, \id1,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
			\pr,Pexprand(0.125,0.25,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
	\f,Prand([60,80,90,120],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\2, Pbind(\instrument, \id2,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
				\pr,Pexprand(0.125,0.25,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
\f,Prand([60,80,90,120],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\3, Pbind(\instrument, \id3,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
			\pr,Pexprand(0.125,0.25,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
	\f,Prand([60,80,90,120],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\4, Pbind(\instrument, \id4,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
		\pr,Pexprand(0.125,0.25,inf),
	\a,Pbrown(0.01,0.5,0.01,inf),
\f,Prand([60,80,90,120],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

)