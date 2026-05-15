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
s.record(numChannels:4) ;
s.options.memSize = 2097152

kalimerak
(
SynthDef.new(\id, {
	arg dur=1;
	var x=0.01,y=0.285,t,z=1;
	var k=0, sig,env;
	var sum=0,f,c,a;
	f=Complex(0,0);
	//env=EnvGen.ar(Env.perc(0.3,4,1/1,[-4,-4]),doneAction:2);
	//sum=FSinOsc.ar(512,mul:env,iphase:pi);
32.do{
		dur=dur+1;
		z=(dur+1)/dur;
			c=Complex(x,y);
	f=(f.squared)+c;
		env=EnvGen.ar(Env.perc(4,4,0.01/(z*f.abs),[-4,-4]),doneAction:2);
		sig=FSinOsc.ar(z*f.abs*44100,mul:env,iphase:f.angle*pi);
		sum=sum+sig;
		Out.ar(0,PanAz.ar(4,sum*env,LFSaw.ar(f.abs),width:3));
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


