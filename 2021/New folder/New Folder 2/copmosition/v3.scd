TempoClock.default.tempo_(120/20);
s.options.numOutputBusChannels=10;
TempoClock.default.tempo_(120/12);
);
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
	arg dur;
	var b=1,x=1,bus=1; var y=1,theta,phi; var k,z,pos; var sig,env,s;

	x=dur.cos; y=dur.sin;
	k=Complex(x,y).abs; theta=Complex(x,y).angle;
	z=(((k)+theta))/(k);
	s= Complex(k,z).abs; phi= Complex(z,k).angle;
	env=EnvGen.ar(Env.perc(0.001,dur,1/s,[-4,-4]),doneAction:2);
		sig=PitchShift.ar(SoundIn.ar(0),0.1,pitchRatio:s.linlin(1.5,4,0,4),mul:env);
		Out.ar(8,PanAz.ar(4,LeakDC.ar(sig*env*3),theta.linlin(1,2,-1,1),width:2));
	Out.ar(0,PanAz.ar(4,InFeedback.ar(8)*env,phi.linlin(0.3,0.5,-1,1),width:2));
	Out.ar(4,PanAz.ar(4,InFeedback.ar(9)*env,phi.linlin(0.3,0.5,-1,1),width:2));

}).add;
);
(
SynthDef.new(\id1, {
		arg dur;
	var b=1,x=1,bus=1; var y=1,theta,phi; var k,z,pos; var sig,env,s;

	x=dur.cos; y=dur.sin;
	k=Complex(x,y).abs; theta=Complex(x,y).angle;
	z=(((k)+theta))/(k);
	s= Complex(k,z).abs; phi= Complex(z,k).angle;
	env=EnvGen.ar(Env.perc(0.001,dur,1/s,[-4,-4]),doneAction:2);
		sig=PitchShift.ar(SoundIn.ar(0),0.1,pitchRatio:s.linlin(1.5,4,0,4),mul:env);
	Out.ar(8,PanAz.ar(4,LeakDC.ar(sig*env*3),theta.linlin(1,2,-1,1),width:2));
		Out.ar(0,PanAz.ar(4,InFeedback.ar(8)*env,phi.linlin(0.3,0.5,-1,1),width:2));
	Out.ar(4,PanAz.ar(4,InFeedback.ar(9)*env,phi.linlin(0.3,0.5,-1,1),width:2));
}).add;
)
)
Tdef(\sa).play;
Tdef(\sa).stop;

(
Tdef(\sa,
      {
				 1.do({( Pdef(\1, Pbind(\instrument, \id,
				\dur,Pexprand(1,2,inf),
			)).play(quant:1));  (0).yield});
		1.do({( Pdef(\2, Pbind(\instrument, \id1,
					\dur,Pexprand(1,2,inf),
		)).play(quant:1));  (0).yield});

			})
)

