TempoClock.default.tempo_(120/110);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=22;
s.options.numInputBusChannels=0;
Tdef(\1).play
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////task with patterna

(
(
Tdef(\1,
      {

		1.do({(e= Pdef(\voice_1, Pbind(\instrument, \v0,
	\dur,Prand([2],inf),
        \ton, Prand([28],inf),
	\a,Pseq([8],inf),
			\offset,Prand([1,2/3,3/4,4/5,5/6,6/7,7/8,8/9],inf);

)).play(quant:1));
	(5/4).yield});

		 1.do({(f= Pdef(\voice_2, Pbind(\instrument, \v1,
			\dur,Prand([3/2],inf),
        \ton, Prand([28],inf),
	\a,Pseq([5],inf),
	\offset,Prand([1,2/3,3/4,4/5,5/6,6/7,7/8,8/9],inf);
)).play(quant:1));

	(3/2).yield});

				 1.do({(g= Pdef(\voice_3, Pbind(\instrument, \v2,
	\dur,Prand([4/3],inf),
        \ton, Prand([28],inf),
	\a,Pseq([3],inf),
	\offset,Prand([1,2/3,3/4,4/5,5/6,6/7,7/8,8/9],inf);
)).play(quant:1));

			(2/1).yield});

			 1.do({(g= Pdef(\voice_4, Pbind(\instrument, \v3,
	\dur,Prand([5/4],inf),
        \ton, Prand([28],inf),
	\a,Pseq([2],inf),
	\offset,Prand([1,2/3,3/4,4/5,5/6,6/7,7/8,8/9],inf);
)).play(quant:1));

		1.yield});
	})
);
//////synth

(
(SynthDef(\v3,{
arg ton=220,a=1,pan=1,dur,offset=1,pan1=1,pan2=1;
	var frequency=1, x=0, y=0, gain=1/40, duration=6, bend=(-11),  envelope=1,mul=1,signal=0,
	mono,sound=0,spat=0,azimuth,elevation,tone,space,time,azimuth1,azimuth2;
		ton=ton*12;
	ton=ton+offset;
		5.do{
		x=x+1; y = ((x+a)/x); frequency=(y*ton); mul=(gain/y); duration= (y.squared); bend= (0-duration);
		envelope=EnvGen.kr(Env.perc(0.06,duration*3,1,bend),doneAction:2);
		mono=SinOsc.ar(frequency,mul: mul,phase:3pi/2)*envelope;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
		signal=BLowPass.ar(LFSaw.ar(frequency,iphase:3pi/2,mul:mul),frequency)*envelope;
		sound=sound +mono; spat=spat+signal; sound=sound*envelope; spat=spat*envelope;
	};
	pan1= (MouseX.kr(0.01,1));pan2= (MouseY.kr(0.01,1));pan= Complex(pan1,pan2).magnitude;
	tone = PanAz.ar(3,sound,LFSaw.ar(pan)); Out.ar(16,tone*0.5);
	space = PanAz.ar(3,spat,LFSaw.ar(pan)); Out.ar(19,space);
	elevation = PanAz.ar(2,InFeedback.ar(16),pos:InFeedback.ar(19)); Out.ar(4,elevation);
	azimuth1=PanAz.ar(5,InFeedback.ar(17),pos:InFeedback.ar(20)); Out.ar(6,azimuth1);
	azimuth2=PanAz.ar(5,InFeedback.ar(18),pos:InFeedback.ar(21)); Out.ar(11,azimuth2);
	time = PanAz.ar(2,Mix.new([InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7),InFeedback.ar(8),InFeedback.ar(9),
		InFeedback.ar(10),InFeedback.ar(11),InFeedback.ar(12),InFeedback.ar(13),InFeedback.ar(14),InFeedback.ar(15)]),LFSaw.ar(pan));
	LeakDC.ar(Out.ar(0,time*gain));
}).add);
(SynthDef(\v2,{
arg ton=220,a=1,pan=1,dur,offset=1,pan1=1,pan2=1;
	var frequency=1, x=0, y=0, gain=1/30, duration=6, bend=(-11),  envelope=1,mul=1,signal=0,
	mono,sound=0,spat=0,azimuth,elevation,tone,space,time,azimuth1,azimuth2;
		ton=ton*9;
	ton=ton+offset;
		5.do{
		x=x+1; y = ((x+a)/x); frequency=(y*ton); mul=(gain/y); duration= (y.squared); bend= (0-duration);
		envelope=EnvGen.kr(Env.perc(0.06,duration*3,1,bend),doneAction:2);
		mono=SinOsc.ar(frequency,mul: mul,phase:3pi/2)*envelope;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
		signal=BLowPass.ar(LFSaw.ar(frequency,iphase:3pi/2,mul:mul),frequency)*envelope;
		sound=sound +mono; spat=spat+signal; sound=sound*envelope; spat=spat*envelope;
	};
	pan1= (MouseX.kr(0.01,1));pan2= (MouseY.kr(0.01,1));pan= Complex(pan1,pan2).magnitude;
	tone = PanAz.ar(3,sound,LFSaw.ar(pan)); Out.ar(16,tone*0.5);
	space = PanAz.ar(3,spat,LFSaw.ar(pan)); Out.ar(19,space);
	elevation = PanAz.ar(2,InFeedback.ar(16),pos:InFeedback.ar(19)); Out.ar(4,elevation);
	azimuth1=PanAz.ar(5,InFeedback.ar(17),pos:InFeedback.ar(20)); Out.ar(6,azimuth1);
	azimuth2=PanAz.ar(5,InFeedback.ar(18),pos:InFeedback.ar(21)); Out.ar(11,azimuth2);
	time = PanAz.ar(4,Mix.new([InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7),InFeedback.ar(8),InFeedback.ar(9),
		InFeedback.ar(10),InFeedback.ar(11),InFeedback.ar(12),InFeedback.ar(13),InFeedback.ar(14),InFeedback.ar(15)]),LFSaw.ar(pan));
	LeakDC.ar(Out.ar(0,time*gain));
}).add);


