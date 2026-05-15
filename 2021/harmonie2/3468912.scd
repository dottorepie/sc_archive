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

	arg dur=1,pr1=1,pr2=1,pr3=1,pr4=1,pr5=1,pr6=1,par=1,n1=1,n2=1,n3=1,n4=1,n5=1,n6=1;
	var env1,env2,env3,env4,env5,env6;
	var o=0;

		par.do{
		o=o+1;
env1=EnvGen.ar(Env.perc(4,6,pr1*(1/(n1*3*o)),[-4,-4]),doneAction:2);
		env2=EnvGen.ar(Env.perc(4,6,pr2*(1/(n2*4*o)),[-4,-4]),doneAction:2);
		env3=EnvGen.ar(Env.perc(4,6,pr3*(1/(n3*6*o)),[-4,-4]),doneAction:2);
		env4=EnvGen.ar(Env.perc(4,6,pr4*(1/(n4*8*o)),[-4,-4]),doneAction:2);
		env5=EnvGen.ar(Env.perc(4,6,pr5*(1/(n5*9*o)),[-4,-4]),doneAction:2);
		env6=EnvGen.ar(Env.perc(4,6,pr6*(1/(n6*12*o)),[-4,-4]),doneAction:2);

		Out.ar(0,PanAz.ar(8,FSinOsc.ar(n1*o*3*20,mul:env1),LFSaw.ar(2/(3*o)),width:2));
		Out.ar(0,PanAz.ar(8,FSinOsc.ar(n2*o*4*20,mul:env2),LFSaw.ar(2/(4*o)),width:2));
	Out.ar(0,PanAz.ar(8,FSinOsc.ar(n3*o*6*20,mul:env3),LFSaw.ar(2/(6*o)),width:2));
		Out.ar(0,PanAz.ar(8,FSinOsc.ar(n4*o*8*20,mul:env4),LFSaw.ar(2/(8*o)),width:2));
		Out.ar(0,PanAz.ar(8,FSinOsc.ar(n5*o*9*20,mul:env5),LFSaw.ar(2/(9*o)),width:2));
		Out.ar(0,PanAz.ar(8,FSinOsc.ar(n6*o*12*20,mul:env6),LFSaw.ar(2/(12*o)),width:2));
	}
}).add;
)
(
SynthDef.new(\idb, {

	arg dur=1,pr1=1,pr2=1,pr3=1,pr4=1,pr5=1,pr6=1,par=1,n1=1,n2=1,n3=1,n4=1,n5=1,n6=1;
	var env1,env2,env3,env4,env5,env6;
	var o=0;

		par.do{
		o=o+1;
		env1=EnvGen.ar(Env.perc(0.04,6,pr1*(1/(n1*3*o)),[-4,-4]),doneAction:2);
		env2=EnvGen.ar(Env.perc(0.04,6,pr2*(1/(n2*4*o)),[-4,-4]),doneAction:2);
		env3=EnvGen.ar(Env.perc(0.04,6,pr3*(1/(n3*6*o)),[-4,-4]),doneAction:2);
		env4=EnvGen.ar(Env.perc(0.04,6,pr4*(1/(n4*8*o)),[-4,-4]),doneAction:2);
		env5=EnvGen.ar(Env.perc(0.04,6,pr5*(1/(n5*9*o)),[-4,-4]),doneAction:2);
		env6=EnvGen.ar(Env.perc(0.04,6,pr6*(1/(n6*12*o)),[-4,-4]),doneAction:2);

		Out.ar(0,PanAz.ar(2,FSinOsc.ar(n1*o*3*40,mul:env1),LFSaw.ar(2/(3*o)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(n2*o*4*40,mul:env2),LFSaw.ar(2/(4*o)),width:2));
	Out.ar(0,PanAz.ar(2,FSinOsc.ar(n3*o*6*40,mul:env3),LFSaw.ar(2/(6*o)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(n4*o*8*40,mul:env4),LFSaw.ar(2/(8*o)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(n5*o*9*40,mul:env5),LFSaw.ar(2/(9*o)),width:2));
		Out.ar(0,PanAz.ar(2,FSinOsc.ar(n6*o*12*40,mul:env6),LFSaw.ar(2/(12*o)),width:2));
	}
}).add;
)

(
( Pdef(\1, Pbind(\instrument, \id,
	\dur,Pbrown(1,8,1,inf),
	\par,Pbrown(1,8,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
	\n6,Pbrown(1,8,1,inf);


			)).play(quant:1));
( Pdef(\2, Pbind(\instrument, \id,
		\dur,Pbrown(1,8,1,inf),
	\par,Pbrown(1,8,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
	\n6,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\3, Pbind(\instrument, \id,
	\dur,Pbrown(1,8,1,inf),
	\par,Pbrown(1,8,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
	\n6,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\4, Pbind(\instrument, \id,
\dur,Pbrown(1,8,1,inf),
	\par,Pbrown(1,8,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
	\n6,Pbrown(1,8,1,inf);

			)).play(quant:1));
)


(
( Pdef(\5, Pbind(\instrument, \idb,
\dur,Pbrown(1,8,1,inf),
	\par,Pbrown(1,8,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
	\n6,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\6, Pbind(\instrument, \idb,
\dur,Pbrown(1,8,1,inf),
	\par,Pbrown(1,8,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
	\n6,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\7, Pbind(\instrument, \idb,
	\dur,Pbrown(1,8,1,inf),
	\par,Pbrown(1,8,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
	\n6,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\8, Pbind(\instrument, \idb,
	\dur,Pbrown(1,8,1,inf),
	\par,Pbrown(1,8,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
	\n6,Pbrown(1,8,1,inf);

			)).play(quant:1));
)