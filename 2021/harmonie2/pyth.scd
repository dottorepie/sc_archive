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

{Out.ar(0,SoundIn.ar(0)!2)}.play
(
(
SynthDef.new(\id, {

	arg dur=1,pr1=1,pr2=1,pr3=1,pr4=1,pr5=1,pr6=1,pr7=1,pr8=1,par=1,n1=1,n2=1,n3=1,n4=1,n5=1,n6=1,n7=1,n8=1;
	var sig1,sig2,sig3,sig4,sig5,sig6,sig7,sum;
	var env1,env2,env3,env4,env5,env6,env7,env8;
	var m=0;
		par.do{
		m=m+1;
		 env1=EnvGen.ar(Env.perc(4,6,pr1*(2/(n1*6)),[-4,-4]),doneAction:2);
        env2=EnvGen.ar(Env.perc(4,6,pr2*(2/(n2*6.75*m)),[-4,-4]),doneAction:2);
		env3=EnvGen.ar(Env.perc(4,6,pr3*(2/(n3*6.75*(9/8)*m)),[-4,-4]),doneAction:2);
		env4=EnvGen.ar(Env.perc(4,6,pr4*(2/(n4*8*m)),[-4,-4]),doneAction:2);
		env5=EnvGen.ar(Env.perc(4,6,pr5*(2/(n5*9*m)),[-4,-4]),doneAction:2);
		env6=EnvGen.ar(Env.perc(4,6,pr6*(2/(n6*10.125*m)),[-4,-4]),doneAction:2);
		env7=EnvGen.ar(Env.perc(4,6,pr7*(2/(n7*10.125*(9/8)*m)),[-4,-4]),doneAction:2);
		env8=EnvGen.ar(Env.perc(4,6,pr8*(2/(n8*12*m)),[-4,-4]),doneAction:2);

		sum=PanAz.ar(2,FSinOsc.ar(n1*6*10,mul:env1),LFSaw.ar(1/6),env1,2);
			sig1=PanAz.ar(2,FSinOsc.ar(n2*m*6.75*10,mul:env2),LFSaw.ar(1/(6.75)),env2,2);
			sig2=PanAz.ar(2,FSinOsc.ar(n3*m*6.75*(9/8)*10,mul:env3),LFSaw.ar(1/(6.75*(9/8))),env3,2);
			sig3=PanAz.ar(2,FSinOsc.ar(n4*m*8*10,mul:env4),LFSaw.ar(1/(8)),env4,2);
				sig4=PanAz.ar(2,FSinOsc.ar(n5*m*9*10,mul:env5),LFSaw.ar(1/(9)),env5,2);
				sig5=PanAz.ar(2,FSinOsc.ar(n6*m*10.125*10,mul:env6),LFSaw.ar(1/(10.125)),env6,2);
				sig6=PanAz.ar(2,FSinOsc.ar(n7*m*10.125*(9/8)*10,mul:env7),LFSaw.ar(1/(10.125*(9/8))),env7,2);
				sig7=PanAz.ar(2,FSinOsc.ar(n8*m*12*10,mul:env8),LFSaw.ar(1/(12)),env8,2);
		sum=sum+sig1+sig2+sig3+sig4+sig5+sig6+sig7;
	};
		Out.ar(0,sum);
}).add;
);
(
SynthDef.new(\idb, {

	arg dur=1,pr1=1,pr2=1,pr3=1,pr4=1,pr5=1,pr6=1,pr7=1,pr8=1,par=1,n1=1,n2=1,n3=1,n4=1,n5=1,n6=1,n7=1,n8=1;
	var sig1,sig2,sig3,sig4,sig5,sig6,sig7,sum;
	var env1,env2,env3,env4,env5,env6,env7,env8;
	var m=0;
		par.do{
		m=m+1;
		 env1=EnvGen.ar(Env.perc(0.05,6,pr1*(2/(n1*6)),[-4,-4]),doneAction:2);
        env2=EnvGen.ar(Env.perc(0.05,6,pr2*(2/(n2*6.75*m)),[-4,-4]),doneAction:2);
		env3=EnvGen.ar(Env.perc(0.05,6,pr3*(2/(n3*6.75*(9/8)*m)),[-4,-4]),doneAction:2);
		env4=EnvGen.ar(Env.perc(0.05,6,pr4*(2/(n4*8*m)),[-4,-4]),doneAction:2);
		env5=EnvGen.ar(Env.perc(0.05,6,pr5*(2/(n5*9*m)),[-4,-4]),doneAction:2);
		env6=EnvGen.ar(Env.perc(0.05,6,pr6*(2/(n6*10.125*m)),[-4,-4]),doneAction:2);
		env7=EnvGen.ar(Env.perc(0.05,6,pr7*(2/(n7*10.125*(9/8)*m)),[-4,-4]),doneAction:2);
		env8=EnvGen.ar(Env.perc(0.05,6,pr8*(2/(n8*12*m)),[-4,-4]),doneAction:2);

		sum=PanAz.ar(2,FSinOsc.ar(n1*6*20,mul:env1),LFSaw.ar(1/6),env1,2);
			sig1=PanAz.ar(2,FSinOsc.ar(n2*m*6.75*20,mul:env2),LFSaw.ar(1/(6.75)),env2,2);
			sig2=PanAz.ar(2,FSinOsc.ar(n3*m*6.75*(9/8)*20,mul:env3),LFSaw.ar(1/(6.75*(9/8))),env3,2);
			sig3=PanAz.ar(2,FSinOsc.ar(n4*m*8*20,mul:env4),LFSaw.ar(1/(8)),env4,2);
				sig4=PanAz.ar(2,FSinOsc.ar(n5*m*9*20,mul:env5),LFSaw.ar(1/(9)),env5,2);
				sig5=PanAz.ar(2,FSinOsc.ar(n6*m*10.125*20,mul:env6),LFSaw.ar(1/(10.125)),env6,2);
				sig6=PanAz.ar(2,FSinOsc.ar(n7*m*10.125*(9/8)*20,mul:env7),LFSaw.ar(1/(10.125*(9/8))),env7,2);
				sig7=PanAz.ar(2,FSinOsc.ar(n8*m*12*20,mul:env8),LFSaw.ar(1/(12)),env8,2);
		sum=sum+sig1+sig2+sig3+sig4+sig5+sig6+sig7;
	};
		Out.ar(0,sum);
}).add;
)
)
(
(
( Pdef(\1, Pbind(\instrument, \id,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,4,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\pr7,Pexprand(0.1,1,inf),
	\pr8,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
		\n6,Pbrown(1,8,1,inf),
	\n7,Pbrown(1,8,1,inf),
	\n8,Pbrown(1,8,1,inf);


			)).play(quant:1));
( Pdef(\2, Pbind(\instrument, \id,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,4,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\pr7,Pexprand(0.1,1,inf),
	\pr8,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
		\n6,Pbrown(1,8,1,inf),
	\n7,Pbrown(1,8,1,inf),
	\n8,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\3, Pbind(\instrument, \id,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,4,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\pr7,Pexprand(0.1,1,inf),
	\pr8,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
		\n6,Pbrown(1,8,1,inf),
	\n7,Pbrown(1,8,1,inf),
	\n8,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\4, Pbind(\instrument, \id,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,4,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\pr7,Pexprand(0.1,1,inf),
	\pr8,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
		\n6,Pbrown(1,8,1,inf),
	\n7,Pbrown(1,8,1,inf),
	\n8,Pbrown(1,8,1,inf);

			)).play(quant:1));
);


(
( Pdef(\5, Pbind(\instrument, \idb,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,4,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\pr7,Pexprand(0.1,1,inf),
	\pr8,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
		\n6,Pbrown(1,8,1,inf),
	\n7,Pbrown(1,8,1,inf),
	\n8,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\6, Pbind(\instrument, \idb,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,4,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\pr7,Pexprand(0.1,1,inf),
	\pr8,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
		\n6,Pbrown(1,8,1,inf),
	\n7,Pbrown(1,8,1,inf),
	\n8,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\7, Pbind(\instrument, \idb,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,4,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\pr7,Pexprand(0.1,1,inf),
	\pr8,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
		\n6,Pbrown(1,8,1,inf),
	\n7,Pbrown(1,8,1,inf),
	\n8,Pbrown(1,8,1,inf);

			)).play(quant:1));
( Pdef(\8, Pbind(\instrument, \idb,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(1,4,1,inf),
		\pr1,Pexprand(0.1,1,inf),
	\pr2,Pexprand(0.1,1,inf),
	\pr3,Pexprand(0.1,1,inf),
	\pr4,Pexprand(0.1,1,inf),
	\pr5,Pexprand(0.1,1,inf),
	\pr6,Pexprand(0.1,1,inf),
	\pr7,Pexprand(0.1,1,inf),
	\pr8,Pexprand(0.1,1,inf),
	\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf),
	\n5,Pbrown(1,8,1,inf),
		\n6,Pbrown(1,8,1,inf),
	\n7,Pbrown(1,8,1,inf),
	\n8,Pbrown(1,8,1,inf);

			)).play(quant:1));
)
)