(SynthDef(\v1,{
arg ton=220,a=1,pan=1,dur,offset=1,pan1=1,pan2=1;
	var frequency=1, x=0, y=0, gain=1/20 ,duration=6, bend=(-11),  envelope=1,mul=1,signal=0,
	mono,sound=0,spat=0,azimuth,elevation,tone,space,time,azimuth1,azimuth2;
		ton=ton*8;
	ton=ton+offset;
		5.do{
		x=x+1; y = ((x+a)/x); frequency=(y*ton); mul=(gain/y); duration= (y.squared); bend= (0-duration);
		envelope=EnvGen.kr(Env.perc(0.05,duration*6,1,bend),doneAction:2);
			mono=SinOsc.ar(frequency,mul: mul,phase:3pi/2)*envelope;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
		signal=BLowPass.ar(LFSaw.ar(frequency,iphase:pi/2,mul:mul),frequency)*envelope;
		sound=sound +mono; spat=spat+signal; sound=sound*envelope; spat=spat*envelope;
	};
	pan1= (MouseX.kr(0.01,1));pan2= (MouseY.kr(0.01,1));pan= Complex(pan1,pan2).magnitude;
	tone = PanAz.ar(3,sound,LFSaw.ar(pan)); Out.ar(16,tone*0.5);
	space = PanAz.ar(3,spat,LFSaw.ar(pan)); Out.ar(19,space);
	elevation = PanAz.ar(2,InFeedback.ar(16),pos:InFeedback.ar(19)); Out.ar(4,elevation);
	azimuth1=PanAz.ar(5,InFeedback.ar(17),pos:InFeedback.ar(20)); Out.ar(6,azimuth1);
	azimuth2=PanAz.ar(5,InFeedback.ar(18),pos:InFeedback.ar(21)); Out.ar(11,azimuth2);
	time = PanAz.ar(4,Mix.new([InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7),InFeedback.ar(8),InFeedback.ar(9),
		InFeedback.ar(10),InFeedback.ar(11),InFeedback.ar(12),InFeedback.ar(13),InFeedback.ar(14),InFeedback.ar(15)]),LFSaw.ar(pan));
		LeakDC.ar(Out.ar(0,time*gain));
}).add);

(SynthDef(\v0,{
arg ton=220,a=1,pan=1,dur,offset=1,pan1=1,pan2=1;
	var frequency=1, x=0, y=0, gain=1/10, duration=6, bend=(-11),  envelope=1,mul=1,signal=0,
	mono,sound=0,spat=0,azimuth,elevation,tone,space,time,azimuth1,azimuth2;
		ton=ton*6;
		ton=ton+offset;
		5.do{
		x=x+1; y = ((x+a)/x); frequency=(y*ton); mul=(gain/y); duration= (y.squared); bend= (0-duration);
		envelope=EnvGen.kr(Env.perc(0.05,duration*9,1,bend),doneAction:2);
				mono=SinOsc.ar(frequency,mul: mul,phase:3pi/2)*envelope;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
	signal=BLowPass.ar(LFSaw.ar(frequency,mul:mul),frequency)*envelope;
		sound=sound +mono; spat=spat+signal; sound=sound*envelope; spat=spat*envelope;
	};
	pan1= (MouseX.kr(0.01,1));pan2= (MouseY.kr(0.01,1));pan= Complex(pan1,pan2).magnitude;
	tone = PanAz.ar(3,sound,LFSaw.ar(pan)); Out.ar(16,tone*0.5);
	space = PanAz.ar(3,spat,LFSaw.ar(pan)); Out.ar(19,space);
	elevation = PanAz.ar(2,InFeedback.ar(16),pos:InFeedback.ar(19)); Out.ar(4,elevation);
	azimuth1=PanAz.ar(5,InFeedback.ar(17),pos:InFeedback.ar(20)); Out.ar(6,azimuth1);
	azimuth2=PanAz.ar(5,InFeedback.ar(18),pos:InFeedback.ar(21)); Out.ar(11,azimuth2);
	time = PanAz.ar(4,Mix.new([InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7),InFeedback.ar(8),InFeedback.ar(9),
		InFeedback.ar(10),InFeedback.ar(11),InFeedback.ar(12),InFeedback.ar(13),InFeedback.ar(14),InFeedback.ar(15)]),LFSaw.ar(pan));
	LeakDC.ar(Out.ar(0,time*gain));
}).add)
);
Tdef(\1).play
)