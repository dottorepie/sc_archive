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

(
(
SynthDef.new(\id, {
	arg dur;
	var fund,b=1,x=1,bus=1; var y=1,theta,phi; var k,z,pos; var sig,env,s;

	x=dur.cos; y=dur.sin; fund=220;
	k=Complex(x,y).abs; theta=Complex(x,y).angle;
	z=(((k)+theta))/(k);
	s= Complex(k,z).abs; phi= Complex(z,k).angle;
	env=EnvGen.ar(Env.perc(2,dur,1/s,[4,-4]),doneAction:2);
	sig=SinOsc.ar(s*fund,mul: env);
	Out.ar(0,PanAz.ar(2,sig*env,LFSaw.ar(phi*dur+s),width:2));
	//	Out.ar(0,PanAz.ar(4,LeakDC.ar(InFeedback.ar(0)*env),LFSaw.ar(theta),width:2));
	//	Out.ar(0,PanAz.ar(4,LeakDC.ar(InFeedback.ar(1)*env),LFSaw.ar(theta),width:2));

}).add;
);
(
SynthDef.new(\id1, {
	arg dur;
	var fund,b=1,x=1,bus=1; var y=1,theta,phi; var k,z,pos; var sig,env,s;

	x=dur.cos; y=dur.sin; fund=440*3/2;
	k=Complex(x,y).abs; theta=Complex(x,y).angle;
	z=(((k)+theta))/(k);
	s= Complex(k,z).abs; phi= Complex(z,k).angle;
	env=EnvGen.ar(Env.perc(2,dur,1/s,[4,-4]),doneAction:2);
	sig=SinOsc.ar(s*fund,mul: env);
	Out.ar(0,PanAz.ar(2,sig*env,LFSaw.ar(phi*dur+s),width:2));
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
			\dur,Pseq([12,6,8,16],inf);
			)).play(quant:1));  (0).yield});
		 1.do({( Pdef(\2, Pbind(\instrument, \id1,
			\dur,Pseq([18,24,12,6],inf);
			)).play(quant:1));  (0).yield});
			})
)
