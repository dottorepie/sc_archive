(SynthDef(\r0,{
	arg t=1,octave =1,pos;
	var fundamental=440, frequency=1, x=0, y1=0,y2=0, a, gain=1, duration=16, bend=(-3),  envelope=1, tone,
	signal0=0, signal,
	height=1, length=4, width=2, radius=8,
	z_bus=8, x_bus=9, y_bus=0,
	right, left, z, sound,audio,
	position, amp, spat, tone1, tone2,
	point_x=0, point_y=0, point_z=0,
	lineZ, lineX1, lineY1, lineY2;

	a= octave; signal0=PanAz.ar(2,SinOsc.ar(fundamental,mul:1),LFNoise1.ar(1));
	4.do{
		x=x+1;
		y1 = ((x+a)/x);
		y2 = ((gain+x)/gain);
		duration=Complex(x,y1).abs;
		duration=duration+t;
		envelope=EnvGen.kr(Env.new([0,1,0.6,0.5,0], [duration], [bend]),doneAction:2);
		signal0=signal0*envelope;
		frequency=(fundamental/y1);
		amp=(gain/y2).postln;
		signal=SinOsc.ar(frequency, mul: amp)*envelope;
		spat = PanAz.ar(2,signal,LFNoise1.ar(y1));
		signal0=signal0 +spat
	};
	sound = Out.ar(0,signal0);

	//Out.ar(0,InFeedback.ar(2));
	//"position".postln;
	//position = Complex(x,y2).abs.postln;
	//position=position*pos;
	//audio=PanAz.ar(2,tone,position);
	//Out.ar(0,audio);
}).add)


k.free;
k = Synth.new(\r0);
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=12;