TempoClock.default.tempo_(60/30);
s.options.numOutputBusChannels=4
TempoClock.default.tempo_(60/15);
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
(
SynthDef.new(\id, {

	arg dur=1,pr1=1,pr2=1,pr3=1,pr4=1,par=1,n1=1,n2=1,n3=1,n4=1;
	var sig1,sig2,sig3,sig4;
	var env1,env2,env3,env4;
	var sum;


			 env1=EnvGen.ar(Env.perc(3,6,pr1*(4/(n1*6)),[-4,-4]),doneAction:2);
		env2=EnvGen.ar(Env.perc(3,6,pr2*(4/(n2*8)),[-4,-4]),doneAction:2);
		env3=EnvGen.ar(Env.perc(3,6,pr3*(4/(n3*9)),[-4,-4]),doneAction:2);
		env4=EnvGen.ar(Env.perc(3,6,pr4*(4/(n4*12)),[-4,-4]),doneAction:2);

			    sig1=PanAz.ar(4,FSinOsc.ar(n1*6*20,mul:env2),LFSaw.ar(3/(6)),env1,2);
				sig2=PanAz.ar(4,FSinOsc.ar(n2*8*20,mul:env3),LFSaw.ar(3/(8)),env2,2);
				sig3=PanAz.ar(4,FSinOsc.ar(n3*9*20,mul:env4),LFSaw.ar(3/(9)),env3,2);
	            sig4=PanAz.ar(4,FSinOsc.ar(n4*12*20,mul:env4),LFSaw.ar(3/(12)),env4,2);
		sum=sig1+sig2+sig3+sig4;
	Out.ar(0,4*sum*(1/6));
}).add;
);
(
SynthDef.new(\idb, {

	arg dur=1,pr1=1,pr2=1,pr3=1,pr4=1,par=1,n1=1,n2=1,n3=1,n4=1,p1=1,p2=1,p3=1,p4=1;
	var sig1,sig2,sig3,sig4;
	var env1,env2,env3,env4;
	var sum;

			 env1=EnvGen.ar(Env.perc(0.01,6,pr1*(4/(n1*6)),[-4,-4]),doneAction:2);
		env2=EnvGen.ar(Env.perc(0.01,6,pr2*(4/(n2*8)),[-4,-4]),doneAction:2);
		env3=EnvGen.ar(Env.perc(0.01,6,pr3*(4/(n3*9)),[-4,-4]),doneAction:2);
		env4=EnvGen.ar(Env.perc(0.01,6,pr4*(4/(n4*12)),[-4,-4]),doneAction:2);

			    sig1=PanAz.ar(4,FSinOsc.ar(n1*6*40,mul:env2),p1,env1,4);
				sig2=PanAz.ar(4,FSinOsc.ar(n2*8*40,mul:env3),p2,env2,4);
				sig3=PanAz.ar(4,FSinOsc.ar(n3*9*40,mul:env4),p3,env3,4);
	            sig4=PanAz.ar(4,FSinOsc.ar(n4*12*40,mul:env4),p4,env4,4);
		sum=sig1+sig2+sig3+sig4;
	Out.ar(0,4*sum*(1/8));
}).add;
);

)

(
~a=( Pdef(\1, Pbind(\instrument, \id,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,12,1,inf),
		\pr1,Pbrown(0.5,1,0.1,inf),
	\pr2,Pbrown(0.5,1,0.1,inf),
	\pr3,Pbrown(0.5,1,0.1,inf),
	\pr4,Pbrown(0.5,1,0.1,inf),
		\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),



			)).play(quant:1));
~b=( Pdef(\2, Pbind(\instrument, \id,
			\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,12,1,inf),
		\pr1,Pbrown(0.5,1,0.1,inf),
	\pr2,Pbrown(0.5,1,0.1,inf),
	\pr3,Pbrown(0.5,1,0.1,inf),
	\pr4,Pbrown(0.5,1,0.1,inf),
		\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),



			)).play(quant:1));
~c=( Pdef(\3, Pbind(\instrument, \idb,
		\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,12,1,inf),
		\pr1,Pbrown(0.5,1,0.1,inf),
	\pr2,Pbrown(0.5,1,0.1,inf),
	\pr3,Pbrown(0.5,1,0.1,inf),
	\pr4,Pbrown(0.5,1,0.1,inf),
		\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
			\p1,Pbrown(-0.5,0.5,0.1,inf),
	\p2,Pbrown(-0.5,0.5,0.1,inf),
	\p3,Pbrown(-0.5,0.5,0.1,inf),
	\p4,Pbrown(-0.5,0.5,0.1,inf);


			)).play(quant:1));
~d=( Pdef(\4, Pbind(\instrument, \idb,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,12,1,inf),
		\pr1,Pbrown(0.5,1,0.1,inf),
	\pr2,Pbrown(0.5,1,0.1,inf),
	\pr3,Pbrown(0.5,1,0.1,inf),
	\pr4,Pbrown(0.5,1,0.1,inf),
		\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
			\p1,Pbrown(-0.5,0.5,0.1,inf),
	\p2,Pbrown(-0.5,0.5,0.1,inf),
	\p3,Pbrown(-0.5,0.5,0.1,inf),
	\p4,Pbrown(-0.5,0.5,0.1,inf);


			)).play(quant:1));
)