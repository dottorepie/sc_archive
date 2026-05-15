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
	var k=0, sig,env;
	var sum=0,f,c,a;
	f=Complex(0,0);
	//env=EnvGen.ar(Env.perc(0.3,4,1/1,[-4,-4]),doneAction:2);
	//sum=FSinOsc.ar(512,mul:env,iphase:pi);
24.do{
		dur=dur+1;
		z=(dur+1)/dur;
	x=z.cos; y=z.sin;
			c=Complex(x,y);
	f=(f.squared)+c;
	env=EnvGen.ar(Env.perc(2,4,1/f.abs,[-4,-4]),doneAction:2);
		sig=FSinOsc.ar(f.abs.poll*220,mul:env,iphase:f.angle*pi);
		sum=sum+sig;
		Out.ar(0,PanAz.ar(2,sum*env,LFSaw.ar(f.abs),width:2));
	};
}).add;
)

(
( Pdef(\1, Pbind(\instrument, \id,
	\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\2, Pbind(\instrument, \id,
	\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\3, Pbind(\instrument, \id,
		\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\4, Pbind(\instrument, \id,
		\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\5, Pbind(\instrument, \id,
			\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\6, Pbind(\instrument, \id,
	\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\7, Pbind(\instrument, \id,
		\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\8, Pbind(\instrument, \id,
	\dur,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
)
///////////////////////////////////////////////////////


