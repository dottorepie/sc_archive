TempoClock.default.tempo_(60/15);
s.options.numOutputBusChannels=8
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
	arg dur=1,i=1;
	var x=1,y=1,z=1,x0=1,y0=1;
	var k=0, sig2,sig1,env2,env1;
	var sum1=0,sum2=0;
	var z1,z2;
		x=Complex(dur,i).angle;
		y=Complex(dur,i).angle;
		x0=Complex(dur,i).angle.cos;
		y0=Complex(dur,i).angle.sin;
	12.do{
		x=x+1;
		y=y+1;
		z1=(0+1)/x;
		z2=(0+1)/y;
	env1=EnvGen.ar(Env.perc(0.02,6,0.1/z1,[-4,-4]),doneAction:2);
	env2=EnvGen.ar(Env.perc(0.02,4,0.1/z2,[-4,-4]),doneAction:2);
		sig1=SinOsc.ar(z1*1200,mul:env1,phase:z1*pi);
		sig2=SinOsc.ar(z2*1200,mul:env2,phase:z2*pi);
		sum1=sum1+sig1;
		sum2=sum2+sig2;
		Out.ar(0,PanAz.ar(2,sum1*env1,LFSaw.ar(1/z1),width:2));
			Out.ar(0,PanAz.ar(2,sum2*env2,LFSaw.ar(1/z2),width:2));

	};
}).add;
)

(
( Pdef(\1, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
	\i,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\2, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
	\i,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\3, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
	\i,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\4, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
	\i,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\5, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
	\i,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\6, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
	\i,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\7, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
	\i,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
( Pdef(\8, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,10,9/8,inf),
	\i,Pbrown(1,10,9/8,inf),
			)).play(quant:1));
)
///////////////////////////////////////////////////////


