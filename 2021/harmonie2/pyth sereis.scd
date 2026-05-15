TempoClock.default.tempo_(60/30);
s.options.numOutputBusChannels=8
TempoClock.default.tempo_(60/15);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000
s.options.device_("USB Sound Device");
s.options.memSize = (65536*4);
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:6) ;
s.options.memSize = 2097152


(SynthDef.new(\seefoam,{
	var env;
	env=EnvGen.ar(Env.new([0,1,1,0,],[30,120,30],[-4]));
	Out.ar(0,PanAz.ar(2,BLowPass.ar(WhiteNoise.ar(mul:env*1/20),440),LFSaw.ar(1/12),env,width:2))
}).add)

Synth.new(\seefoam);

( Pdef(\wave, Pbind(\instrument, \seefoam,
	\dur,Pbrown(480,960,60,inf),
			)).play(quant:1));

(
(
SynthDef.new(\idv, {

	arg dur=1,pr1=1,pr2=1,pr3=1,pr4=1,par=1,n1=1,n2=1,n3=1,n4=1;
	var sig1,sig2,sig3,sum;
	var env1,env2,env3,env4,k;
	var m=0;
			 env1=EnvGen.ar(Env.perc(3,6,pr1*(4/(n1*6)),[-4,-4]),doneAction:2);
	k=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),par,(n1*6).linlin(6,96,0,2),mul:env1),LFSaw.ar(2/6),env1,2);
	sum=0;
		1.do{
		m=m+2;
		env2=EnvGen.ar(Env.perc(3,6,pr2*(4/(n2*8*m)),[-4,-4]),doneAction:2);
		env3=EnvGen.ar(Env.perc(3,6,pr3*(4/(n3*9*m)),[-4,-4]),doneAction:2);
		env4=EnvGen.ar(Env.perc(3,6,pr4*(4/(n4*12*m)),[-4,-4]),doneAction:2);

		sig1=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),par,(n2*m*8).linlin(6,96,0,2),mul:env2),LFSaw.ar(2/(8)),env2,2);
		sig2=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),par,(n3*m*9).linlin(6,96,0,2),mul:env3),LFSaw.ar(2/(9)),env3,2);
		sig3=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),par,(n4*m*12).linlin(1,96,0,2),mul:env4),LFSaw.ar(2/(12)),env4,2);
		sum=sum+sig1+sig2+sig3;
	};
		Out.ar(0,sum+k);
}).add;
);
(
SynthDef.new(\idbv, {

	arg dur=1,pr1=1,pr2=1,pr3=1,pr4=1,par=1,n1=1,n2=1,n3=1,n4=1;
	var sig1,sig2,sig3,sum;
	var env1,env2,env3,env4,k;
	var m=0;
   env1=EnvGen.ar(Env.perc(0.03,6,pr1*(4/(n1*6)),[-4,-4]),doneAction:2);
	k=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),0.01,(n1*6).linlin(6,96,2,4),mul:env1),LFSaw.ar(2/6),env1,2);
	sum=0;
		1.do{
		m=m+2;
		env2=EnvGen.ar(Env.perc(0.01,6,pr2*(4/(n2*8*m)),[-4,-4]),doneAction:2);
		env3=EnvGen.ar(Env.perc(0.01,6,pr3*(4/(n3*9*m)),[-4,-4]),doneAction:2);
		env4=EnvGen.ar(Env.perc(0.01,6,pr4*(4/(n4*12*m)),[-4,-4]),doneAction:2);

		sig1=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),0.01,(n2*m*8).linlin(6,96,2,4),mul:env2),LFSaw.ar(2/(8)),env2,2);
		sig2=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),0.01,(n3*m*9).linlin(6,96,2,4),mul:env3),LFSaw.ar(2/(9)),env3,2);
		sig3=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),0.01,(n4*m*12).linlin(1,96,2,4),mul:env4),LFSaw.ar(2/(12)),env4,2);
		sum=sum+sig1+sig2+sig3;
	};
		Out.ar(0,sum+k);
}).add;
)
)
(
(
	~l=( Pdef(\a, Pbind(\instrument, \idv,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(0.1,2,1,inf),
		\pr1,Pexprand(0.5,1,inf),
	\pr2,Pexprand(0.5,1,inf),
	\pr3,Pexprand(0.5,1,inf),
	\pr4,Pexprand(0.5,1,inf),
		\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf);


			)).play(quant:1));
~m=( Pdef(\b, Pbind(\instrument, \idv,
		\dbr,Pbrown(1,8,2,inf),
	\par,Pbrown(0.1,2,1,inf),
		\pr1,Pexprand(0.5,1,inf),
	\pr2,Pexprand(0.5,1,inf),
	\pr3,Pexprand(0.5,1,inf),
	\pr4,Pexprand(0.5,1,inf),
		\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf);

			)).play(quant:1));
~n=( Pdef(\c, Pbind(\instrument, \idv,
		\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(0.1,2,1,inf),
		\pr1,Pexprand(0.5,1,inf),
	\pr2,Pexprand(0.5,1,inf),
	\pr3,Pexprand(0.5,1,inf),
	\pr4,Pexprand(0.5,1,inf),
		\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf);

			)).play(quant:1));
~o=( Pdef(\d, Pbind(\instrument, \idv,
		\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(0.1,2,1,inf),
		\pr1,Pexprand(0.5,1,inf),
	\pr2,Pexprand(0.5,1,inf),
	\pr3,Pexprand(0.5,1,inf),
	\pr4,Pexprand(0.5,1,inf),
			\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf);

			)).play(quant:1));
);


(
~p=( Pdef(\e, Pbind(\instrument, \idbv,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(0.1,2,1,inf),
		\pr1,Pexprand(0.5,1,inf),
	\pr2,Pexprand(0.5,1,inf),
	\pr3,Pexprand(0.5,1,inf),
	\pr4,Pexprand(0.5,1,inf),
				\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf);

			)).play(quant:1));
~q=( Pdef(\f, Pbind(\instrument, \idbv,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(0.1,2,1,inf),
		\pr1,Pexprand(0.5,1,inf),
	\pr2,Pexprand(0.5,1,inf),
	\pr3,Pexprand(0.5,1,inf),
	\pr4,Pexprand(0.5,1,inf),
			\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf);
			)).play(quant:1));

~r=( Pdef(\g, Pbind(\instrument, \idbv,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(0.1,2,1,inf),
		\pr1,Pexprand(0.5,1,inf),
	\pr2,Pexprand(0.5,1,inf),
	\pr3,Pexprand(0.5,1,inf),
	\pr4,Pexprand(0.5,1,inf),
			\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf);
			)).play(quant:1));

~s=( Pdef(\k, Pbind(\instrument, \idbv,
	\dur,Pbrown(1,8,2,inf),
	\par,Pbrown(0.1,2,1,inf),
		\pr1,Pexprand(0.5,1,inf),
	\pr2,Pexprand(0.5,1,inf),
	\pr3,Pexprand(0.5,1,inf),
	\pr4,Pexprand(0.5,1,inf),
			\n1,Pbrown(1,8,1,inf),
	\n2,Pbrown(1,8,1,inf),
	\n3,Pbrown(1,8,1,inf),
	\n4,Pbrown(1,8,1,inf);

			)).play(quant:1));
)
)
~l.stop
~m.stop
~n.stop
~o.stop
~p.stop
~q.stop
~r.stop
~s.stop
~l.play
~m.play
~n.play
~o.play
~p.play
~q.play
~r.play
~s.play
////////////////////////////////////////////////////////////////////////////////


