(a= Pdef(\voice_1, Pbind(\instrument, \v0,
	\dur,Prand([1,2,3,4],inf),
	\fundamental,Prand([6,8,9],inf),
	\a,Prand([1,2],inf);
)).play(quant:1))


(SynthDef(\v0,{
	arg fundamental=2,a=1,pan1=1,pan2=1;
	var frequency=1, x=0, y1=0,y2=0, gain=1/2, duration=6, bend=(-3),  envelope=1,mul=1,signal=0,w,
	mono,pan3,sound=0,spat=0,elevation,azimuth1,azimuth2,audio;

	fundamental=fundamental*110;

	3.do{
		x=x+1;
		y1 = ((x+a)/x);
		frequency=(fundamental/y1);
		y2 = ((gain+x)/gain);
		mul=(gain/y2);
		duration= y1+a;
		envelope=EnvGen.kr(Env.new([0,1,0.6,0.4,0], [duration], [bend]),doneAction:2);
		mono=SinOsc.ar(frequency,mul: mul)*envelope;
		signal=LFSaw.ar(y1,mul:mul);
		sound=sound +mono;
		spat=spat+signal;
		sound=sound*envelope;
		spat=spat;
	};

	pan1= (MouseX.kr(3/4,1/2));
	pan2= (MouseY.kr(3/4,1/2));
	pan3= Complex(pan1,pan2).magnitude;

	w=PanAz.ar(12,sound*1/6,SinOsc.ar(2));
	Out.ar(0,w);
	audio = PanAz.ar(3,sound,LFSaw.ar(pan1));
	Out.ar(12,audio*0.5);
	spat = PanAz.ar(3,spat,LFSaw.ar(pan2));
	Out.ar(15,spat*0.5);
	elevation = PanAz.ar(2,InFeedback.ar(12),pos:InFeedback.ar(15));
	Out.ar(0,elevation);
	azimuth1=PanAz.ar(5,InFeedback.ar(13),pos:pan3*InFeedback.ar(16));
	Out.ar(2,azimuth1);
	azimuth2=PanAz.ar(5,InFeedback.ar(14),pos:pan3*InFeedback.ar(17));
	Out.ar(7,azimuth2);

}).add)


s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=18;