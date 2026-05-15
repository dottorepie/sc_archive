TempoClock.default.tempo_(120/60);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("Blutetooth");
s.options.numOutputBusChannels=32;
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;



(
///////////////////////////////////////////////////////
(SynthDef(\solids,{
	arg ton=220,a=8,dur=2,filter=3,rq=1,monospat,sweep=18;
	var x=0,y=1,freq, envelope,wave,partials=0,bend,bus=1,dur1=0.01, spat,scale=0,octahedron,vectorbus=14,
	elevation_1=1,elevation_2=1,elevation_3=1,elevation_4=1,elevation_5=1,elevation_6=1,elevation_7=1,elevation_8=1,elevation_9=1,elevation_10=1,elevation_11=1,elevation_12=1,elevation_13=1,elevation_14=1,elevation_15=1,elevation_16=1,envelope1,envelope2;
		bend=[2,-3];
	dur=MouseX.kr(0.5,5);
	dur1=MouseY.kr(0.01,6);
	 envelope2=EnvGen.kr(Env.perc(dur1,dur*3,1/3,bend),doneAction:2);
	 envelope1=EnvGen.kr(Env.perc(dur1,dur,1/3,bend),doneAction:2);
	 envelope=EnvGen.kr(Env.perc(dur1,dur,1/2,bend),doneAction:2);
	partials=0;
	ton=ton+1;
8.do{  scale=scale+1 ;spat=scale/(scale+a); vectorbus=vectorbus+2; 4.do{	x=x+1;      y= ((x+a)/x);  freq=(y*ton);
		wave=BLowPass.ar(SinOsc.ar(freq,mul:1/y),ton*filter,rq)*envelope1;
		partials=(partials+wave)*envelope1};
	Out.ar(vectorbus,PanAz.ar(2,partials*envelope1,LFSaw.ar(sweep*spat)))};

	Out.ar(0,InFeedback.ar(16)*elevation_1*envelope);
	Out.ar(1,InFeedback.ar(17)*elevation_2*envelope);
	Out.ar(2,InFeedback.ar(18)*elevation_3*envelope);
	Out.ar(3,InFeedback.ar(19)*elevation_4*envelope);
	Out.ar(4,InFeedback.ar(20)*elevation_5*envelope);
	Out.ar(5,InFeedback.ar(21)*elevation_6*envelope);
	Out.ar(6,InFeedback.ar(22)*elevation_7*envelope);
	Out.ar(7,InFeedback.ar(23)*elevation_8*envelope);
	Out.ar(8,InFeedback.ar(24)*elevation_9*envelope);
	Out.ar(9,InFeedback.ar(25)*elevation_10*envelope);
	Out.ar(10,InFeedback.ar(26)*elevation_11*envelope);
	Out.ar(11,InFeedback.ar(27)*elevation_12*envelope);
	Out.ar(12,InFeedback.ar(28)*elevation_13*envelope);
	Out.ar(13,InFeedback.ar(29)*elevation_14*envelope);
	Out.ar(14,InFeedback.ar(30)*elevation_15*envelope);
	Out.ar(15,InFeedback.ar(31)*elevation_16*envelope);
}).add
);


((f= Pdef(\pat1, Pbind(\instrument, \solids,
	\dur,Prand([1,1/2],inf),
           \ton, 330,
			\a,Pseq([2,5,3,4,5,3,4,5,6,8,6,7,5,6,4],inf),
			\elevation_1,Pexprand(1/18,1,inf),
			\elevation_2,Pexprand(1/18,1,inf),
			\elevation_3,Pexprand(1/18,1,inf),
			\elevation_4,Pexprand(1/18,1,inf),
			\elevation_5,Pexprand(1/18,1,inf),
			\elevation_6,Pexprand(1/18,1,inf),
		    \elevation_7,Pexprand(1/18,1,inf),
			\elevation_8,Pexprand(1/18,1,inf),
			\elevation_9,Pexprand(1/18,1,inf),
			\elevation_10,Pexprand(1/18,1,inf),
			\elevation_11,Pexprand(1/18,1,inf),
			\elevation_12,Pexprand(1/18,1,inf),
		\elevation_13,Pexprand(1/18,1,inf),
			\elevation_14,Pexprand(1/18,1,inf),
			\elevation_15,Pexprand(1/18,1,inf),
			\elevation_16,Pexprand(1/18,1,inf),
)).play(quant:1));

		)
)
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
