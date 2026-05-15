TempoClock.default.tempo_(120/20);
s.options.numOutputBusChannels=12;
TempoClock.default.tempo_(120/20);
);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000

s.options.device_("USB Sound Device");
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:6) ;

~b=Buffer.alloc(s,2048);
(	~sig=Signal.sineFill(1024,[1,2/3,3/4,4/5,5/6,6/7,7/8,8/9],[1pi,(3pi)/2,(3pi)/4,(4pi)/5,(5pi)/6,(6pi)/7,(7pi)/8,(8pi)/9]);
	~wt=~sig.asWavetable;
~b.loadCollection(~wt);
)
~sig.plot
(
(
SynthDef.new(\id, {
	arg dur;
	var fund,b=1,x=1,bus=1; var y=1,theta,phi; var k,z,pos; var sig,env,s;

	x=dur.cos; y=dur.sin; fund=110;
	k=Complex(x,y).abs; theta=Complex(x,y).angle;
	z=(((k)+theta))/(k);
	s= Complex(k,z).abs; phi= Complex(z,k).angle;
	env=EnvGen.ar(Env.perc(0.1,dur,1/s,[4,-4]),doneAction:2);
	sig=Osc.ar(~b,s*fund,mul: env*1/6,add:PitchShift.ar(SoundIn.ar(0),0.1,pitchRatio:s.linlin(0.1,3,0,4),mul:env));
	Out.ar(0,PanAz.ar(2,sig*env,LFSaw.ar(phi*dur+s),width:2));
	//	Out.ar(0,PanAz.ar(4,LeakDC.ar(InFeedback.ar(0)*env),LFSaw.ar(theta),width:2));
	//	Out.ar(0,PanAz.ar(4,LeakDC.ar(InFeedback.ar(1)*env),LFSaw.ar(theta),width:2));

}).add;
);
(
SynthDef.new(\id1, {
	arg dur;
	var fund,b=1,x=1,bus=1; var y=1,theta,phi; var k,z,pos; var sig,env,s;

	x=dur.cos; y=dur.sin; fund=220*3/2;
	k=Complex(x,y).abs; theta=Complex(x,y).angle;
	z=(((k)+theta))/(k);
	s= Complex(k,z).abs; phi= Complex(z,k).angle;
	env=EnvGen.ar(Env.perc(0.1,dur,1/s,[4,-4]),doneAction:2);
	sig=Osc.ar(~b,s*fund,mul: env*1/6,add:PitchShift.ar(SoundIn.ar(0),0.1,pitchRatio:s.linlin(0.1,3,0,4),mul:env));
	Out.ar(0,PanAz.ar(2,sig*env*2/3,LFSaw.ar(phi*dur+s),width:2));
	//	Out.ar(0,PanAz.ar(4,LeakDC.ar(InFeedback.ar(0)*env),LFSaw.ar(theta),width:2));
	//	Out.ar(0,PanAz.ar(4,LeakDC.ar(InFeedback.ar(1)*env),LFSaw.ar(theta),width:2));

}).add;
);
(
SynthDef.new(\id1, {
	arg dur;
	var fund,b=1,x=1,bus=1; var y=1,theta,phi; var k,z,pos; var sig,env,s;

	x=dur.cos; y=dur.sin; fund=220*2;
	k=Complex(x,y).abs; theta=Complex(x,y).angle;
	z=(((k)+theta))/(k);
	s= Complex(k,z).abs; phi= Complex(z,k).angle;
	env=EnvGen.ar(Env.perc(0.1,dur,1/s,[4,-4]),doneAction:2);
	sig=Osc.ar(~b,s*fund,mul: env*1/6,add:PitchShift.ar(SoundIn.ar(0),0.1,pitchRatio:s.linlin(0.1,3,0,4),mul:env));
	Out.ar(0,PanAz.ar(2,sig*env*1/2,LFSaw.ar(phi*dur+s),width:2));
	//	Out.ar(0,PanAz.ar(4,LeakDC.ar(InFeedback.ar(0)*env),LFSaw.ar(theta),width:2));
	//	Out.ar(0,PanAz.ar(4,LeakDC.ar(InFeedback.ar(1)*env),LFSaw.ar(theta),width:2));

}).add;
)
)

Tdef(\sa).play;
Tdef(\sa).stop;

(
Tdef(\sa,
      {
				 1.do({( Pdef(\1, Pbind(\instrument, \id,
			\dur,Pseq([12,16,18,12],inf);
			)).play(quant:1));  (0).yield});
		1.do({( Pdef(\2, Pbind(\instrument, \id1,
		\dur,Pseq([24,16,18,12],inf);
		)).play(quant:1));  (0).yield});
		1.do({( Pdef(\3, Pbind(\instrument, \id2,
		\dur,Pseq([12,16,18,24],inf);
		)).play(quant:1));  (0).yield});
			})
)
