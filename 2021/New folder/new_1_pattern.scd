
///////////////////////
(a= Pdef(\voice_1, Pbind(\instrument, \r0,
	\dur,Pexprand(1,5,inf),
	\t,Pexprand(1,5,inf),
	\octave,Prand([1,2,3,4,5],inf),
	\pos,Pexprand(1/10,4/3,inf);
)).play(quant:1))


(SynthDef(\r0,{
	arg t=1,octave =1,partials=2,pos;
	var fundamental, frequency=1, x=0, y1=0,y2=0, a, gain=1, duration=16, bend=(-3),  envelope=1, tone,
	signal0=0, signal, partial_count=2,
	height=1, length=4, width=2, radius=8,
	z_bus=8, x_bus=9, y_bus=0,
	right, left, z, sound,
	position, amp,
	point_x=0, point_y=0, point_z=0,
	lineZ, lineX1, lineY1, lineY2;

	 fundamental = (radius/partials);
	fundamental =(fundamental *80); ////could be midicps and a the octave up down without affect to cps
	a= octave;    partials=partials*partial_count;  signal0=SinOsc.ar(fundamental,mul:gain);
	partials.do{
		x=x+1;
		y1 = ((x+a)/x);
		y2 = (gain/(gain+x));
		frequency=(fundamental/y1);
		 amp=(gain*y2);
		signal=SinOsc.ar( frequency, mul: amp);
		signal0=signal0 +signal};

	duration=Complex(x,y1).abs;
	duration=(duration+t);
	envelope=EnvGen.kr(Env.new([0,0.1,0.01,0.01,0], [duration], [bend]),doneAction:2);
	tone=signal0*envelope;

	"position".postln;
	position = Complex(x,y2).abs.postln;
	position=position*pos;
	sound=PanAz.ar(2,tone,position);
	Out.ar(0,sound);
}).add)
////////////////////////////////////////////////////////////////////////////////////////////////////////
(a= Pdef(\voice_1, Pbind(\instrument, \r0,
	\dur,Pexprand(1,5,inf),
	\t,Pexprand(0.1,1,inf),
	\fundamental,Prand([220,440,880],inf),
	\octave,Prand([1,2,3,4,5],inf);
	//\pos,Pexprand(1/10,4/3,inf);
)).play(quant:1))


(SynthDef(\r0,{
	arg t=1,octave =1,pos,fundamental=440;
	var frequency=1, x=0, y1=0,y2=0, a, gain=1, duration=16, bend=(-3),  envelope=1, tone, signal0=0, signal, sound,audio, position, amp, spat,tone1,tone2
	right, left, z, point_x=0, point_y=0, point_z=0, height=1, length=4, width=2, z_bus=8, x_bus=9, y_bus=0, lineZ, lineX1, lineY1, lineY2;

	a= octave; signal0=PanAz.ar(2,SinOsc.ar(fundamental,mul:1),LFNoise1.ar(1));
	4.do{
		x=x+1;
		y1 = ((x+a)/x);
		y2 = ((gain+x)/gain);
		duration=Complex(x,y1).abs;
		duration=duration+t;
		envelope=EnvGen.kr(Env.new([0,0.6,0.333,0.5,0], [duration], [bend]),doneAction:2);
		signal0=signal0*envelope;
		frequency=(fundamental/y1);
		amp=(gain/y2).postln;
		signal=SinOsc.ar(frequency, mul: amp)*envelope;
		spat = PanAz.ar(2,signal,LFNoise1.ar(a/y1));
		signal0=signal0 +spat};
	sound = Out.ar(0,signal0);
tone1=;
	tone2=;
	elevation_1=InFedback.ar(); elevation_2=InFedback
////4partials go to 4 pan then each from 4 is an elevation of the dodecahedron, each elevationhas 5 channels azimuth, which two are the octahedral/cubic space, three are the ico, so in total from the
	///dodehadron there are begot four sets of icosahedra and cubica
}).add)


k.free;
k = Synth.new(\r0);
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=16;