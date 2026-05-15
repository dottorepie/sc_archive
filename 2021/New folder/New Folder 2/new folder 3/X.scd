TempoClock.default.tempo_(60/120);
s.options.numOutputBusChannels=4
TempoClock.default.tempo_(120/20);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000
s.options.device_("USB Sound Device");
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:6) ;
s.options.memSize = 2097152


(
SynthDef.new(\id, {
	arg dur=1;
	var x=1,y=1,t,z=1;
	var k=0, sig,sig1,env,s;
	var sum=0,sum1=0;
	//env=EnvGen.ar(Env.perc(3,4,1/1,[-4,-4]),doneAction:2);
//sum=FSinOsc.ar(512,mul:env,iphase:pi);
12.do{
		dur=dur+1;
	z=(dur+1)/dur;
	x=z.cos; y=z.sin;
		t=Complex(x,y).angle;
	env=EnvGen.ar(Env.perc(0.01,4,0.1/z,[-4,-4]),doneAction:2);
		sig=FSinOsc.ar(z*440,mul:env,iphase:t*pi);
		sum=sum+sig;
		Out.ar(0,PanAz.ar(2,sum*env,LFSaw.ar(t),width:2));

	};
}).add;
)

(
( Pdef(\1, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\2, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\3, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\4, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\5, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\6, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
( Pdef(\7, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
( Pdef(\8, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
( Pdef(\9, Pbind(\instrument, \id,
	//\dur,5;
\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
( Pdef(\10, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
( Pdef(\11, Pbind(\instrument, \id,
	//\dur,5;
\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
( Pdef(\12, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
( Pdef(\13, Pbind(\instrument, \id,
	//\dur,5;
\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
( Pdef(\14, Pbind(\instrument, \id,
	//\dur,5;
\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
( Pdef(\15, Pbind(\instrument, \id,
	//\dur,5;
\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
( Pdef(\16, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,2,0.125,inf),
			)).play(quant:1));
)
///////////////////////////////////////////////////////


