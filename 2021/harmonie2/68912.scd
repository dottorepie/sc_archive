TempoClock.default.tempo_(60/30);
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

	arg dur=1;
	var env1,env2,env3,env4,env5,env6;
	var m=0;

		2.do{
		dur=dur+1;
	env1=EnvGen.ar(Env.perc(4,6,1/(3*dur),[-4,-4]),doneAction:2);
	env2=EnvGen.ar(Env.perc(4,6,1/(4*dur),[-4,-4]),doneAction:2);
	env3=EnvGen.ar(Env.perc(4,6,1/(6*dur),[-4,-4]),doneAction:2);
	env4=EnvGen.ar(Env.perc(4,6,1/(8*dur),[-4,-4]),doneAction:2);
	env5=EnvGen.ar(Env.perc(4,6,1/(9*dur),[-4,-4]),doneAction:2);
	env6=EnvGen.ar(Env.perc(4,6,1/(12*dur),[-4,-4]),doneAction:2);

		Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*3*55,mul:env1),LFSaw.ar(2/(3*dur)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*4*55,mul:env2),LFSaw.ar(2/(4*dur)),width:2));
	Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*6*55,mul:env3),LFSaw.ar(2/(6*dur)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*8*55,mul:env4),LFSaw.ar(2/(8*dur)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*9*55,mul:env5),LFSaw.ar(2/(9*dur)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*12*55,mul:env6),LFSaw.ar(2/(12*dur)),width:2));
	}
}).add;
)
(
SynthDef.new(\idb, {

	arg dur=1;
	var env1,env2,env3,env4,env5,env6;
	var m=0;

		2.do{
		dur=dur+1;
	env1=EnvGen.ar(Env.perc(0.01,6,1/(3*dur),[-4,-4]),doneAction:2);
	env2=EnvGen.ar(Env.perc(0.01,6,1/(4*dur),[-4,-4]),doneAction:2);
	env3=EnvGen.ar(Env.perc(0.01,6,1/(6*dur),[-4,-4]),doneAction:2);
	env4=EnvGen.ar(Env.perc(0.01,6,1/(8*dur),[-4,-4]),doneAction:2);
	env5=EnvGen.ar(Env.perc(0.01,6,1/(9*dur),[-4,-4]),doneAction:2);
	env6=EnvGen.ar(Env.perc(0.01,6,1/(12*dur),[-4,-4]),doneAction:2);

	Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*3*55,mul:env1),LFSaw.ar(2/(3*dur)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*4*55,mul:env2),LFSaw.ar(2/(4*dur)),width:2));
	Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*6*55,mul:env3),LFSaw.ar(2/(6*dur)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*8*55,mul:env4),LFSaw.ar(2/(8*dur)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*9*55,mul:env5),LFSaw.ar(2/(9*dur)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(dur*12*55,mul:env6),LFSaw.ar(2/(12*dur)),width:2));
	}
}).add;
)

(
( Pdef(\1, Pbind(\instrument, \id,
	\dur,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\2, Pbind(\instrument, \id,
	\dur,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\3, Pbind(\instrument, \id,
	\dur,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\4, Pbind(\instrument, \id,
		\dur,Pbrown(1,8,1,inf);

			)).play(quant:1));
)


(
( Pdef(\5, Pbind(\instrument, \idb,
	\dur,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\6, Pbind(\instrument, \idb,
	\dur,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\7, Pbind(\instrument, \idb,
	\dur,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\8, Pbind(\instrument, \idb,
		\dur,Pbrown(1,8,1,inf);

			)).play(quant:1));
)