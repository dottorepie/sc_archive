TempoClock.default.tempo_(120/120);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=24;
s.options.memSize = 65536
s.options.numInputBusChannels=0;

g.stop
(
(g= Pdef(\voice_3, Pbind(\instrument, \v3,
	\dur,Prand([1],inf),
        \ton, Prand([220,110,440],inf),
	\a,Pseq([2,3],inf),
	\offset,Prand([1,2/3,3/4,4/5,5/6,6/7,7/8,8/9],inf);
)).play(quant:1));


(SynthDef(\v3,{
arg ton=220,a=1,dur,offset=1,pan1=1,pan2=1;
	var frequency1=1, x1=0, y1=0, gain1=2, duration1=6,  envelope1=1,mul1=1,spat1=0, stereo=0, dual=0, sound=0,azimuth1,azimuth2,mono,
	      frequency2=1, x2=0, y2=0, gain2=2, duration2=6,  envelope2=1,mul2=1,spat2=0,signal1,elevation,audio,
	      frequency3=1, x3=0, y3=0, gain3=2, duration3=6,  envelope3=1,mul3=1,spat3=0,elevation1=0,quad1=0,signal2,audio1,okt1,
	      frequency4=1, x4=0, y4=0, gain4=2, duration4=6,  envelope4=1,mul4=1,spat4=0,elevation2=0,quad2=0,signal3,audio2,okt2;

		pan1=MouseX.kr(0.1,4);
	pan2=MouseY.kr(0.1,4);
	ton=ton;
	//ton=ton+offset;
		2.do{
		x1=x1+1;
		y1= ((x1+a)/x1);
		frequency1=(y1*ton);
		mul1=(gain1/y1);
		duration1= (y1.cubed);
		envelope1=EnvGen.kr(Env.sine(duration1,1),doneAction:2);
		mono=SinOsc.ar(frequency1,mul: mul1,phase:3pi/2)*envelope1;
		//mono=PitchShift.ar(SoundIn.ar(0,1),0.2,y,mul:mul)*envelope;
		sound=sound +mono; sound=sound*envelope1;
	};
	Out.ar(22,sound);

	3.do{
		x2=x2+1;
	y2 = ((x2+a)/x2).postln;
	mul2=(gain2/y2);
	duration2= (y2.cubed);
	 frequency2=(y2*ton);
	envelope2=EnvGen.kr(Env.sine(duration2),doneAction:2);
		stereo = PitchShift.ar(InFeedback.ar(22),1/2,y2,mul:mul2);
	stereo = stereo +dual; stereo=stereo*envelope2;
		signal1=BLowPass.ar(LFSaw.ar(frequency2,mul:mul2))*envelope2;
		spat1=spat1+signal1; spat1=spat1*envelope2;
	};
	elevation = PanAz.ar(2,spat1,LFSaw.ar(pan1));
	Out.ar(20,elevation);
	audio = PanAz.ar(2,stereo,LFSaw.ar(pan2));
	Out.ar(18,audio);

	4.do{
		x3=x3+1;
	y3 = ((x3+a)/x3).postln;
	mul3=(gain3/y3);
	duration3= (y3.cubed);
	 frequency3=(y3*ton);
	envelope3=EnvGen.kr(Env.sine(duration3),doneAction:2);
		quad1 = PitchShift.ar(InFeedback.ar(6),1/2,y3,mul:mul3);
	elevation1 = elevation1 +quad1; elevation1=elevation1*envelope3;
		signal2=BLowPass.ar(LFSaw.ar(frequency3,mul:mul3))*envelope3;
		spat2=spat2+signal2; spat2=spat2*envelope3;
	};
	azimuth1=PanAz.ar(3,InFeedback.ar(18),pos:InFeedback.ar(20));
	Out.ar(15,azimuth1);

		4.do{
		x4=x4+1;
	y4 = ((x4+a)/x4).postln;
	mul4=(gain4/y4);
	duration4= (y4.cubed);
	 frequency4=(y4*ton);
	envelope4=EnvGen.kr(Env.sine(duration4),doneAction:2);
		quad2 = PitchShift.ar(InFeedback.ar(6),1/2,y4,mul:mul4);
		elevation2 = elevation2 +quad2; elevation2=elevation2*envelope4;
		signal3=BLowPass.ar(LFSaw.ar(frequency4,mul:mul4))*envelope4;
		spat3=spat3+signal3; spat3=spat3*envelope4;
	};
	azimuth2=PanAz.ar(3,InFeedback.ar(19),pos:InFeedback.ar(21));
	Out.ar(12,azimuth2);

	okt1=PanAz.ar(4,InFeedback.ar(13),0);
	okt2=PanAz.ar(4,InFeedback.ar(16),0);
	Out.ar(0,InFeedback.ar(12));
	Out.ar(1,okt1);
	Out.ar(5,InFeedback.ar(14));
	Out.ar(6,InFeedback.ar(15));
	Out.ar(7,okt2);
	Out.ar(11,InFeedback.ar(17));


}).add)
)
g.stop
