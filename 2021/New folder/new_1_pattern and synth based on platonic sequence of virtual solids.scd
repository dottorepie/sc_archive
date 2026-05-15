(a= Pdef(\voice_1, Pbind(\instrument, \r0,
	\dur,Prand([1,2,3],inf),
	\fundamental,Prand([6,8,9,12],inf),
	\a,Prand([1,2,3,4],inf);

)).play(quant:1))

/////////////////////////////synth
(SynthDef(\r0,{
	arg t=1,fundamental=330,xy=1,y=1,z=1,a=1;
	var frequency=1, x=0, y1=0,y2=0, gain=1, duration=6, bend=(-3),  envelope=1, signalo=0,mul=1,signalo=0;
	signal, sound, dual,elevationcube,upcube,downcube,azocta1,azocta2,azocta3,azocta4,azocta5,azocta6,azocta7,azocta8;
	fundamental=fundamental*666;
	4.do{
		//bus=bus+2;
		x=x+1;
		y1 = ((x+a)/x);
		frequency=(fundamental/y1);
		y2 = ((gain+x)/gain);
		mul=(gain/y2);
		theta = ((Complex(y2,y1).abs)+x)/(Complex(y2,y1).abs);
		duration=theta*2;
		envelope=EnvGen.kr(Env.sine(duration),doneAction:2);
		signal=SinOsc.ar(frequenc,mul: mul)*envelope;
		dual = PanAz.ar(4,signal,LFSaw.ar(elevationcube))*envelope;
		signalo=signalo +spat;
		signalo = signalo*envelope;
	};
	Out.ar(14,signalo);
	upcube= PanAz.ar(4,InFeedback.ar(14),pos:LFSaw.ar());
	downcube= PanAz.ar(4,InFeedback.ar(15),pos:LFSaw.ar());
	Out.ar(6,upcube);
	Out.ar(10,downcube);
	azocta1= PanAz.ar(6,InFeedback.ar(6),pos:LFSaw.ar());
	azocta2= PanAz.ar(6,InFeedback.ar(7),pos:LFSaw.ar());
	azocta3= PanAz.ar(6,InFeedback.ar(8),pos:LFSaw.ar());
	azocta4= PanAz.ar(6,InFeedback.ar(9),pos:LFSaw.ar());
	azocta5= PanAz.ar(6,InFeedback.ar(10),pos:LFSaw.ar());
	azocta6= PanAz.ar(6,InFeedback.ar(11),pos:LFSaw.ar());
	azocta7= PanAz.ar(6,InFeedback.ar(12),pos:LFSaw.ar());
	azocta8= PanAz.ar(6,InFeedback.ar(13),pos:LFSaw.ar());
	Out.ar(0,azocta1);
	Out.ar(0,azocta2);
	Out.ar(0,azocta3);
	Out.ar(0,azocta4);
	Out.ar(0,azocta5);
	Out.ar(0,azocta6);
	Out.ar(0,azocta7);
	Out.ar(0,azocta8);
}).add)


k.free;
k = Synth.new(\r0);
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("SAMSUNG");
s.options.numOutputBusChannels=58;

////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
(a= Pdef(\voice_1, Pbind(\instrument, \r0,
	\dur,Prand([1,2,3],inf),
	\fundamental,Prand([6,8,9,12],inf),
	\a,Prand([1,2,3,4],inf),
	\dodecaheder,Prand([1,2,3],inf),
	\vector1,Prand([1,2,3],inf),
	\vector2,Prand([1,2,3],inf),
	\vector3,Prand([1,2,3],inf),
	\vector4,Prand([1,2,3],inf),
	\vector5,Prand([1,2,3],inf),
	\vector6,Prand([1,2,3],inf),
	\vector7,Prand([1,2,3],inf),
	\vector8,Prand([1,2,3],inf),
	\vector9,Prand([1,2,3],inf),
	\vector10,Prand([1,2,3],inf),
	\vector11,Prand([1,2,3],inf),
	\vector12,Prand([1,2,3],inf);


)).play(quant:1))

