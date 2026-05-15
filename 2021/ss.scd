{Out.ar(0,SinOsc.ar(20*3/4,mul:MouseX.kr(0.1,1)))}.play



(
{Out.ar(1,

	(
		SinOsc.ar(500*(7/8),mul:(8/7)*0.025,phase:pi/2)
+
		SinOsc.ar(500*(6/7),mul:(7/6)*0.025,phase:pi/2)
+
		SinOsc.ar(500*(5/6),mul:(6/5)*0.025,phase:pi/2)
+
		SinOsc.ar(500*(4/5),mul:(5/4)*0.025,phase:pi/2)
+
		SinOsc.ar(500*(3/4),mul:(4/3)*0.025,phase:pi/2)
+
		SinOsc.ar(500*(2/3),mul:(3/2)*0.025,phase:pi/2)
+
		SinOsc.ar(500*(1/2),mul:(2/1)*0.025,phase:pi/2)
))}.play;
{Out.ar(0,

	(
		SinOsc.ar(500*(7/8),mul:(8/7)*0.025)
+
		SinOsc.ar(500*(6/7),mul:(7/6)*0.025)
+
		SinOsc.ar(500*(5/6),mul:(6/5)*0.025)
+
		SinOsc.ar(500*(4/5),mul:(5/4)*0.025)
+
		SinOsc.ar(500*(3/4),mul:(4/3)*0.025)
+
		SinOsc.ar(500*(2/3),mul:(3/2)*0.025)
+
		SinOsc.ar(500*(1/2),mul:(2/1)*0.025)
))}.play
)
/////////////////////////////////////////////////////////////////////////////////////
(SynthDef.new(\iter, { var temp,freq,a=1, sum; sum=0;

	60.do{
		freq = (a+12)/a;
		a = a +1;
		temp = VarSaw.ar( 40*freq * {Rand(0.99,1.02)}!2,{Rand(0.0,1.0)}!2,0.05,mul: 1/freq!2);
	sum = sum +temp;
};
sum = sum *0.05;
Out.ar(0,sum);
}).add;
)

s = Synth.new(\iter);
//////////////////////
(SynthDef.new(\iter, { var temp,freq,a=1, sum; sum=0;

	70.do{
		freq = (a+5)/a;
		a = a +1;
		temp = SinOsc.ar( 440*freq ,mul: 1/freq);
	sum = sum +temp;
};
sum = sum *0.05;
Out.ar(0,sum);
	70.do{
		freq = (a+5)/a;
		a = a +1;
		temp = SinOsc.ar( 440*freq ,mul: 1/freq,phase:pi/2);
	sum = sum +temp;
};
sum = sum *0.05;
Out.ar(1,sum);
}).add;
)

(
k = Synth.new(\iter);
//s.record(numChannels:2);
)

/////////////////////////////////////////////////////////////////////////////////////
b = Buffer.alloc(s,2048);
Env([0,1,0,-1,0],[1,1,1,1],[5,-5,5,-5])
Env([0,1,-1,0],[1,0,1],[3,0,-3])
(
var env, sig, wt;
env = Env([0,1,0,-1,0],[1,1,1,1],[5,-5,5,-5]);
sig = env.asSignal(length:1024);
wt = sig.asWavetable;
b.loadCollection(wt);
)
b.plot;
{Osc.ar(b,40*[1,2.01],mul:0.2!2)}.play;