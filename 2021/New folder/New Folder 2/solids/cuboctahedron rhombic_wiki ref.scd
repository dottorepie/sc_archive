TempoClock.default.tempo_(120/60);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("Blutetooth");
s.options.numOutputBusChannels=48;
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;



(
///////////////////////////////////////////////////////
(SynthDef(\solids,{
	arg ton=220,a=8,dur=2,filter=3,rq=1,monospat,sweep=18;
	var x=0,y=1,freq, envelope,wave,partials=0,bend,bus=1,dur1=0.01, spat,scale=0,octahedron,vectorbus=20,
	elevation_1=1,elevation_2=1,elevation_3=1,elevation_4=1,elevation_5=1,elevation_6=1,elevation_7=1,elevation_8=1,elevation_9=1,elevation_10=1,elevation_11=1,elevation_12=1,elevation_13=1,elevation_14=1,elevation_15=1,elevation_16=1,elevation_17=1,elevation_18=1,elevation_19=1,elevation_20=1,elevation_21=1,elevation_22=1,elevation_23=1,elevation_24=1,
	envelope1,envelope2;
		bend=[2,-3];
	dur=MouseX.kr(1,18);
	dur1=MouseY.kr(0.01,6);

	 envelope1=EnvGen.kr(Env.perc(dur1,dur,1/1,bend),doneAction:2);
	partials=0;
	ton=ton+1;
6.do{  scale=scale+1 ;spat=scale/(scale+a); vectorbus=vectorbus+4;
		4.do{	x=x+1;      y= ((x+a)/x);  freq=(y*ton);
		wave=BLowPass.ar(SinOsc.ar(freq,mul:1/y),ton*filter,rq)*envelope1;
		partials=(partials+wave)*envelope1};
	Out.ar(vectorbus,PanAz.ar(4,partials*envelope1,LFSaw.ar(sweep*spat)))};

	Out.ar(0,InFeedback.ar(24)*elevation_1*envelope);
	Out.ar(1,InFeedback.ar(25)*elevation_2*envelope);
	Out.ar(2,InFeedback.ar(26)*elevation_3*envelope);
	Out.ar(3,InFeedback.ar(27)*elevation_4*envelope);
	Out.ar(4,InFeedback.ar(28)*elevation_5*envelope);
	Out.ar(5,InFeedback.ar(29)*elevation_6*envelope);
	Out.ar(6,InFeedback.ar(30)*elevation_7*envelope);
	Out.ar(7,InFeedback.ar(31)*elevation_8*envelope);
	Out.ar(8,InFeedback.ar(32)*elevation_9*envelope);
	Out.ar(9,InFeedback.ar(33)*elevation_10*envelope);
	Out.ar(10,InFeedback.ar(34)*elevation_11*envelope);
	Out.ar(11,InFeedback.ar(35)*elevation_12*envelope);
	Out.ar(12,InFeedback.ar(36)*elevation_13*envelope);
	Out.ar(13,InFeedback.ar(37)*elevation_14*envelope);
	Out.ar(14,InFeedback.ar(38)*elevation_15*envelope);
	Out.ar(15,InFeedback.ar(39)*elevation_16*envelope);
	Out.ar(16,InFeedback.ar(40)*elevation_17*envelope);
	Out.ar(17,InFeedback.ar(41)*elevation_18*envelope);
	Out.ar(18,InFeedback.ar(42)*elevation_19*envelope);
	Out.ar(19,InFeedback.ar(43)*elevation_20*envelope);
	Out.ar(20,InFeedback.ar(44)*elevation_21*envelope);
	Out.ar(21,InFeedback.ar(45)*elevation_22*envelope);
	Out.ar(22,InFeedback.ar(46)*elevation_23*envelope);
	Out.ar(23,InFeedback.ar(47)*elevation_24*envelope);
}).add
);


((f= Pdef(\pat1, Pbind(\instrument, \solids,
	\dur,1
           \ton, 220,
	\a,Prand([1,12,2,3,4,5,6,7,8,9,10,11],inf),
			\elevation_1,Pexprand(1/24,1,inf),
			\elevation_2,Pexprand(1/24,1,inf),
			\elevation_3,Pexprand(1/24,1,inf),
			\elevation_4,Pexprand(1/24,1,inf),
			\elevation_5,Pexprand(1/24,1,inf),
			\elevation_6,Pexprand(1/24,1,inf),
		    \elevation_7,Pexprand(1/24,1,inf),
			\elevation_8,Pexprand(1/24,1,inf),
			\elevation_9,Pexprand(1/24,1,inf),
			\elevation_10,Pexprand(1/24,1,inf),
			\elevation_11,Pexprand(1/24,1,inf),
			\elevation_12,Pexprand(1/24,1,inf),
	       \elevation_13,Pexprand(1/24,1,inf),
			\elevation_14,Pexprand(1/24,1,inf),
			\elevation_15,Pexprand(1/24,1,inf),
			\elevation_16,Pexprand(1/24,1,inf),
	       \elevation_17,Pexprand(1/24,1,inf),
			\elevation_18,Pexprand(1/24,1,inf),
			\elevation_19,Pexprand(1/24,1,inf),
			\elevation_20,Pexprand(1/24,1,inf),
	       \elevation_21,Pexprand(1/24,1,inf),
			\elevation_22,Pexprand(1/24,1,inf),
			\elevation_23,Pexprand(1/24,1,inf),
			\elevation_24,Pexprand(1/24,1,inf),
)).play(quant:1));

		)
)
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