/////////////////////////////synth
(SynthDef(\r0,{
	arg t=1,fundamental=2,xy=1,y=1,z=1,a=1,vector1=1,vector2=1,vector3=1,vector4=1,vector5=1,vector6=1,vector7=1,vector8=1,vector9=1,vector10=1,vector11=1,vector12=1,dodecaheder=1;
	var frequency=1, x=0, y1=0,y2=0, gain=1, duration=6, bend=(-3),  envelope=1,mul=1,signal=0,
	sound, dual,icosaeder,azocta1,azocta2,azocta3,azocta4,azocta5,azocta6,azocta7,azocta8,azocta9,azocta10,azocta11,azocta12,point,
	vertice1,vertice2,vertice3,vertice4,vertice5,vertice6,vertice7,vertice8,vertice9,vertice10,vertice11,vertice12;
	fundamental=fundamental*100;
	12.do{
		//bus=bus+2;
		x=x+1;
		y1 = ((x+a)/x);
		frequency=(fundamental/y1);
		y2 = ((gain+x)/gain);
		mul=(gain/y2);
		duration= y1*4;
		icosaeder= duration;
		envelope=EnvGen.kr(Env.sine(duration),doneAction:2);
		sound=SinOsc.ar(frequency,mul: mul)*envelope;
		dual = PanAz.ar(12,sound,LFSaw.ar(icosaeder))*envelope;
		signal=signal +dual;
		signal = signal*envelope;
	};
	Out.ar(46,signal);
	azocta1= PanAz.ar(4,InFeedback.ar(46),pos:LFSaw.ar(dodecaheder));
	azocta2= PanAz.ar(4,InFeedback.ar(47),pos:LFSaw.ar(dodecaheder));
	azocta3= PanAz.ar(4,InFeedback.ar(48),pos:LFSaw.ar(dodecaheder));
	azocta4= PanAz.ar(4,InFeedback.ar(49),pos:LFSaw.ar(dodecaheder));
	azocta5= PanAz.ar(4,InFeedback.ar(50),pos:LFSaw.ar(dodecaheder));
	azocta6= PanAz.ar(4,InFeedback.ar(51),pos:LFSaw.ar(dodecaheder));
	azocta7= PanAz.ar(4,InFeedback.ar(52),pos:LFSaw.ar(dodecaheder));
	azocta8= PanAz.ar(4,InFeedback.ar(53),pos:LFSaw.ar(dodecaheder));
	azocta9= PanAz.ar(4,InFeedback.ar(54),pos:LFSaw.ar(dodecaheder));
	azocta10= PanAz.ar(4,InFeedback.ar(55),pos:LFSaw.ar(dodecaheder));
	azocta11= PanAz.ar(4,InFeedback.ar(56),pos:LFSaw.ar(dodecaheder));
	azocta12= PanAz.ar(4,InFeedback.ar(57),pos:LFSaw.ar(dodecaheder));
	Out.ar(1,azocta1);
	Out.ar(5,azocta2);
	Out.ar(9,azocta3);
	Out.ar(13,azocta4);
	Out.ar(17,azocta5);
	Out.ar(21,azocta6);
	Out.ar(25,azocta1);
	Out.ar(29,azocta2);
	Out.ar(33,azocta3);
	Out.ar(37,azocta4);
	Out.ar(41,azocta5);
	Out.ar(45,azocta6);
	vertice1= PanAz.ar(8,InFeedback.ar(1),vector1);
	vertice2=PanAz.ar(8,InFeedback.ar(5),vector2);
	vertice3=PanAz.ar(8,InFeedback.ar(9),vector3);
	vertice4=PanAz.ar(8,InFeedback.ar(13),vector4);
	vertice5=PanAz.ar(8,InFeedback.ar(17),vector5);
	vertice6=PanAz.ar(8,InFeedback.ar(21),vector6);
	vertice7=PanAz.ar(8,InFeedback.ar(25),vector7);
	vertice8=PanAz.ar(8,InFeedback.ar(29),vector8);
	vertice9=PanAz.ar(8,InFeedback.ar(33),vector9);
	vertice10=PanAz.ar(8,InFeedback.ar(37),vector10);
	vertice11=PanAz.ar(8,InFeedback.ar(41),vector11);
	vertice12=PanAz.ar(8,InFeedback.ar(45),vector12);
		Out.ar(0,vertice1);
	Out.ar(0,vertice2);
	Out.ar(0,vertice3);
	Out.ar(0,azocta4);
	Out.ar(0,vertice5);
	Out.ar(0,azocta6);
	Out.ar(0,vertice7);
	Out.ar(0,vertice8);
	Out.ar(0,vertice9);
	Out.ar(0,vertice10);
	Out.ar(0,vertice11);
	Out.ar(0,vertice12);
}).add)